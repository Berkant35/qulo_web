

part of 'profil_drawer.dart';


mixin ProfileDrawerMixin on ConsumerState<ProfileDrawer> {
  List<Widget> drawerItems(WidgetRef ref) {
    return [
      drawerPerButton(
          ref,
              (ref) => NavigationService.instance
              .navigateToPage(path: NavigationConstants.integrationMenuPage),
          Icons.link,
          S.current.drawer_integrations),
      drawerPerButton(
          ref,
              (ref) => NavigationService.instance
              .navigateToPage(path: NavigationConstants.languageSettingsPage),
          Icons.language,
          S.current.language,
          svgIcon: null),
      drawerPerButton(
          ref,
              (ref) => NavigationService.instance
              .navigateToPage(path: NavigationConstants.settingsPage),
          Icons.settings,
          S.current.settings
      ),
      drawerPerButton(
          ref,
              (ref) => NavigationService.instance
              .navigateToPage(path: NavigationConstants.contactUsPage),
          Icons.contact_support,
          isNeedTransfer: false,
          S.current.drawer_contact_support
      ),
      drawerPerButton(
          ref,
              (ref) => BasicDialogs.sureExitDialog(ref),
          Icons.exit_to_app_sharp,
          S.current.sign_out,
          svgIcon: IconPaths.icExit.customSvgIcon()
      ),
    ];
  }

  signOut(WidgetRef ref) => ref.read(authManager.notifier).signOut();

  Widget drawerPerButton(WidgetRef ref, Function(WidgetRef ref) function,
      IconData iconData, String text,
      {SvgPicture? svgIcon,bool isNeedTransfer = true}) {
    return Padding(
      padding: EdgeInsets.only(right: 5.w),
      child: TextButton.icon(
          onPressed: () => function(ref),
          icon: Transform.rotate(
            //180 degree
              angle: isNeedTransfer ? 3.14 : 0,
              child: svgIcon ??
                  Icon(
                    iconData,
                    size: 4.h,
                    color: Colors.white,
                  )),
          label: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: ThemeValueExtension.subtitle
                .copyWith(fontWeight: FontWeight.w500, color: Colors.white),
          )),
    );
  }

  // Show plan infos


}