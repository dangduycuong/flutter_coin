enum AppFlavor {
  development,
  staging,
  production,
}

class AppConfig {
  final String apiBaseUrl;
  final AppFlavor appFlavor;

  AppConfig({
    required this.apiBaseUrl,
    required this.appFlavor,
  });

  static AppConfig? _instance;

  static AppConfig devConfig = AppConfig(
    // apiBaseUrl: 'https://api.prod.setel.my/api/',
    apiBaseUrl: "https://coinranking1.p.rapidapi.com",
    appFlavor: AppFlavor.development,
  );

  static AppConfig stagingConfig = AppConfig(
    apiBaseUrl: 'https://coinranking1.p.rapidapi.com',
    appFlavor: AppFlavor.staging,
  );

  static AppConfig productionConfig = AppConfig(
    apiBaseUrl: 'https://api.prod.setel.my/api/',
    appFlavor: AppFlavor.production,
  );

  static AppConfig? getInstance({flavorName}) {
    if (_instance == null) {
      switch (flavorName) {
        case 'development':
          {
            _instance = devConfig;
          }
          break;
        case 'staging':
          {
            _instance = stagingConfig;
          }
          break;
        case 'production':
          {
            _instance = productionConfig;
          }
          break;
      }
      return _instance;
    }
    return _instance;
  }
}
