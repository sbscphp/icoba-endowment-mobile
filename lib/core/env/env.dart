// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  ///--- Environmental BaseUrls ---
  @EnviedField(varName: 'STAGING_BASE_URL')
  static final String stagingBaseUrl = _Env.stagingBaseUrl;

  @EnviedField(varName: 'PROD_BASE_URL')
  static final String productionBaseUrl = _Env.productionBaseUrl;

  @EnviedField(varName: 'DEBUG_BASE_URL')
  static final String debugBaseUrl = _Env.debugBaseUrl;

  @EnviedField(varName: 'QA_BASE_URL')
  static final String qaBaseUrl = _Env.qaBaseUrl;


  ///--- API Routes ---
  @EnviedField(defaultValue: 'IDENTITY')
  static final String identity = _Env.identity;

  @EnviedField(defaultValue: 'ONBOARDING')
  static final String onboarding = _Env.onboarding;

  @EnviedField(defaultValue: 'AUTH')
  static final String auth = _Env.auth;

  @EnviedField(defaultValue: 'V1')
  static final String v1 = _Env.v1;

  @EnviedField(defaultValue: 'PROFILE')
  static final String profile = _Env.profile;

  ///--- Pusher ---
  @EnviedField(defaultValue: 'PUSHER_APP_KEY')
  static final String pusherAppKey = _Env.pusherAppKey;

  @EnviedField(defaultValue: 'PUSHER_APP_CLUSTER')
  static final String pusherAppCluster = _Env.pusherAppCluster;
}
