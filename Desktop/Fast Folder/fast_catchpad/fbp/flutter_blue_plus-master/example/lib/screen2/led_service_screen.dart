import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus_example/main.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../utils/snackbar.dart';
import '../widgets/characteristic_tile.dart';

class LedServiceScreen extends StatefulWidget {
  final List<CharacteristicTile> characteristicTiles;

  const LedServiceScreen({required this.characteristicTiles});

  @override
  State<LedServiceScreen> createState() => _LedServiceScreenState();
}

class _LedServiceScreenState extends State<LedServiceScreen> {
  bool tabSwitch1 = false;
  Color color = Colors.white;

  // BluetoothCharacteristic get c => widget.characteristic;

  Timer? _debounce;

  void _onSearchChanged(ColorExecute cE) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(Duration(milliseconds: 500), () {
      // Burada arama işlemi yapılabilir
      onWritePressed(cE);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // İki tab olacak
      child: Scaffold(
        appBar: AppBar(
          title: Text('Led Servis'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Led All'),
              Tab(text: 'Led'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SwitchListTile(
                    value: tabSwitch1,
                    onChanged: (val) {
                      tabSwitch1 = val;
                      setState(() {});
                    },
                    title: Text("SWITCH 1"),
                  ),
                  Divider(),
                  ColorPicker(
                    pickerColor: color ?? Colors.white,
                    onColorChanged: (c) {
                      color = c;
                      setState(() {});
                      final cE = ColorExecute(tabSwitch1, color);
                      _onSearchChanged(cE);
                    },
                    hexInputBar: true,
                  ),
                ],
              ),
            ),
            Center(child: Text('Tab 2 İçeriği')),
          ],
        ),
      ),
    );
  }

  List<int> _getRandomBytes(ColorExecute cE) {
    // final math = Random();
    final dt = cE.ledParser();
    logger.i("Worked");
    final list = utf8.encode(dt);
    return list;
  }

  Future onWritePressed(ColorExecute cE) async {
    try {
      await widget.characteristicTiles[1].characteristic.write(
          _getRandomBytes(cE),
          withoutResponse: widget.characteristicTiles[1].characteristic
              .properties.writeWithoutResponse);
      Snackbar.show(ABC.c, "Write: Success", success: true);
      if (widget.characteristicTiles[1].characteristic.properties.read) {
        await widget.characteristicTiles[1].characteristic.read();
      }
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Write Error:", e), success: false);
    }
  }
}

class ColorExecute {
  final bool isCommand;
  final Color color;

  ColorExecute(this.isCommand, this.color);

  void execute() {
    // print("Red Execute");
  }

  String colorOrNull(Color c) {
    // if empty we should send '-1/-1/-1'
    // if (c == null) {
    //   return List.generate(3, (index) => defaultEmptyValue)
    //       .join("/");
    // }

    return [c.red, c.green, c.blue].map(colorUnitTo100).join("/");
  }

  int colorUnitTo100(int unit) => (unit / 255 * 100).floor();

  String ledParser() {
    String first = isCommand ? "1" : "0";
    String second = colorOrNull(color);
    logger.i("Led Parser: $first/$second");
    return first + "/" + second;
  }

  /// 0/100/0/0
  ///
}
