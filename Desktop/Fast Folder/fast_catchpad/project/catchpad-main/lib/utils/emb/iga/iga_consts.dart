

/*
   D4:8A:FC:8E:5C:AA  - 6 F - E
   D4:8A:FC:8E:70:6E  - 2 F
   D4:8A:FC:8E:7A:1E  -11 S - E
   D4:8A:FC:8E:7C:DA - 7 S
   D4:8A:FC:8E:A3:62 - 8 S
   D4:8A:FC:8F:0C:0A -4  F - E
   D4:8A:FC:8F:2E:4A -10 S - E
   D4:8A:FC:8F:8E:E6 -5  F - E
   D4:8A:FC:8F:9E:02 -12 S - E
   D4:8A:FC:8F:A2:1E -3 F
   D4:8A:FC:8F:AD:AE -9 S
   D4:8A:FC:8F:B3:32 -1 F
*/

/*
D4:8A:FC:8E:5E:BE -9 S
D4:8A:FC:8E:62:06 -5 F -E
D4:8A:FC:8E:7E:1E - 4 F - E
D4:8A:FC:8E:AF:AA - 3 F
D4:8A:FC:8F:0A:CA - 7 S
D4:8A:FC:8F:47:92 - 6 F - E
D4:8A:FC:8F:52:FE - 12 S- E
D4:8A:FC:8F:56:E6 - 10 S -E
D4:8A:FC:8F:6D:F6 -1 F
D4:8A:FC:8F:84:CE- 2 F
D4:8A:FC:8F:9C:DA - 11 S - E
D4:8A:FC:8F:A1:42 - 8 S
*/

/*
* D4:8A:FC:8E:7C:4A -9 S
  D4:8A:FC:8E:81:96 -12 S- E
  D4:8A:FC:8E:82:3E -4 F - E
  D4:8A:FC:8E:84:66 -6 F - E
  D4:8A:FC:8E:94:B6 -5 F -E
  D4:8A:FC:8E:96:2E -10 S -E
  D4:8A:FC:8E:B2:0A -3 F
  D4:8A:FC:8F:0A:5A -2 F
  D4:8A:FC:8F:79:C6 -7 S
  D4:8A:FC:8F:81:06 -1 F
  D4:8A:FC:8F:84:42 -8 S
  D4:8A:FC:8F:B0:7A -11 S - E
*
*
* */



class IgaConsts {
  ///F:First Player S:Second Player E:Only bottom pads
  static const igaEventName = "_wordef";

  static const hasCustomerOnPlatformTimeoutSec = 60;
  static const igaAccDef = 10;

  static const mustDeviceCount = 12;

  static const padShowIntervalMs = 500;

  //-- Station A (Pier F) --\\
  static const stationADevices = {
    "D4:8A:FC:8E:7C:4A",
    "D4:8A:FC:8E:81:96",
    "D4:8A:FC:8E:82:3E",
    "D4:8A:FC:8E:84:66",
    "D4:8A:FC:8E:94:B6",
    "D4:8A:FC:8E:96:2E",
    "D4:8A:FC:8E:B2:0A",
    "D4:8A:FC:8F:0A:5A",
    "D4:8A:FC:8F:79:C6",
    "D4:8A:FC:8F:81:06",
    "D4:8A:FC:8F:84:42",
    "D4:8A:FC:8F:B0:7A"
  };

  static const stationADevicesE = {
    "D4:8A:FC:8E:81:96",
    "D4:8A:FC:8E:82:3E",
    "D4:8A:FC:8E:84:66",
    "D4:8A:FC:8E:94:B6",
    "D4:8A:FC:8F:84:42",
    "D4:8A:FC:8F:B0:7A"
  };
  //d4:8a:fc:8f:84:42
  //d4:8a:fc:8e:96:2e
  static const stationADevicesF = {
    "D4:8A:FC:8E:82:3E",
    "D4:8A:FC:8E:84:66",
    "D4:8A:FC:8E:94:B6",
    "D4:8A:FC:8E:B2:0A",
    "D4:8A:FC:8F:0A:5A",
    "D4:8A:FC:8F:81:06"
  };

  static const stationADevicesS = {
    "D4:8A:FC:8E:7C:4A",
    "D4:8A:FC:8E:81:96",
    "D4:8A:FC:8E:96:2E",
    "D4:8A:FC:8F:79:C6",
    "D4:8A:FC:8F:84:42",
    "D4:8A:FC:8F:B0:7A"
  };

