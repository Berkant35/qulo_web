import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CircullarImageButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String imagePath;
  final String url;

  const CircullarImageButton({
    super.key,
     this.width,
     this.height,
    required this.imagePath,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final parsedUrl = Uri.parse(url);
        await launchUrl(parsedUrl);
      },
      child: Image.asset(
        height: 40,
        imagePath,
        fit: BoxFit.contain,
      ),
    );
  }
}
