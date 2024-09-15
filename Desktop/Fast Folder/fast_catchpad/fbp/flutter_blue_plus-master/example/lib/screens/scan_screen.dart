import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_blue_plus_example/main.dart';

import '../utils/extra.dart';
import '../utils/snackbar.dart';
import '../widgets/scan_result_tile.dart';
import '../widgets/system_device_tile.dart';
import 'device_screen.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  List<BluetoothDevice> _systemDevices = [];
  List<ScanResult> _onScanResults = [];
  bool _isScanning = false;
  late StreamSubscription<List<ScanResult>> _onScanResultsSubscription;
  late StreamSubscription<bool> _isScanningSubscription;

  @override
  void initState() {
    super.initState();

    _onScanResultsSubscription = FlutterBluePlus.onScanResults.listen((results) {
      _onScanResults = results;
      if (mounted) {
        setState(() {});
      }
    }, onError: (e) {
      Snackbar.show(ABC.b, prettyException("Scan Error:", e), success: false);
    });

    _isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
      _isScanning = state;
      logger.i("Is Scanning: $_isScanning");
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _onScanResultsSubscription.cancel();
    _isScanningSubscription.cancel();
    super.dispose();
  }

  Future onScanPressed() async {
    try {
      _systemDevices = await FlutterBluePlus.systemDevices;
    } catch (e) {
      Snackbar.show(ABC.b, prettyException("System Devices Error:", e),
          success: false);
    }
    try {
      await FlutterBluePlus.startScan(
        timeout: const Duration(seconds: 15),
        withKeywords: ["CatchPad"],
        // withNames: ["CatchPad"],
        withRemoteIds: [],
        withMsd: [],
        withServiceData: [],
        withServices: [],
      );
    } catch (e) {
      Snackbar.show(ABC.b, prettyException("Start Scan Error:", e),
          success: false);
    }
    if (mounted) {
      setState(() {});
    }
  }

  Future onStopPressed() async {
    try {
      FlutterBluePlus.stopScan();
    } catch (e) {
      Snackbar.show(ABC.b, prettyException("Stop Scan Error:", e),
          success: false);
    }
  }

  void onConnectPressed(BluetoothDevice device) {
    device.connectAndUpdateStream().catchError((e) {
      Snackbar.show(ABC.c, prettyException("Connect Error:", e),
          success: false);
    });
    MaterialPageRoute route = MaterialPageRoute(
        builder: (context) => DeviceScreen(device: device),
        settings: RouteSettings(name: '/DeviceScreen'));
    Navigator.of(context).push(route).then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  Future onRefresh() {
    if (_isScanning == false) {
      FlutterBluePlus.startScan(
        // withKeywords: ["CatchPad"],
        withNames: ["CatchPad"],
        withRemoteIds: [],
        withMsd: [],
        withServiceData: [],
        withServices: [],
      );
    }
    if (mounted) {
      setState(() {});
    }
    return Future.delayed(Duration(milliseconds: 500));
  }

  Widget buildScanButton(BuildContext context) {
    if (FlutterBluePlus.isScanningNow) {
      return FloatingActionButton(
        heroTag: "1",
        child: const Icon(Icons.stop),
        onPressed: onStopPressed,
        backgroundColor: Colors.red,
      );
    } else {
      return FloatingActionButton(
          heroTag: "2", child: const Text("Tara"), onPressed: onScanPressed);
    }
  }

  List<Widget> _buildSystemDeviceTiles(BuildContext context) {
    return _systemDevices
        .map(
          (d) => SystemDeviceTile(
            device: d,
            onOpen: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DeviceScreen(device: d),
                settings: RouteSettings(name: '/DeviceScreen'),
              ),
            ),
            onConnect: () => onConnectPressed(d),
          ),
        )
        .toList();
  }

  List<Widget> _buildScanResultTiles(BuildContext context) {
    return _onScanResults
        .map(
          (r) => ScanResultTile(
            result: r,
            onTap: () => onConnectPressed(r.device),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: Snackbar.snackBarKeyB,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Find Devices'),
        ),
        body: RefreshIndicator(
          onRefresh: onRefresh,
          child: ListView(
            children: <Widget>[
              ..._buildSystemDeviceTiles(context),
              ..._buildScanResultTiles(context),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            buildScanButton(context),
            SizedBox(height: 5),
            FloatingActionButton(
              heroTag: "3",
              child: FittedBox(
                child: Text(
                  "Hepsinden\nkop",
                  textAlign: TextAlign.center,
                ),
              ),
              onPressed: ()=>toggleConnect(ConnectType.AllDisconnect),
            ),
            SizedBox(height: 5),
            FloatingActionButton(
              heroTag: "4",
              child: FittedBox(
                child: Text("Hepsine\nBağlan"),
              ),
              onPressed: ()=>toggleConnect(ConnectType.AllConnect),
            ),
          ],
        ),
      ),
    );
  }

  void toggleConnect(ConnectType connectType) {
    logger.i("Hepsine bağlanılıyor...");
    _onScanResults
        .toList()
        .forEach((d) =>
    connectType == ConnectType.AllConnect ?
    d.device.connectAndUpdateStream() : d.device.disconnect().then((_) {
              logger.i(d.device.isConnected ? "Bağlandı: ${d.device.name}" : "Koptu: ${d.device.name}");
            }).catchError((e) {
              logger.e("Bağlanamadı: ${d.device.name}");
            }));


    if (mounted) {
      setState(() {});
    }
  }
}
enum ConnectType {AllConnect,AllDisconnect}
