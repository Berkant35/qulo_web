import 'package:catchpad/utils/cp_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CpCircleAvatar extends ConsumerWidget {
  final String imagePath;
  final String rank;
  final double size;

  const CpCircleAvatar(
      {required this.size,
      required this.imagePath,
      required this.rank,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        children: [

          Container(
              decoration: const BoxDecoration(
                  color: CpColors.cpPrimary, shape: BoxShape.circle),
              padding: const EdgeInsets.all(1.5),
              child: ClipOval(
                child: Image.network(
                  imagePath,
                  height: size - 10,
                  width: size - 10,
                  fit: BoxFit.cover,
                ),
              )),
          Positioned(
            bottom: 0,
            left: size / 2 - 12,
            height: 15,
            width: 15,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: CpColors.cpPrimary, // Yuvarlak arka plan rengi
              ),
              child: Center(
                child: Text(
                  rank,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
