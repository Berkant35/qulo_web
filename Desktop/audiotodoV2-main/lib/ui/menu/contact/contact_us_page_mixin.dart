part of 'contact_us_page.dart';

mixin ContactUsPageMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  final _formKey = GlobalKey<FormState>();

  final _messageController = TextEditingController();
  ProblemType? _selectedProblemType;
  ValueNotifier<bool> isLoading = ValueNotifier(false);


  Future<void> submitForm() async {
    isLoading.value = true;
    isLoading.notifyListeners();
    if (_formKey.currentState?.validate() ?? false) {
      final res = await ref.read(currentHerokuManager.notifier).contactUs(
          ref.read(authManager)!.email!,
          _messageController.text,
          _selectedProblemType!,
          ref);
      if (res) {
        ScaffoldMessenger.of(
                NavigationService.instance.navigatorKey.currentState!.context)
            .showSnackBar(
          SnackBar(
              content: Text(
            S.current.thank_you_for_contacting_us,
            style: ThemeValueExtension.subtitle,
          )),
        );
        _clearForm();
      } else {
        BasicDialogs.dontChangeAnythingDialog(ref);
      }
    }
    isLoading.value = false;
    isLoading.notifyListeners();
  }

  void _clearForm() {
    _messageController.clear();
    _selectedProblemType = null;
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
