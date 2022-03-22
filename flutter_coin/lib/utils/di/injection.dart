import 'package:dio/dio.dart';
import 'package:flutter_coin/config/app_config.dart';
import 'package:flutter_coin/config/theme.dart';
import 'package:flutter_coin/data/utils/shared_pref_manager.dart';

import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../data/coins/data_sources/remote/coins_api.dart';
import '../../data/coins/repositories/coins_repository_impl.dart';
import '../../domain/coins/repositories/coins_repository.dart';

GetIt getIt = GetIt.instance;

Future setupInjection() async {
  await _registerAppComponents();
  await _registerNetworkComponents();
  _registerRepository();
  await _registerLocalDataBase();
}

Future _registerLocalDataBase() async {
  // box = Hive.box('favoriteCoinsBox');
}

Future _registerAppComponents() async {
  final sharedPreferencesManager = await SharedPreferencesManager.getInstance();
  getIt.registerSingleton<SharedPreferencesManager>(sharedPreferencesManager!);

  final appTheme = AppTheme();
  getIt.registerSingleton(appTheme);
}

Future<void> _registerNetworkComponents() async {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.getInstance()!.apiBaseUrl,
      connectTimeout: 10000,
      contentType: "application/json",
    ),
  );
  dio.interceptors.addAll(
    [
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ),
    ],
  );
  getIt.registerSingleton(dio);

  // getIt.registerSingleton(CoinApi(dio, baseUrl: dio.options.baseUrl + 'user/'));
  getIt.registerSingleton(CoinsApi(dio, baseUrl: dio.options.baseUrl));
}

void _registerRepository() {
  getIt.registerFactory<CoinsRepository>(
    () => CoinsRepositoryImpl(
      getIt<CoinsApi>(),
    ),
  );
}