  //-- Station A --\\

 //-- Station B(Pier D) --\\

  static const stationBDevices = {
    "D4:8A:FC:8E:5E:BE",
    "D4:8A:FC:8E:62:06",
    "D4:8A:FC:8E:7E:1E",
    "D4:8A:FC:8E:AF:AA",
    "D4:8A:FC:8F:0A:CA",
    "D4:8A:FC:8F:47:92",
    "D4:8A:FC:8F:52:FE",
    "D4:8A:FC:8F:56:E6",
    "D4:8A:FC:8F:6D:F6",
    "D4:8A:FC:8F:84:CE",
    "D4:8A:FC:8F:9C:DA",
    "D4:8A:FC:8F:A1:42"
  };

  static const stationBDevicesE = {
    "D4:8A:FC:8E:62:06",
    "D4:8A:FC:8E:7E:1E",
    "D4:8A:FC:8F:47:92",
    "D4:8A:FC:8F:52:FE",
    "D4:8A:FC:8F:56:E6",
    "D4:8A:FC:8F:9C:DA"
  };

  static const stationBDevicesF = {
    "D4:8A:FC:8E:62:06",
    "D4:8A:FC:8E:7E:1E",
    "D4:8A:FC:8E:AF:AA",
    "D4:8A:FC:8F:47:92",
    "D4:8A:FC:8F:6D:F6",
    "D4:8A:FC:8F:84:CE"
  };

  static const stationBDevicesS = {
    "D4:8A:FC:8E:5E:BE",
    "D4:8A:FC:8F:0A:CA",
    "D4:8A:FC:8F:52:FE",
    "D4:8A:FC:8F:56:E6",
    "D4:8A:FC:8F:9C:DA",
    "D4:8A:FC:8F:A1:42"
  };


  //-- STATION C (Pier: A11) --\\
  static const stationCDevices = {
  "D4:8A:FC:8E:5C:AA",
  "D4:8A:FC:8E:70:6E",
  "D4:8A:FC:8E:7A:1E",
  "D4:8A:FC:8E:7C:DA",
  "D4:8A:FC:8E:A3:62",
  "D4:8A:FC:8F:0C:0A",
  "D4:8A:FC:8F:2E:4A",
  "D4:8A:FC:8F:8E:E6",
  "D4:8A:FC:8F:9E:02",
  "D4:8A:FC:8F:A2:1E",
  "D4:8A:FC:8F:AD:AE",
  "D4:8A:FC:8F:B3:32",
  };

  static const stationCDevicesE = {
    "D4:8A:FC:8E:5C:AA",
    "D4:8A:FC:8E:7A:1E",
    "D4:8A:FC:8F:0C:0A",
    "D4:8A:FC:8F:2E:4A",
    "D4:8A:FC:8F:8E:E6",
    "D4:8A:FC:8F:9E:02"
  };

  static const stationCDevicesF = {
    "D4:8A:FC:8E:5C:AA",
    "D4:8A:FC:8E:70:6E",
    "D4:8A:FC:8F:0C:0A",
    "D4:8A:FC:8F:8E:E6",
    "D4:8A:FC:8F:A2:1E",
    "D4:8A:FC:8F:B3:32"
  };

  static const stationCDevicesS = {
    "D4:8A:FC:8E:7A:1E",
    "D4:8A:FC:8E:7C:DA",
    "D4:8A:FC:8E:A3:62",
    "D4:8A:FC:8F:2E:4A",
    "D4:8A:FC:8F:9E:02",
    "D4:8A:FC:8F:AD:AE"
  };

  //-- STATION C --\\


      // D4:8A:FC:95:D9:E2
      static const d32299fe6ce799108Devices = {
        "D4:8A:FC:96:36:2E", //1 - v -
        "D4:8A:FC:96:28:EE", //2 - v -
        "D4:8A:FC:96:4C:82", //3 - v -
        "D4:8A:FC:95:D9:E2", //4 - v
        "A8:42:E3:35:58:06", //5 - v -
        //"30:83:98:42:59:AE", //6
        "A8:42:E3:35:57:16", //6E - v -
        // "E0:E2:E6:A1:B6:02", //8E
        // "C0:49:EF:6E:78:82", //9E
        "D4:8A:FC:8F:80:22", //NNN - v -
        "D4:8A:FC:8F:8D:66", //NNN - v - 
        "D4:8A:FC:8F:76:B6", //NNN - v - 
        //"08:D1:F9:FC:FA:BA",//---
        //"D4:8A:FC:8F:80:22",//---
        //"D4:8A:FC:8F:33:32",//---
        //"D4:8A:FC:8F:76:B6",//---
        //"D4:8A:FC:8F:8D:66",//---
        "D4:8A:FC:8F:9D:56", //10 - v - 
        "D4:8A:FC:8F:08:9A", //11 - v -
        "D4:8A:FC:8E:97:DA", //12 - v -
      };


