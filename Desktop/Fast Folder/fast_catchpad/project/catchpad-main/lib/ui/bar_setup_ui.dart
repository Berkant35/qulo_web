import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:catchpad/utils/consts.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_saver_extensions/life_saver_extensions.dart';
import 'package:numberpicker/numberpicker.dart';

class BarSetupWidget extends ConsumerStatefulWidget {
  const BarSetupWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BarSetupWidgetState();
}

class _BarSetupWidgetState extends ConsumerState<BarSetupWidget> {
  late final ScrollController _scrollController;
  late int currentStep;
  final List<DropdownMenuItem<int>> items = [];
  final Map<String, int> _map = {};
  int currentValueForBar = 0;
  int increaseinterval = 100;

  @override
  void initState() {
    super.initState();
    for (var i = 1; i < 8; i++) {
      items.add(DropdownMenuItem<int>(value: i, child: Text(i.toString())));
    }
    currentStep = items.first.value!;
    for (var i = 1; i < currentStep + 1; i++) {
      _map[i.toString()] = i * increaseinterval;
    }
    _scrollController = ScrollController(initialScrollOffset: 0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CpColors.defBgColor,
        appBar: AppBar(),
        body: ListView(
          controller: _scrollController,
          padding: const EdgeInsets.only(top: defPaddingSize),
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: double.infinity,
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: FAProgressBar(
                                  size: MediaQuery.of(context).size.width * 0.3,
                                  direction: Axis.vertical,
                                  verticalDirection: VerticalDirection.down,
                                  currentValue: currentValueForBar.toDouble(),
                                  displayText: L10n.inst(context)
                                      .activity_duration_selection_millisecond_unit,
                                  formatValue: (value, fixed) {
                                    return ((increaseinterval * currentStep) -
                                            value)
                                        .toInt()
                                        .toString();
                                    return value.toStringAsFixed(fixed ?? 0);
                                  },
                                  progressColor: Colors.green,
                                  backgroundColor: Colors.red,
                                  maxValue: (increaseinterval * currentStep)
                                      .toDouble(),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (currentValueForBar - 25 >= 0) {
                                            currentValueForBar -= 25;
                                          }
                                        });
                                      },
                                      icon: const Icon(Icons.minimize)),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (currentValueForBar + 25 <= 700) {
                                            currentValueForBar += 25;
                                          }
                                        });
                                      },
                                      icon: const Icon(Icons.add)),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                child: Column(
                                  children: [
                                    for (var entry in _map.entries.toList())
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            '-' +
                                                entry.value.toString() +
                                                L10n.inst(context)
                                                    .activity_duration_selection_millisecond_unit,
                                            textAlign: TextAlign.right,
                                          ),
                                        ],
                                      )
                                  ].reversed.joinWidgetList((index) => SizedBox(
                                      height:
                                          (MediaQuery.of(context).size.height *
                                                  0.8) /
                                              (currentStep + 1))),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Column(
                        children: [
                          for (var entry in _map.entries)
                            NumberPicker(
                              value: entry.value,
                              minValue: increaseinterval,
                              maxValue: currentStep * increaseinterval,
                              step: increaseinterval,
                              itemHeight: 20,
                              itemWidth: 60,
                              axis: Axis.vertical,
                              onChanged: (i) {
                                setState(() {
                                  _map[entry.key] = i;
                                });
                              },
                              haptics: true,
                              textMapper: (val) =>
                                  val +
                                  L10n.inst(context)
                                      .activity_duration_selection_millisecond_unit,
                              textStyle: Theme.of(context).textTheme.caption,
                              selectedTextStyle:
                                  Theme.of(context).textTheme.bodyText2,
                            )
                        ].reversed.joinWidgetList((index) => SizedBox(
                            height: (MediaQuery.of(context).size.height * 0.8) /
                                (currentStep + 12))),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Column(
                        children: [
                          const AutoSizeText('Step'),
                          DropdownButton<int>(
                            items: items,
                            value: currentStep,
                            onChanged: (value) {
                              setState(() {
                                currentStep = value ?? currentStep;
                                _map.clear();
                                for (var i = 1; i < currentStep + 1; i++) {
                                  _map[i.toString()] = i * increaseinterval;
                                }
                              });
                            },
                          ),
                          const AutoSizeText('Increase Interval'),
                          NumberPicker(
                            value: increaseinterval,
                            minValue: 100,
                            maxValue: 500,
                            step: 100,
                            itemHeight: 20,
                            itemWidth: 60,
                            axis: Axis.vertical,
                            onChanged: (i) {
                              setState(() {
                                increaseinterval = i;
                                _map.clear();
                                for (var i = 1; i < currentStep + 1; i++) {
                                  _map[i.toString()] = i * increaseinterval;
                                }
                              });
                            },
                            haptics: true,
                            textMapper: (val) =>
                                val +
                                L10n.inst(context)
                                    .activity_duration_selection_millisecond_unit,
                            textStyle: Theme.of(context).textTheme.caption,
                            selectedTextStyle:
                                Theme.of(context).textTheme.bodyText2,
                          ),
                          const Divider(thickness: 1.5),
                          const AutoSizeText('Prizes'),
                          Flexible(
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: defPaddingSize * 1.5,
                                crossAxisSpacing: defPaddingSize * 1.5,
                              ),
                              itemCount: currentStep,
                              itemBuilder: (context, index) {
                                return GridTile(
                                    footer: Text(_map.values
                                            .toList()[index]
                                            .toString() +
                                        L10n.inst(context)
                                            .activity_duration_selection_millisecond_unit),
                                    child: GestureDetector(
                                      onTap: () async {
                                        FilePickerResult? result =
                                            await FilePicker.platform.pickFiles(
                                                /*  allowedExtensions: [
                                            'jpg',
                                            'png',
                                            'jpeg'
                                          ], */
                                                );
                                        if (result != null) {
                                          File file =
                                              File(result.files.single.path!);
                                        } else {
                                          // User canceled the picker
                                        }
                                      },
                                      child: const SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: Image(
                                            image: AssetImage(
                                                'assets/images/250xplaceholder.png')),
                                      ),
                                    ));
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
