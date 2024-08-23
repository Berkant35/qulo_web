import 'dart:async';
import 'dart:math';

import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphic/graphic.dart';

import '../../../utils/consts.dart';

class ListenersScreen extends StatelessWidget {
  final DeviceModel device;
  const ListenersScreen({
    required this.device,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(defPaddingSize),
          child: _Listeners(device: device),
        ),
      ),
    );
  }
}

// #region listeners
class _Listeners extends StatelessWidget {
  final DeviceModel device;
  const _Listeners({
    required this.device,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Listeners'),
          _AccTouchListener(device: device),
          _AccMotionListener(device: device),
          _DstListener(device: device),
        ],
      ),
    );
  }
}

class _AccTouchListener extends ConsumerStatefulWidget {
  final DeviceModel device;
  const _AccTouchListener({
    required this.device,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_AccTouchListener> createState() => _AccTouchListenerState();
}

class _AccTouchListenerState extends ConsumerState<_AccTouchListener> {
  StreamSubscription<TouchEvent>? listener;
  String? st;
  final datas = <TouchEvent>[];

  @override
  void dispose() {
    listener?.cancel();
    listener = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {
            final stream =
                PadSensorManager.listenToTouch(widget.device.id, ref: ref);
            listener = stream.listen(
              (touch) {
                datas.add(touch);

                st = touch.tap.toString();
                setState(() {});
              },
            );
            setState(() {});
          },
          child: const Text('listen to taps'),
        ),
        if (st != null) Text(st!),
        if (listener != null) ...[
          _SensorGraph(
            title: 'Tap',
            getData: (minVal, maxVal, dataCount) {
              if (dataCount != null && datas.length >= dataCount) {
                datas.removeRange(0, datas.length - dataCount);
              }

              return datas.map(
                (e) {
                  int ds = e.tap.tapCounter;

                  if (minVal != null) {
                    ds = max(minVal, ds);
                  }

                  if (maxVal != null) {
                    ds = min(maxVal, ds);
                  }

                  return {
                    'time': DateTime.now(),
                    'val': ds,
                  };
                },
              ).toList();
            },
          ),
          ElevatedButton(
            onPressed: () {
              listener!.cancel();
              listener = null;
              st = null;
              setState(() {});
            },
            child: const Text('stop'),
          ),
        ],
      ],
    );
  }
}

class _AccMotionListener extends ConsumerStatefulWidget {
  final DeviceModel device;
  const _AccMotionListener({
    required this.device,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_AccMotionListener> createState() => _AccMotionListenerState();
}

class _AccMotionListenerState extends ConsumerState<_AccMotionListener> {
  StreamSubscription<MotionEvent>? listener;
  String? st;
  final datas = <MotionEvent>[];

  @override
  void dispose() {
    listener?.cancel();
    listener = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {
            final stream =
                PadSensorManager.listenToMotion(widget.device.id, ref: ref);
            listener = stream.listen(
              (touch) {
                datas.add(touch);

                st = touch.motion.toString();
                setState(() {});
              },
            );
            setState(() {});
          },
          child: const Text('listen to motion'),
        ),
        if (st != null) Text(st!),
        if (listener != null) ...[
          _SensorGraph(
            title: 'Roll',
            color: Colors.yellow,
            getData: (minVal, maxVal, dataCount) {
              if (dataCount != null && datas.length >= dataCount) {
                datas.removeRange(0, datas.length - dataCount);
              }

              return datas.map(
                (e) {
                  double roll = e.motion.roll;

                  if (minVal != null) {
                    roll = max(minVal + .0, roll);
                  }

                  if (maxVal != null) {
                    roll = min(maxVal + .0, roll);
                  }

                  return {
                    'time': DateTime.now(),
                    'val': roll,
                  };
                },
              ).toList();
            },
          ),
          _SensorGraph(
            title: 'Pitch',
            color: Colors.brown,
            getData: (minVal, maxVal, dataCount) {
              if (dataCount != null && datas.length >= dataCount) {
                datas.removeRange(0, datas.length - dataCount);
              }

              return datas.map(
                (e) {
                  double pitch = e.motion.pitch;

                  if (minVal != null) {
                    pitch = max(minVal + .0, pitch);
                  }

                  if (maxVal != null) {
                    pitch = min(maxVal + .0, pitch);
                  }

                  return {
                    'time': DateTime.now(),
                    'val': pitch,
                  };
                },
              ).toList();
            },
          ),
          ElevatedButton(
            onPressed: () {
              listener!.cancel();
              listener = null;
              st = null;
              setState(() {});
            },
            child: const Text('stop'),
          ),
        ],
      ],
    );
  }
}

class _DstListener extends ConsumerStatefulWidget {
  final DeviceModel device;
  const _DstListener({
    required this.device,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_DstListener> createState() => _DstListenerState();
}

class _DstListenerState extends ConsumerState<_DstListener> {
  StreamSubscription<DistanceEvent>? listener;
  String? st;
  final datas = <DistanceEvent>[];

  @override
  void dispose() {
    listener?.cancel();
    listener = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {
            final stream =
                PadSensorManager.listenToDistance(widget.device.id, ref: ref);
            listener = stream.listen(
              (touch) {
                datas.add(touch);

                st = touch.distance.toString();

                setState(() {});
              },
            );
            setState(() {});
          },
          child: const Text('listen to distance'),
        ),
        if (st != null) Text(st!),
        if (listener != null) ...[
          _SensorGraph(
            title: 'Distance',
            getData: (minVal, maxVal, dataCount) {
              if (dataCount != null && datas.length >= dataCount) {
                datas.removeRange(0, datas.length - dataCount);
              }

              return datas.map(
                (e) {
                  int ds = e.distance.distance;

                  if (minVal != null) {
                    ds = max(minVal, ds);
                  }

                  if (maxVal != null) {
                    ds = min(maxVal, ds);
                  }

                  return {
                    'time': DateTime.now(),
                    'val': ds,
                  };
                },
              ).toList();
            },
          ),
          ElevatedButton(
            onPressed: () {
              listener!.cancel();
              listener = null;
              st = null;
              setState(() {});
            },
            child: const Text('stop'),
          ),
        ]
      ],
    );
  }
}

class _SensorGraph extends StatefulWidget {
  final Color color;
  final String title;
  final List<Map<dynamic, dynamic>> Function(int?, int?, int?) getData;

  const _SensorGraph({
    required this.getData,
    required this.title,
    this.color = Colors.green,
    Key? key,
  }) : super(key: key);

  @override
  State<_SensorGraph> createState() => __SensorStateGraph();
}

class __SensorStateGraph extends State<_SensorGraph> {
  int? minVal, maxVal, dataCount;

  @override
  Widget build(BuildContext context) {
    final data = widget.getData(minVal, maxVal, dataCount);

    if (data.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: defPaddingSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Chart(
              data: data,
              variables: {
                'year': Variable(
                  accessor: (Map map) => map['time'] as DateTime,
                ),
                'price1': Variable(
                  accessor: (Map map) => map['val'] as num,
                ),
              },
              /*elements: [
                LineElement(
                  color: ColorAttr(
                    value: widget.color,
                  ),
                ),
              ],*/
              axes: [
                Defaults.horizontalAxis,
                Defaults.verticalAxis,
                Defaults.verticalAxis,
              ],
              selections: {
                'p': PointSelection(),
              },
              crosshair: CrosshairGuide(), marks: [],
            ),
          ),
          Row(
            children: [
              const Text('min'),
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    minVal = int.tryParse(value);
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text('max'),
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    maxVal = int.tryParse(value);
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text('data count'),
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    dataCount = int.tryParse(value);
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// #endregion