import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/utilities/components/bars/app_bars/basic_back_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:share_plus/share_plus.dart';


class PdfViewAndShare extends ConsumerStatefulWidget {
  const PdfViewAndShare({
    super.key,
  });

  @override
  ConsumerState createState() => _PdfViewAndShareState();
}

class _PdfViewAndShareState extends ConsumerState<PdfViewAndShare> {
  @override
  Widget build(BuildContext context) {
    final path = ref.read(officeFileManagerState.notifier).currentPdfFile!.path;

    return Scaffold(
      appBar: BasicBackAppBar(
        contentTitle: S.current.office_pdf,
        trailingButton: IconButton(
          onPressed: () async {
            final result = await Share.shareXFiles([XFile(path)]);
            switch(result.status){
              //TODO SUCCESS
              case  ShareResultStatus.success:
              case ShareResultStatus.dismissed:
              case ShareResultStatus.unavailable:
            }
          },
          icon: const Icon(
            Icons.share,
            color: CustomColors.primaryColor,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: PdfView(
              path: path,
            ),
          ),
        ],
      ),
    );
  }
}
