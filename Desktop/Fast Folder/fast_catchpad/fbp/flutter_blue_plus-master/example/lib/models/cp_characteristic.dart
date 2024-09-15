import 'package:flutter/widgets.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class CpCharacteristic {
  final String id;
  final String serviceId;

  const CpCharacteristic({
    required this.id,
    required this.serviceId,
  });

  Guid get uuid => Guid.fromString(id);

  Guid get serviceUuid => Guid.fromString(serviceId);

  BluetoothCharacteristic bluetoothCharacteristic(String deviceId) =>
      BluetoothCharacteristic(
        remoteId: DeviceIdentifier(deviceId),
        serviceUuid: serviceUuid,
        characteristicUuid: uuid,
      );
}

const Duration responseTimeMistakeMargin = Duration(milliseconds: 20);
const String defaultSeperator = '/';
const String subSeperator = ',';
const String defaultEmptyValue = '-1';

// #region main stuff

const List<String> serviceIds = [ledServiceId, adminServiceId, sensorServiceId];

List<Guid> get serviceUuids =>
    serviceIds.map((str) => Guid.fromString(str)).toList();

// #endregion

// #region new characteristics

// #region simulator only
const String simulatorServiceId = 'b3b7e8f4-9ab4-4d9b-80d4-bd61113a5017';

const CpCharacteristic simulatorCharacteristic = CpCharacteristic(
  id: '4fafc201-1fb5-459e-8fcc-c5c9c331914b',
  serviceId: simulatorServiceId,
);
// #endregion

const Map<String,String> detailOfService = {
  ledServiceId : 'LED',
  sensorServiceId: 'Sensor',
  infoServiceId: 'Info',
  audioServiceId: 'Audio',
  otaServiceId: 'OTA',
  "d804b643-6ce7-4e81-9f8a-ce0f699085eb":'Espota'
  // heartRateService: 'Heart Rate',
};

const Map<String, String> characteristicService = {
  '6412075e-b2ab-11ec-b909-000000000001': 'LED CHARACTERISTIC',
  '6412075e-b2ab-11ec-b909-000000000111': 'LED ALL CHARACTERISTIC',
  'a4bf0dbb-b2ab-11ec-b909-00000000000a': 'Sleep CHARACTERISTIC',
  '83e7f7e6-b2ab-11ec-b111-000000000003': 'FSR CHARACTERISTIC',
  '7af57456-b2ab-11ec-b909-000000000001': 'ACC CHARACTERISTIC',
  '83e7f7e6-b2ab-11ec-b909-000000000002': 'DST CHARACTERISTIC',
  'a4bf0dba-b2ab-11ec-b909-00000000000a': 'ACTIVATE CHARACTERISTIC',
  '8a19169a-b2ab-11ec-b909-00000000000c': 'CONFIG CHARACTERISTIC',
  '83e7f7e6-b2ab-11ec-b111-000000000001': 'NFC CHARACTERISTIC',
  '83e7f7e6-b2ab-11ec-b111-000000000002': 'VIBRATION CHARACTERISTIC',
  'a4bf0dbb-b2ab-11ec-b909-ddddddddddd2': 'ERROR LOG CHARACTERISTIC',
  'a4bf0dbb-b2ab-11ec-b909-00000000000b': 'PING-PONG LOG CHARACTERISTIC',
  'a4bf0dbb-b2ab-11ec-b909-ddddddddddd0': 'DEVICE INFO CHARACTERISTIC',
  'a4bf0dbb-b2ab-11ec-b909-ddddddddddd1': 'BATTERY CHARACTERISTIC',
  'a4bf0dbb-b2ab-11ec-b909-aaaaaaaaaaaa': 'AUDIO CHARACTERISTIC',
  '2a37': 'HEART RATE CHARACTERISTIC',
  '6412075e-b2ab-11ec-b909-a00000011111': 'LED SETTINGS CHARACTERISTIC',
  'beb5483e-36e1-4688-b7f5-ea07361b26a8': 'MP3 TRANSFER CHARACTERISTIC',
  'd804b644-6ce7-4e81-9f8a-ce0f699085eb': 'Espota-1 CHARACTERISTIC',
  'c8659211-af91-4ad3-a995-a58d6fd26145': 'FW CHARACTERISTIC',
  'c8659212-af91-4ad3-a995-a58d6fd26145': 'HW VERSION CHARACTERISTIC',
  'c8659212-af91-4ad3-a995-a58d6fd20148': 'OTA SETTING CHARACTERISTIC',
};



// #region led
const String ledServiceId = '55cb9fe8-b2ab-11ec-b909-000000000000';

const CpCharacteristic ledCharacteristic = CpCharacteristic(
  id: '6412075e-b2ab-11ec-b909-000000000001',
  serviceId: ledServiceId,
);
const CpCharacteristic ledAllCharacteristic = CpCharacteristic(
  id: '6412075e-b2ab-11ec-b909-000000000111',
  serviceId: ledServiceId,
);
// #endregion

// #mp3start

const String mp3ServiceId = "23cb9fe8-b2ab-11ec-b909-AAAAAAAAAAAA";

