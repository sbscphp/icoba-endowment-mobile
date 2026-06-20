import 'package:get_it/get_it.dart';





GetIt locator = GetIt.instance;

void setupLocator() {
  //register api classes
  // locator.registerLazySingleton<OtpDataProvider>(() => OtpDataProvider()); 
  // locator.registerLazySingleton<AuthDataProvider>(() => AuthDataProvider()); 




  ///services
  // locator.registerLazySingleton(() => NavigationService());
  // locator.registerLazySingleton<GeoLocatorService>(() => GeoLocatorService());
  // locator.registerLazySingleton<SecurityService>(() => SecurityService());
  // locator.registerLazySingleton(() => PusherService());

}
