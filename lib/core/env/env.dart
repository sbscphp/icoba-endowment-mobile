// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  ///--- Environmental BaseUrls ---
  @EnviedField(varName: 'STAGING_BASE_URL', obfuscate: true)
  static final String stagingBaseUrl = _Env.stagingBaseUrl;

  @EnviedField(varName: 'PROD_BASE_URL', obfuscate: true)
  static final String productionBaseUrl = _Env.productionBaseUrl;

  @EnviedField(varName: 'DEBUG_BASE_URL', obfuscate: true)
  static final String debugBaseUrl = _Env.debugBaseUrl;

  @EnviedField(varName: 'QA_BASE_URL', obfuscate: true)
  static final String qaBaseUrl = _Env.qaBaseUrl;

  //----Network Manager-----
  @EnviedField(defaultValue: 'X-CLIENTKEY',)
  static final String xClientKey = _Env.xClientKey;

  @EnviedField(defaultValue: 'ENCRYPTION_KEY',)
  static final String encryptionKey = _Env.encryptionKey;

  @EnviedField(defaultValue: 'IV')
  static final String iv = _Env.iv;

}
