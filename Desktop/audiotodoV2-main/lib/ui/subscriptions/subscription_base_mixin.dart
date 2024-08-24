part of 'subscription_base.dart';

mixin SubscriptionBaseMixin on ConsumerState<SubscriptionBase> {
  late TabController tabController;
  List<StoreProduct> storeProducts = [];

  @override
  void dispose() {
    tabController.removeListener(_handleTabSelection);
    tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  Column proPlan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleOfPlan("Pro Plan"),
        _subscriptionTile(S.current.subscription_content_pro_one, true),
        _subscriptionTile(S.current.subscription_content_pro_five, true),
        _subscriptionTile(S.current.subscription_content_pro_two, true),
        _subscriptionTile(S.current.subscription_content_pro_three, true),
        _subscriptionTile(S.current.subscription_content_pro_four, true),
      ],
    );
  }

  Column basicPlan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleOfPlan("Basic Plan"),
        _subscriptionTile(S.current.subscription_content_basic_one, true),
        _subscriptionTile(S.current.subscription_content_basic_five, true),
        _subscriptionTile(S.current.subscription_content_pro_two, true),
        _subscriptionTile(S.current.subscription_content_pro_three, true),
        _subscriptionTile(S.current.subscription_content_pro_four, true),
      ],
    );
  }

  Padding _titleOfPlan(String titleOfPlan) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        titleOfPlan,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _subscriptionTile(String title, bool isChecked) {
    return ListTile(

      leading: Icon(isChecked ? Icons.check : Icons.close,
          color:
              isChecked ? CustomColors.primaryColor : CustomColors.errorColor),
      title: Text(title,style: Theme.of(context).textTheme.titleSmall,),
    );
  }

  Future<void> getAllProducts() async {
    storeProducts = await Purchases.getProducts(
        ProductPlans.values.map((e) => dotenv.env[e.name]!).toList());
  }

  Future<bool> subscriptionYearly({required PlanType planType}) async {
    CustomerInfo customerInfo = await Purchases.getCustomerInfo();
    final currentPlanType = planType == PlanType.basic
        ? ProductPlans.BASIC_PLAN_YEARLY.name
        : ProductPlans.PRO_PLAN_YEARLY.name;

    // final currentPlanId = dotenv.env[currentPlanType];
    // if (customerInfo.activeSubscriptions.toList().contains(currentPlanId)) {
    //   showAlreadySubscription();
    //   return true;
    // }

    if (storeProducts.isEmpty) await getAllProducts();

    //TODO THROW EXCEPTION AND SHOW POP-UP SOMETHING WENT WRONG
    if (storeProducts.isEmpty) return false;

    StoreProduct currentStoreProduct;

    currentStoreProduct = storeProducts.firstWhere((element) =>
        element.identifier ==
        dotenv.env[currentPlanType]);

    await buySubscription(currentStoreProduct, currentPlanType, planType);

    return true;
  }

  void showAlreadySubscription() {
    BasicDialogs.customBasicShowDialog(
        ref: ref,
        title: 'Already Subscription!',
        dialogType: DialogType.info,
        content: ''
            'You already have a subscription. Please cancel your current subscription to buy a new one.');
  }

  Future<bool> subscriptionMonthly({required PlanType planType}) async {
    CustomerInfo customerInfo = await Purchases.getCustomerInfo();
    final currentPlanType = planType == PlanType.basic
        ? ProductPlans.BASIC_PLAN_MONTHLY.name
        : ProductPlans.PRO_PLAN_MONTHLY.name;

    final currentPlanId = dotenv.env[currentPlanType];
    // logger.i('${currentPlanId!} ${customerInfo.activeSubscriptions}');
    // // if (customerInfo.activeSubscriptions.toList().contains(currentPlanId)) {
    // //   showAlreadySubscription();
    // //   return true;
    // // }

    if (storeProducts.isEmpty) await getAllProducts();

    //TODO THROW EXCEPTION AND SHOW POP-UP SOMETHING WENT WRONG
    if (storeProducts.isEmpty) return false;
    StoreProduct currentStoreProduct;

    currentStoreProduct = storeProducts
        .firstWhere((element) => element.identifier == currentPlanId);

    await buySubscription(currentStoreProduct, currentPlanType, planType);

    return true;
  }

  Future<bool> buySubscription(StoreProduct currentStoreProduct,
      String planName, PlanType planType) async {
    // Show Circular Progress
    //TODO SHOW CIRCULAR PROGRESS
    DialogShower.init(context);
    DialogShower shower = DialogShower()
      ..barrierDismissible = false
      ..containerShadowColor = Colors.grey
      ..containerShadowBlurRadius = 50.0
      ..containerBorderRadius = 5.0;

    shower.show(const CircularProgressIndicator.adaptive());

    try {
      final currentCI =
          await Purchases.purchaseStoreProduct(currentStoreProduct);

      if (currentCI.activeSubscriptions
          .contains(currentStoreProduct.identifier)) {

        ref.read(currentPlanControlNotifier.notifier)
            .changState(planType);

        ref
            .read(currentPlanControlNotifier.notifier)
            .subscriptionAfterUpdate(ref, planName);

        return true;
      }
    } on PlatformException catch (_, e) {
      PurchaseExceptions.handlePurchaseExceptions(_.message ?? "-", ref,
          subCollectionName: 'buy_subscription_error', dialogShower: shower);
      shower.dismiss();
      return false;
    } finally {
      shower.dismiss();
    }

    return true;
  }
}
