import 'package:audiotodo/core/navigation/navigation_constants.dart';
import 'package:audiotodo/main.dart';
import 'package:audiotodo/ui/authentication/auth_forgot_password.dart';
import 'package:audiotodo/ui/authentication/auth_login.dart';
import 'package:audiotodo/ui/authentication/auth_register.dart';
import 'package:audiotodo/ui/base/main_base.dart';
import 'package:audiotodo/ui/base/shares/clickup/click_up_create_task.dart';
import 'package:audiotodo/ui/base/shares/clickup/click_up_select_folder_page.dart';
import 'package:audiotodo/ui/base/shares/clickup/click_up_select_list_of_folder_page.dart';
import 'package:audiotodo/ui/base/shares/clickup/click_up_select_space_page.dart';
import 'package:audiotodo/ui/base/shares/clickup/click_up_select_team_page.dart';
import 'package:audiotodo/ui/base/shares/files/pdf/pdf_view_and_share.dart';
import 'package:audiotodo/ui/base/shares/files/prepare_file_page.dart';
import 'package:audiotodo/ui/menu/contact/contact_us_page.dart';
import 'package:audiotodo/ui/menu/integrations/clickup/clickup_integration.dart';
import 'package:audiotodo/ui/menu/integrations/integration_widgets/help_connection_to_click_up.dart';
import 'package:audiotodo/ui/menu/integrations/jira/jira-software/jira-software_integration.dart';
import 'package:audiotodo/ui/menu/language/setting_language_menu.dart';
import 'package:audiotodo/ui/menu/settings/delete_account.dart';
import 'package:audiotodo/ui/menu/settings/settings_page.dart';
import 'package:audiotodo/ui/privacy/privacy_policy.dart';
import 'package:audiotodo/ui/subscriptions/subscription_base.dart';
import 'package:audiotodo/utilities/components/form_fields/complex_inherited.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../ui/base/parts/meets_parts/meet_detail/meet_detail_base.dart';
import '../../ui/base/shares/jira/jira-software/jira_software_create_task_page.dart';
import '../../ui/base/shares/jira/jira-software/jira_software_projects_page.dart';
import '../../ui/menu/integrations/integration_menu.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();

  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.authLoginPage:
        return normalNavigate(const AuthLogin());
      case NavigationConstants.authRegisterPage:
        return normalNavigate(const AuthRegisterPage());
      case NavigationConstants.mainBase:
        return normalNavigate(ShowCaseWidget(
          onStart: (index, key) {},
          onComplete: (index, key) {},
          blurValue: 0,
          builder: (context) {
            return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                    textScaler: MediaQuery.of(context)
                        .textScaler
                        .clamp(minScaleFactor: 1, maxScaleFactor: 1.2)),
                child: const MainBase());
          },
          autoPlayDelay: const Duration(seconds: 1),
        ));
      case NavigationConstants.authForgotPasswordPage:
        return normalNavigate(const AuthForgotPasswordPage());
      case NavigationConstants.languageSettingsPage:
        return normalNavigate(const SettingsLanguageMenu());
      case NavigationConstants.integrationMenuPage:
        return normalNavigate(const IntegrationMenu());
      case NavigationConstants.clickUpIntegrationPage:
        return normalNavigate(
            ComplexInherited(child: const ClickUpIntegration()));
      case NavigationConstants.privacyPolicyPage:
        return normalNavigate(const PrivacyPolicy());
      case NavigationConstants.jiraSoftwareIntegrationPage:
        return normalNavigate(
            ComplexInherited(child: const JiraSoftwareIntegration()));
      case NavigationConstants.prepareMicrosoftFilePage:
        return normalNavigate(const PrepareFilePage());
      case NavigationConstants.pdfViewAndSharePage:
        return normalNavigate(const PdfViewAndShare());
      case NavigationConstants.settingsPage:
        return normalNavigate(const SettingsPage());
      case NavigationConstants.contactUsPage:
        return normalNavigate(const ContactUsPage());
      case NavigationConstants.deleteAccountPage:
        return normalNavigate(const DeleteAccount());
      case NavigationConstants.clickUpSelectTeamPage:
        return normalNavigate(const ClickUpSelectTeamPage());
      case NavigationConstants.clickUpSelectSpacePage:
        return normalNavigate(const ClickUpSelectSpacePage());
      case NavigationConstants.clickUpSelectFolderPage:
        return normalNavigate(const ClickUpSelectFolderPage());
      case NavigationConstants.clickUpSelectListOfFolderPage:
        return normalNavigate(const ClickUpSelectListOfFolderPage());
      case NavigationConstants.clickUpCreateTaskPage:
        return normalNavigate(const ClickUpCreateTask());
      case NavigationConstants.jiraSoftwareProjectsPage:
        return normalNavigate(const JiraSoftwareProjectsPage());
      case NavigationConstants.jiraSoftwareCreateTaskPage:
        return normalNavigate(const JiraSoftwareCreateTaskPage());
      case NavigationConstants.helpIntegrationPage:
        return normalNavigate(const HelpIntegration());
      case NavigationConstants.meetDetailBase:
        return normalNavigate(const MeetDetailBase());
      case NavigationConstants.subscriptionPage:
        return normalNavigate(const SubscriptionBase());
      default:
        return MaterialPageRoute(
          builder: (context) => const AudioToDo(),
        );
    }
  }

  PageRouteBuilder normalNavigate(Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionDuration: Duration.zero, // No transition duration
      reverseTransitionDuration:
          Duration.zero, // No reverse transition duration
    );
  }
}