// "beb5483e-36e1-4688-b7f5-ea07361b26a8"
const CpCharacteristic mp3transferCharacteristic = CpCharacteristic(
  id: 'beb5483e-36e1-4688-b7f5-ea07361b26a8',
  serviceId: mp3ServiceId,
);

// #mp3end

// #otastart

const String otaServiceId = 'c8659210-af91-4ad3-a995-a58d6fd26145';

const CpCharacteristic otaFwCharacteristic = CpCharacteristic(
  id: 'c8659211-af91-4ad3-a995-a58d6fd26145',
  serviceId: otaServiceId,
);

const CpCharacteristic otaHwVersion = CpCharacteristic(
  id: 'c8659212-af91-4ad3-a995-a58d6fd26145',
  serviceId: otaServiceId,
);

const CpCharacteristic otaSettings = CpCharacteristic(
  id: "c8659212-af91-4ad3-a995-a58d6fd20148",
  serviceId: otaServiceId,
);

// #otaend

// #region admin
const String adminServiceId = '23cb9fe8-b2ab-11ec-b909-dddddddddddd';

const CpCharacteristic adminCharacteristic = CpCharacteristic(
  id: 'a4bf0dbb-b2ab-11ec-b909-00000000000a',
  serviceId: adminServiceId,
);
// #endregion

// #hearth rate start
// const String heartRateService = '180D';
//
// const CpCharacteristic heartRateCharacteristic = CpCharacteristic(
//   id: '2A37',
//   serviceId: heartRateService,
// );

// #hearth rate end

// #region sensors
const String sensorServiceId = '722d9150-b2ab-11ec-b909-000000000000';

const CpCharacteristic fsrCharacteristic = CpCharacteristic(
  id: '83e7f7e6-b2ab-11ec-b111-000000000003',
  serviceId: sensorServiceId,
);

const CpCharacteristic accCharacteristic = CpCharacteristic(
  id: '7af57456-b2ab-11ec-b909-000000000001',
  serviceId: sensorServiceId,
);

const CpCharacteristic dstCharacteristic = CpCharacteristic(
  id: '83e7f7e6-b2ab-11ec-b909-000000000002',
  serviceId: sensorServiceId,
);

const CpCharacteristic activateCharacteristic = CpCharacteristic(
  id: 'a4bf0dba-b2ab-11ec-b909-00000000000A',
  serviceId: sensorServiceId,
);

const CpCharacteristic configCharacteristic = CpCharacteristic(
  id: '8a19169a-b2ab-11ec-b909-00000000000C',
  serviceId: sensorServiceId,
);
const CpCharacteristic nfcCharacteristic = CpCharacteristic(
  id: '83e7f7e6-b2ab-11ec-b111-000000000001',
  serviceId: sensorServiceId,
);

const CpCharacteristic vibrationCharacteristic = CpCharacteristic(
  id: '83e7f7e6-b2ab-11ec-b111-000000000002',
  serviceId: sensorServiceId,
);

// #endregion

// #region info
const String infoServiceId = '23cb9fe8-b2ab-11ec-b909-dddddddddddd';

const CpCharacteristic errorLog = CpCharacteristic(
  id: 'a4bf0dbb-b2ab-11ec-b909-ddddddddddd2',
  serviceId: infoServiceId,
);

const CpCharacteristic pongLog = CpCharacteristic(
    id: 'a4bf0dbb-b2ab-11ec-b909-00000000000b', serviceId: infoServiceId);

const CpCharacteristic infoCharacteristic = CpCharacteristic(
  id: 'a4bf0dbb-b2ab-11ec-b909-ddddddddddd0',
  serviceId: infoServiceId,
);

const CpCharacteristic sleepCharacteristicAdminInfo = CpCharacteristic(
  id: 'a4bf0dbb-b2ab-11ec-b909-00000000000a',
  serviceId: infoServiceId,
);

const CpCharacteristic batteryCharacteristic = CpCharacteristic(
  id: 'a4bf0dbb-b2ab-11ec-b909-ddddddddddd1',
  serviceId: infoServiceId,
);

// #endregion
// #region audio
const String audioServiceId = '23cb9fe8-b2ab-11ec-b909-aaaaaaaaaaaa';

const CpCharacteristic audioCharacteristic = CpCharacteristic(
  id: 'a4bf0dbb-b2ab-11ec-b909-aaaaaaaaaaaa',
  serviceId: audioServiceId,
);

// #endregion
// #endregion

const String oldMainServiceId = '4fafc201-1fb5-459e-8fcc-c5c9c331914b';
const oldMainCharacteristicId = 'beb5483e-36e1-4688-b7f5-ea07361b26a8';

Guid get oldMainServiceUuid => Guid.fromString(oldMainServiceId);

Guid get oldMainCharacteristicUuid => Guid.fromString(oldMainCharacteristicId);

const CpCharacteristic oldMainCharacteristic = CpCharacteristic(
  id: oldMainCharacteristicId,
  serviceId: oldMainServiceId,
);

abstract class PadConsts {
  static const Color errorColor = Color(0xFFF44336);
}
