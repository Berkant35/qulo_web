import 'package:catchpad/ui/game/setup_widgets/challenge_detail_setup.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SequenceScreen extends ConsumerStatefulWidget {
  const SequenceScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _SequenceScreenState();
}

class _SequenceScreenState extends ConsumerState<SequenceScreen> {
  static const bleDevices = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12"
  ];

  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width*0.9,
        height: MediaQuery.of(context).size.height*0.9,
        child: Column(
          children: [
            Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: MediaQuery.of(context).size.width*0.18,
                    mainAxisSpacing: MediaQuery.of(context).size.width*0.1,
                    // Sütun sayısı
                  ),
                  itemCount: bleDevices.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PerDraggableCatchPadIcon(
                      lbl: bleDevices[index],
                      deviceId: null,
                      index: index.toString(),
                    );
                  },
                )),
            Expanded(
                child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: IconButton(
                      onPressed: () {
                        ///Spaghetti code alert!
                      },
                      icon: const Icon(Icons.remove)),
                ),
                Expanded(
                  flex: 8,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: controller,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.2),
                      child: Row(
                        children: [
                          for (int i = 0; i < bleDevices.length; i++)
                            Container(
                              width: MediaQuery.of(context).size.width * 0.16,
                              decoration:
                                  BoxDecoration(border: Border.all(width: 1)),
                              child: Column(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        width: double.infinity,
                                        color: CpColors.bottomBarColor,
                                        child: Center(
                                            child: Text((i + 1).toString())),
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: DragTarget(
                                        onAccept: (String data) {},
                                        builder: (BuildContext context,
                                            List<Object?> candidateData,
                                            List<dynamic> rejectedData) {
                                          return Container();
                                        },
                                      )),
                                ],
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_circle_outline)),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
