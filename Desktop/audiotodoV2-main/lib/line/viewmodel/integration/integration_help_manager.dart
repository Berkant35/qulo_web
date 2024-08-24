import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:photo_view/photo_view.dart';

import '../../../core/theme/custom_colors.dart';
import '../../../generated/l10n.dart';
import '../../../utilities/components/bars/app_bars/basic_back_app_bar.dart';
import '../../../utilities/constants/custom_assets/asset_paths.dart';
import '../../../utilities/constants/enums/integration/todo_platforms.dart';
import '../../../utilities/constants/extensions/context_extension.dart';

class HelpIntegrationControlNotifier extends StateNotifier<TodoPlatforms>{
  HelpIntegrationControlNotifier(TodoPlatforms state) : super(TodoPlatforms.none);

  List<PageViewModel> currentPageViewModels = [];
  String titleOfIntegration = "";

  void changState(TodoPlatforms val,WidgetRef ref) {

    state = val;

    switch(state){
      case TodoPlatforms.clickUp:

        currentPageViewModels = <PageViewModel>[
          HelpIntegrationUtilities.perPageViewModel(
              S.current.integration_click_up_step_one_title,
              S.current.integration_click_up_step_one_explain,
              AssetPaths.apiKeyOnBoardingClickUpOne,
              ref.context),
          HelpIntegrationUtilities.perPageViewModel(
              S.current.integration_click_up_step_two_title,
              S.current.integration_click_up_step_two_explain,
              AssetPaths.apiKeyOnBoardingClickUpTwo,
              ref.context),
          HelpIntegrationUtilities.perPageViewModel(
              S.current.integration_click_up_step_three_title,
              S.current.integration_click_up_step_three_explain,
              AssetPaths.apiKeyOnBoardingClickUpThree,
              ref.context),
        ];

        titleOfIntegration = S.current.integration_click_up_api_key;

      case TodoPlatforms.slack:
        // TODO: Handle this case.
      case TodoPlatforms.jira:
        // TODO: Handle this case.
      case TodoPlatforms.jiraSoftware:

      currentPageViewModels = <PageViewModel>[
        HelpIntegrationUtilities.perPageViewModel(
            S.current.integration_jira_software_step_one_title,
            S.current.integration_jira_software_step_one_explain,
            AssetPaths.apiKeyOnBoardingJiraSoftwareOne,
            ref.context),
        HelpIntegrationUtilities.perPageViewModel(
            S.current.integration_jira_software_step_two_title,
            S.current.integration_jira_software_step_two_explain,
            AssetPaths.apiKeyOnBoardingJiraSoftwareTwo,
            ref.context),
        HelpIntegrationUtilities.perPageViewModel(
            S.current.integration_jira_software_step_three_title,
            S.current.integration_jira_software_step_three_explain,
            AssetPaths.apiKeyOnBoardingJiraSoftwareThree,
            ref.context),
        HelpIntegrationUtilities.perPageViewModel(
            S.current.integration_jira_software_step_four_title,
            S.current.integration_jira_software_step_four_explain,
            AssetPaths.apiKeyOnBoardingJiraSoftwareFour,
            ref.context),
        HelpIntegrationUtilities.perPageViewModel(
            S.current.integration_jira_software_step_five_title,
            S.current.integration_jira_software_step_five_explain,
            AssetPaths.apiKeyOnBoardingJiraSoftwareFive,
            ref.context),
        HelpIntegrationUtilities.perPageViewModel(
            S.current.integration_jira_software_step_six_title,
            S.current.integration_jira_software_step_six_explain,
            AssetPaths.apiKeyOnBoardingJiraSoftwareSix,
            ref.context),
      ];

      titleOfIntegration = S.current.integration_jira_software_api_key;
      case TodoPlatforms.none:
        // TODO: Handle this case.
      default:
        [];
    }

  }
}


class HelpIntegrationUtilities{

  static PageViewModel perPageViewModel(String title, String bodyContentText,
      String currentImagePath, BuildContext context) {
    return PageViewModel(
      titleWidget: Text(title, style: ThemeValueExtension.headline5),
      bodyWidget: Text(
        bodyContentText,
        style: ThemeValueExtension.headline6.copyWith(
          color: CustomColors.profileGreyColor,
        ),
        textAlign: TextAlign.center,
      ),
      image: GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PhotoViewPage(
                  currentImagePath: currentImagePath, contentTitle: title))),
          child: Image.asset(
            currentImagePath,
            fit: BoxFit.contain,
          )),
    );
  }
}

class PhotoViewPage extends StatelessWidget {
  final String currentImagePath;
  final String contentTitle;

  const PhotoViewPage(
      {super.key, required this.currentImagePath, required this.contentTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicBackAppBar(
        contentTitle: contentTitle,
      ),
      body: PhotoView.customChild(
        backgroundDecoration: const BoxDecoration(
            color: CustomColors.fillWhiteColor
        ),
        child: Image.asset(currentImagePath),
      ),
    );
  }
}
