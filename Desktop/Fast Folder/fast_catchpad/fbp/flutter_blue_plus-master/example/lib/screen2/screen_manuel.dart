import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothScanner extends StatefulWidget {
  @override
  _BluetoothScannerState createState() => _BluetoothScannerState();
}

class _BluetoothScannerState extends State<BluetoothScanner> {
  // final FlutterBluePlus FlutterBluePlus = FlutterBluePlus.instance;
  final List<ScanResult> scanResultsList = [];

  @override
  void initState() {
    super.initState();
    startScan();
  }

  Future<void> startScan() async {
    // Taramayı başlat
    FlutterBluePlus.startScan(timeout: Duration(seconds: 30));

    // Tarama sonuçlarını dinliyoruz
    FlutterBluePlus.scanResults.listen((results) {
      setState(() {
        // Yeni cihazları tarama sonuçlarına göre listeye ekliyoruz
        for (ScanResult result in results) {
          if (!_isDeviceInList(result)) {
            scanResultsList.add(result);
          }
        }
      });
    });

    // Eğer tarama durursa tekrar başlatıyoruz.
    FlutterBluePlus.isScanning.listen((isScanning) {
      if (!isScanning) {
        startScan();
      }
    });
  }

  // Cihazın zaten listede olup olmadığını kontrol eden yardımcı fonksiyon
  bool _isDeviceInList(ScanResult result) {
    for (var item in scanResultsList) {
      if (item.device.id == result.device.id) {
        return true;
      }
    }
    return false;
  }

  @override
  void dispose() {
    FlutterBluePlus.stopScan(); // Sayfa kapandığında taramayı durduruyoruz
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Cihazları'),
      ),
      body: ListView.builder(
        itemCount: scanResultsList.length,
        itemBuilder: (context, index) {
          var result = scanResultsList[index];
          return ListTile(
            title: Text(result.device.name.isNotEmpty
                ? result.device.name
                : 'Bilinmeyen Cihaz'),
            subtitle: Text(result.device.id.toString()),
            trailing: Text('RSSI: ${result.rssi}'), // Cihazın sinyal gücünü gösterir
          );
        },
      ),
    );
  }
}