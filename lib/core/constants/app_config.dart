
import 'package:icoba_endowment_mobile/core/env/env.dart';

import '../data/enum/environment.dart' show Environment;

class AppConfig {
  static late Map<String, dynamic> _config;
  static late Environment _currentEnv;

  static void setEnvironment(Environment env) {
    _currentEnv = env;
    switch (env) {
      case Environment.dev:
        _config = _BaseUrlConfig.debugConstants;
        break;
      case Environment.staging:
        _config = _BaseUrlConfig.stagingConstants;
        break;
      case Environment.prod:
        _config = _BaseUrlConfig.prodConstants;
        break;
      case Environment.qa:
        _config = _BaseUrlConfig.qaConstants;
        break;
    }
  }

  static Environment get currentEnvironment => _currentEnv;

  static get baseUrl {
    return _config[_BaseUrlConfig.baseUrl];
  }


}

class _BaseUrlConfig {
  static const baseUrl = 'BaseUrl';

  static Map<String, dynamic> debugConstants = {
    baseUrl: Env.debugBaseUrl,
  };

  static Map<String, dynamic> stagingConstants = {
    baseUrl: Env.stagingBaseUrl,
  };

  static Map<String, dynamic> qaConstants = {
    baseUrl: Env.qaBaseUrl,
  };

  static Map<String, dynamic> prodConstants = {
    baseUrl: Env.productionBaseUrl,
  };

}
