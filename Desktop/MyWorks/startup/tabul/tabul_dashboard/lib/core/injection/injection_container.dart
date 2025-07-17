import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../theme/theme_cubit.dart';
import '../network/dio_client.dart';
import '../network/network_info.dart';
import '../../features/dashboard/data/data.dart';
import '../../features/dashboard/domain/domain.dart';
import '../../features/dashboard/presentation/cubit/cubit.dart';

/// Dependency injection container
/// GetIt kullanarak service locator pattern implementation
final sl = GetIt.instance;

/// Dependency injection setup
@InjectableInit()
Future<void> configureDependencies() async {
  await _initExternalDependencies();
  await _initCoreDependencies();
  await _initDataSources();
  await _initRepositories();
  await _initUseCases();
  await _initCubits();
}

/// External dependencies (third-party libraries)
Future<void> _initExternalDependencies() async {
  // SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Dio HTTP client
  sl.registerLazySingleton<Dio>(() => Dio());
}

/// Core dependencies
Future<void> _initCoreDependencies() async {
  // Network client
  sl.registerLazySingleton<DioClient>(
    () => DioClient(sl<Dio>()),
  );

  // Network info
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<InternetConnectionChecker>()),
  );
}

/// Data sources
Future<void> _initDataSources() async {
  // Dashboard remote data source
  sl.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSourceImpl(dioClient: sl<DioClient>()),
  );

  // Dashboard local data source
  sl.registerLazySingleton<DashboardLocalDataSource>(
    () => DashboardLocalDataSourceImpl(
        sharedPreferences: sl<SharedPreferences>()),
  );
}

/// Repositories
Future<void> _initRepositories() async {
  // Dashboard repository
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(
      remoteDataSource: sl<DashboardRemoteDataSource>(),
      localDataSource: sl<DashboardLocalDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );
}

/// Use cases
Future<void> _initUseCases() async {
  // Dashboard use cases
  sl.registerLazySingleton<GetDashboardData>(
    () => GetDashboardData(sl<DashboardRepository>()),
  );
  sl.registerLazySingleton<GetMetricCards>(
    () => GetMetricCards(sl<DashboardRepository>()),
  );
  sl.registerLazySingleton<GetChartData>(
    () => GetChartData(sl<DashboardRepository>()),
  );
  sl.registerLazySingleton<GetRecentActivities>(
    () => GetRecentActivities(sl<DashboardRepository>()),
  );
  sl.registerLazySingleton<RefreshDashboardData>(
    () => RefreshDashboardData(sl<DashboardRepository>()),
  );
}

/// Cubits/Blocs
Future<void> _initCubits() async {
  // Theme cubit
  sl.registerFactory<ThemeCubit>(() => ThemeCubit());

  // Dashboard cubit
  sl.registerFactory<DashboardCubit>(
    () => DashboardCubit(
      getDashboardData: sl<GetDashboardData>(),
      getMetricCards: sl<GetMetricCards>(),
      getChartData: sl<GetChartData>(),
      getRecentActivities: sl<GetRecentActivities>(),
      refreshDashboardData: sl<RefreshDashboardData>(),
    ),
  );
}

/// Dependency injection'ı reset et (testing için)
Future<void> resetDependencies() async {
  await sl.reset();
}

/// Service'i register et
void registerService<T extends Object>(T service) {
  sl.registerLazySingleton<T>(() => service);
}

/// Factory service'i register et
void registerFactory<T extends Object>(T Function() factory) {
  sl.registerFactory<T>(factory);
}

/// Service'i al
T getService<T extends Object>() {
  return sl<T>();
}

/// Service'in register olup olmadığını kontrol et
bool isRegistered<T extends Object>() {
  return sl.isRegistered<T>();
}

/// Async service'i register et
Future<void> registerAsyncService<T extends Object>(
  Future<T> Function() factory,
) async {
  final service = await factory();
  sl.registerLazySingleton<T>(() => service);
}

/// Conditional registration
void registerConditional<T extends Object>(
  T Function() factory, {
  required bool condition,
}) {
  if (condition) {
    sl.registerLazySingleton<T>(factory);
  }
}

/// Scoped registration (factory that gets reset)
void registerScoped<T extends Object>(T Function() factory) {
  sl.registerFactoryParam<T, void, void>((param1, param2) => factory());
}

/// Environment-based registration
void registerForEnvironment<T extends Object>(
  Map<String, T Function()> factories,
  String environment,
) {
  if (factories.containsKey(environment)) {
    sl.registerLazySingleton<T>(factories[environment]!);
  }
}