      static const d32299fe6ce799108DevicesE = {
        "D4:8A:FC:8F:80:22",
        "D4:8A:FC:8F:8D:66",
        "D4:8A:FC:8F:76:B6",
        "D4:8A:FC:96:36:2E",
        "D4:8A:FC:96:28:EE",
        "D4:8A:FC:96:4C:82",
      };
      static const d32299fe6ce799108DevicesF = {
        "D4:8A:FC:96:36:2E",
        "D4:8A:FC:96:28:EE",
        "D4:8A:FC:96:4C:82",
        "D4:8A:FC:95:D9:E2",
        "A8:42:E3:35:58:06",
        "A8:42:E3:35:57:16"
      };

      static const d32299fe6ce799108DevicesS = {
        "D4:8A:FC:8F:80:22",
        "D4:8A:FC:8F:8D:66",
        "D4:8A:FC:8F:76:B6",
        "D4:8A:FC:8F:9D:56",
        "D4:8A:FC:8F:08:9A",
        "D4:8A:FC:8E:97:DA"
      };

   static const igaTabletPierName = {
     "221161187157184" : "Pier A",
     "723907810827429" : "Pier F",
     "124985190412191" : "Pier D",
     "616991105124116" : "Pier DEMO"
   };
  static const igaTabletPierDocId = {
    "221161187157184" : "0",
    "723907810827429" : "2",
    "124985190412191" : "1",
    "616991105124116" : "9999"
  };

  static const igaTabletDevices = {
    "default": d32299fe6ce799108Devices,
    "default/E":  d32299fe6ce799108DevicesE,
    "default/F":  d32299fe6ce799108DevicesF,
    "default/S":  d32299fe6ce799108DevicesS,
    "616991105124116": d32299fe6ce799108Devices,
    "616991105124116/E": d32299fe6ce799108DevicesE,
    "616991105124116/F": d32299fe6ce799108DevicesF,
    "616991105124116/S": d32299fe6ce799108DevicesS,
    "221161187157184": stationCDevices,
    "221161187157184/E": stationCDevicesE,
    "221161187157184/F": stationCDevicesF,
    "221161187157184/S": stationCDevicesS,
    "124985190412191": stationBDevices,
    "124985190412191/E": stationBDevicesE,
    "124985190412191/F": stationBDevicesF,
    "124985190412191/S": stationBDevicesS,
    "723907810827429" : stationADevices,
    "723907810827429/E" : stationADevicesE,
    "723907810827429/F" : stationADevicesF,
    "723907810827429/S" : stationADevicesS,
    // "c159c2ae3ec941c1": d32299fe6ce799108Devices,
    // "c159c2ae3ec941c1/E": d32299fe6ce799108DevicesE,
    // "c159c2ae3ec941c1/F": d32299fe6ce799108DevicesF,
    // "c159c2ae3ec941c1/S": d32299fe6ce799108DevicesS,
    // "A66BC307-4F7B-43EA-A801-000D9F1D353E": d32299fe6ce799108Devices,
    // "A66BC307-4F7B-43EA-A801-000D9F1D353E/E": d32299fe6ce799108DevicesE,
    // "A66BC307-4F7B-43EA-A801-000D9F1D353E/F": d32299fe6ce799108DevicesF,
    // "A66BC307-4F7B-43EA-A801-000D9F1D353E/S": d32299fe6ce799108DevicesS,
    // "32299fe6ce799108":   d32299fe6ce799108Devices,
    // "32299fe6ce799108/E": d32299fe6ce799108DevicesE,
    // "32299fe6ce799108/F": d32299fe6ce799108DevicesF,
    // "32299fe6ce799108/S": d32299fe6ce799108DevicesS,
  };
}
