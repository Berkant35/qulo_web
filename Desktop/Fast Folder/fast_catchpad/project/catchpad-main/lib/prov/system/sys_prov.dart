import 'dart:async';

import 'package:catchpad/models/enums/firebase/collenction_enums.dart';
import 'package:catchpad/prov/auth/current_user_prov.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:system_info2/system_info2.dart';

class SystemInfoControlNotifier extends StateNotifier<SysInfo?> {
  SystemInfoControlNotifier(SysInfo? state) : super(null);
  static Timer? timer;

  static void initalizeAndSet(WidgetRef ref) {





   /*
    logger.w(
        //"Kernel architecture     : ${SysInfo.kernelArchitecture}\n"
        //"Raw Kernel architecture : ${SysInfo.rawKernelArchitecture}\n"
        //"Kernel bitness          : ${SysInfo.kernelBitness}\n"
        //"Kernel name             : ${SysInfo.kernelName}\n"
        //"Kernel version          : ${SysInfo.kernelVersion}\n"
        "Operating system name   : ${SysInfo.operatingSystemName}\n"
        "Operating system version: ${SysInfo.operatingSystemVersion}\n"
        "User directory          : ${SysInfo.userDirectory}\n"
        "User id                 : ${SysInfo.userId}\n"
        "User name               : ${SysInfo.userName}\n"
        "User space bitness      : ${SysInfo.userSpaceBitness}\n");
    FirebaseCollectionEnums.phone_operating_systems.reference.doc(ref.read(currentUserProv)!.uid!).set(
      {
        //"Kernel architecture": SysInfo.kernelArchitecture,
        "Raw Kernel architecture": SysInfo.rawKernelArchitecture,
        "Kernel bitness": SysInfo.kernelBitness,
        "Kernel name": SysInfo.kernelName,
        "Kernel version": SysInfo.kernelVersion,
        "Operating system name": SysInfo.operatingSystemName,
        "Operating system version": SysInfo.operatingSystemVersion,
        "User directory": SysInfo.userDirectory,
        "User id": SysInfo.userId,
        "User name": SysInfo.userName,
        "User space bitness": SysInfo.userSpaceBitness,


      }
    );

    //periodicallyMemoryInfo();
     */

  }

  static void periodicallyMemoryInfo() async {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      logger.w(
        "Total physical memory: ${SysInfo.getTotalPhysicalMemory() ~/ megaByte} MB\n"
        "Total virtual memory : ${SysInfo.getTotalVirtualMemory() ~/ megaByte} MB\n"
        "Free virtual memory: ${SysInfo.getFreeVirtualMemory() ~/ megaByte} MB\n"
        //"Virtual memory size: ${SysInfo.getVirtualMemorySize() ~/ megaByte} MB\n",
      );
    });
  }
}

const int megaByte = 1024 * 1024;
