import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thy_lifevest_app/core/constant/api/api_service.dart';
import 'package:thy_lifevest_app/core/constant/api/dio_manager/dio_manager.dart';
import 'package:thy_lifevest_app/core/preferences/i_pref.dart';
import 'package:thy_lifevest_app/core/utils/domain/i_error.dart';
import 'package:thy_lifevest_app/core/utils/error_manager.dart';
import 'package:thy_lifevest_app/feature/auth/bloc/cubit/splash_cubit.dart';
import 'package:thy_lifevest_app/feature/auth/data/repo/auth_repo.dart';
import 'package:thy_lifevest_app/feature/bluetooth/bloc/cubit/app_bluetooth_communication_cubit.dart';
import 'package:thy_lifevest_app/feature/bluetooth/bloc/cubit/app_bluetooth_cubit.dart';
import 'package:thy_lifevest_app/feature/home/bloc/cubit/home_cubit.dart';
import 'package:thy_lifevest_app/feature/inventory/bloc/cubit/inventory_content_cubit.dart';
import 'package:thy_lifevest_app/feature/inventory/bloc/cubit/inventory_cubit.dart';
import 'package:thy_lifevest_app/feature/inventory/bloc/cubit/inventory_find_cubit.dart';
import 'package:thy_lifevest_app/feature/inventory/data/repo/inventory_repo.dart';
import 'package:thy_lifevest_app/feature/reader/bloc/cubit/reader_cubit.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  // ✅ 1. Önce SharedPreferences'ı initialize et
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // ✅ 2. BlePref'i async initialize et
  final blePref = BlePref();
  await blePref.init();
  sl.registerLazySingleton<BlePref>(() => blePref);

  // ✅ 3. AuthPref'i de initialize et
  final authPref = AuthPref();
  await authPref.init();
  sl.registerLazySingleton<AuthPref>(() => authPref);

  // ✅ 4. IPref interface'ini BlePref'e bağla
  sl.registerLazySingleton<IPref>(() => sl<BlePref>());
  sl.registerLazySingleton<Dio>(() => DioManager.getDio());
  sl.registerLazySingleton(() => ApiService(sl()));
  // ✅ 5. Cubit'leri register et (dependencies hazır olduktan sonra)
  sl.registerLazySingleton<List<IError>>(() => []);

  sl.registerLazySingleton<ErrorManager>(() => ErrorManager(sl<List<IError>>()));
  sl.registerLazySingleton<AuthRepo>(() => const AuthRepo());
  sl.registerLazySingleton<InventoryRepo>(() => const InventoryRepo());

  sl.registerLazySingleton<SplashCubit>(() => SplashCubit());
  sl.registerLazySingleton<HomeCubit>(() => HomeCubit());
  sl.registerLazySingleton<AppBluetoothCubit>(() => AppBluetoothCubit()..init());

  // ✅ 6. BLE Communication cubit'ini register et
  sl.registerLazySingleton<AppBluetoothCommunicationCubit>(() => AppBluetoothCommunicationCubit());

  // ✅ 7. Reader cubit'ini register et
  sl.registerLazySingleton<ReaderCubit>(() => ReaderCubit()..initialize());

  // ✅ 8. Inventory cubit'ini factory olarak register et (dependency order için)
  sl.registerLazySingleton<InventoryCubit>(() => InventoryCubit());
  sl.registerLazySingleton<InventoryContentCubit>(() => InventoryContentCubit()..init());
  sl.registerFactory<InventoryFindCubit>(() => InventoryFindCubit());
}
