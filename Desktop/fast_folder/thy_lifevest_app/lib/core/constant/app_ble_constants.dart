/// BLE işlemleri için sabitler
class AppBleConstants {
  // THY Lifevest Reader Service UUID'leri (küçük harfle)
  static const String readerServiceUuid =
      '6e400001-b5a3-f393-e0a9-e50e24dcca9e';

  // Gerçek characteristic properties'e göre:
  // 6E400002: RX Characteristic (WRITE_WITHOUT_RESPONSE) - Client'tan reader'a command gönderir
  // 6E400003: TX Characteristic (NOTIFY) - Reader'dan client'a data gönderir
  static const String readerControlCharUuid =
      '6e400002-b5a3-f393-e0a9-e50e24dcca9e'; // RX/Write
  static const String readerDataCharUuid =
      '6e400003-b5a3-f393-e0a9-e50e24dcca9e'; // TX/Notify
  static const String readerStatusCharUuid =
      '6e400004-b5a3-f393-e0a9-e50e24dcca9e';
  static const String readerConfigCharUuid =
      '6e400005-b5a3-f393-e0a9-e50e24dcca9e';

  // BLE Ayarları
  static const int scanTimeoutSeconds = 10;
  static const int connectionTimeoutSeconds = 15;
  static const int commandTimeoutSeconds = 5;

  // Error Codes
  static const String errorCodeDiscoveryFailed = 'BLE_DISCOVERY_FAILED';
  static const int errorCodeDiscoveryFailedCode = 0x0006;
  static const String errorCodeNotificationFailed = 'BLE_NOTIFICATION_FAILED';
  static const String errorCodeWriteFailed = 'BLE_WRITE_FAILED';
  static const int errorCodeWriteFailedCode = 0x0004;
  static const String errorCodeReadFailed = 'BLE_READ_FAILED';
  static const int errorCodeReadFailedCode =  0x0005;
  static const String errorCodeCharacteristicNotFound = 'BLE_CHAR_NOT_FOUND';
  static const String errorCodeCharacteristicNotWritable =
      'BLE_CHAR_NOT_WRITABLE';
}
