import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/constants/app_constants.dart';
import 'core/constants/app_theme/app_theme.dart';
import 'ui/pages/splash.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   if (message.notification != null) {}
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  //await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // AppConfig.setEnvironment(Environment.staging);
  //await CountryUtils.readCountryJson();
  // SecureStorageInit.initSecureStorage();
  // setupLocator();
  // await locator<SecurityService>().init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        const figmaDesignSize = Size(draftWidth, draftHeight);
        final isFoldOrTablet = maxWidth > phoneWidth;
        final designSize = isFoldOrTablet
            ? Size(maxWidth - 16, maxHeight - 32)
            : figmaDesignSize;

        return ScreenUtilInit(
          splitScreenMode: false,
          minTextAdapt: true,
          designSize: designSize,
          builder: (context, child) => MaterialApp(
            title: 'ICOBA Endowment',
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light, //todo::: update to vm
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            home: Splash(),
            builder: (context, child) {
              final mq = MediaQuery.of(context);
              return MediaQuery(
                data: mq.copyWith(textScaler: TextScaler.noScaling),
                child: child!,
              );
            },
          ),
        );
      },
    );
  }
}
