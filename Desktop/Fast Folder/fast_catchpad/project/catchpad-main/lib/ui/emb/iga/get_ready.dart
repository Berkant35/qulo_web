import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

class GetReadyView extends ConsumerStatefulWidget {
  final int selected;
  const GetReadyView({super.key, required this.selected});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GetReadyViewState();
}

class _GetReadyViewState extends ConsumerState<GetReadyView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      width: 270,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset(
              widget.selected == 3
                  ? 'assets/iga/tile_green_active.png'
                  : 'assets/iga/tile_green.png',
              height: 100,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              widget.selected == 2
                  ? 'assets/iga/tile_yellow_active.png'
                  : 'assets/iga/tile_yellow.png',
              height: 100,
            ),
          ),
          Text(widget.selected.toString(),
              style: context.general.textTheme.displayLarge!
                  .copyWith(color: Colors.white, fontSize: 100)),
          Positioned(
            right: 0,
            bottom: 0,
            child: Image.asset(
              widget.selected == 1
                  ? 'assets/iga/tile_red_active.png'
                  : 'assets/iga/tile_red.png',
              height: 100,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              widget.selected == 0
                  ? 'assets/iga/tile_blue_active.png'
                  : 'assets/iga/tile_blue.png',
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
