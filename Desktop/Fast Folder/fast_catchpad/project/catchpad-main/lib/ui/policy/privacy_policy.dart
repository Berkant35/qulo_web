import 'package:catchpad/utils/consts.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back)),
        title: Text(L10n
            .inst(context)
            .privacy_policy_title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: defPaddingSize),
              Text(
                L10n
                    .inst(context)
                    .privacy_policy_title,
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineLarge,
              ),
              const SizedBox(height: defPaddingSize),
              InkWell(
                onTap: () => _launchUrl(context),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex:1,
                      child: Text("URL:",style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontWeight: FontWeight.bold
                      ),),
                    ),

                    Expanded(
                      flex: 9,
                      child: Text(
                        L10n
                            .inst(context)
                            .privacy_url,
                        style: Theme
                            .of(context)
                            .textTheme
                            .subtitle2?.copyWith(
                          color: CpColors.cpYellow,
                          decoration: TextDecoration.underline
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: defPaddingSize),
              Text(
                L10n
                    .inst(context)
                    .privacy_policy,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(BuildContext context) async {

    final url = Uri.parse(L10n
        .inst(context)
        .privacy_url);

    if (!await launchUrl(url,mode: LaunchMode.platformDefault)) {

       throw Exception('Could not launch $url');
    }
  }
}


