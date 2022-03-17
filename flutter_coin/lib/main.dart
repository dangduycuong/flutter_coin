import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_coin/config/navigation_util.dart';
import 'package:flutter_coin/config/theme.dart';
import 'package:flutter_coin/utils/di/injection.dart';
import 'package:flutter_coin/utils/route/app_routing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'config/app_config.dart';
import 'data/coins/models/local/local_coin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp();
  // Listen for flavor triggered by iOS / android build
  await const MethodChannel('flavor').invokeMethod<String>('getFlavor').then(
    (String? flavor) async {
      final appConfig = AppConfig.getInstance(flavorName: flavor);
      log("App Config : ${appConfig!.apiBaseUrl}");
    },
  ).catchError(
    (error) {
      AppConfig.getInstance(flavorName: "development");

      log("Error when set up enviroment $error");
    },
  );

  await setupInjection();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  //khoi tao hive
  await Hive.initFlutter();
  //dang ky
  Hive.registerAdapter(LocalCoinModelAdapter());
  //tao va mo box
  await Hive.openBox('favoriteCoinsBox');

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
      fallbackLocale: const Locale('en', 'US'),
      path: 'resources/langs/langs.csv',
      assetLoader: CsvAssetLoader(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppTheme appTheme = getIt<AppTheme>();

  @override
  void initState() {
    appTheme.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    appTheme.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(400, 800),
      builder: () => MaterialApp(
        builder: (context, child) {
          ScreenUtil.setContext(context);
          return child ?? const SizedBox();
        },
        title: 'Flutter Demo',
        navigatorObservers: <NavigatorObserver>[
          MyApp.observer,
        ],
        navigatorKey: NavigationUtil.rootKey,
        debugShowCheckedModeBanner: false,
        initialRoute: RouteDefine.loginScreen.name,
        onGenerateRoute: AppRouting.generateRoute,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: appTheme.currentTheme,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}
