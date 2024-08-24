import 'package:audiotodo/core/navigation/navigation_constants.dart';
import 'package:audiotodo/core/navigation/navigation_service.dart';
import 'package:audiotodo/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends ConsumerStatefulWidget {
  const PrivacyPolicy({
    super.key,
  });

  @override
  ConsumerState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends ConsumerState<PrivacyPolicy> {
  late WebViewController _controller;
  static const _privacyBaseUrl = "https://audiotodo-46de0.web.app";
  static const _subPath = "privacy-and-policy";
  static const _indexPath = "index.html";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          // onPageStarted: (String url) {},
          // onPageFinished: (String url) {},
          // onHttpError: (HttpResponseError error) {},
          // onWebResourceError: (WebResourceError error) {},
          // onNavigationRequest: (NavigationRequest request) {
          //   if (request.url.startsWith('https://www.youtube.com/')) {
          //     return NavigationDecision.prevent;
          //   }
          //   return NavigationDecision.navigate;
          // },
        ),
      )
      ..loadRequest(Uri.parse(
          '$_privacyBaseUrl/$_subPath/${S.current.language_code != 'tr' ? 'en' : 'tr'}/$_indexPath'));
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          onPressed: () => NavigationService.instance.navigatePopUp(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        foregroundColor: Colors.white,
        title: Text(
          S.current.privacy_and_policy,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.white),
          textAlign: TextAlign.start,
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
