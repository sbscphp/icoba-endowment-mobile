import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/constants/app_config.dart';
import 'core/constants/app_constants.dart';
import 'core/constants/app_theme/app_theme.dart';
import 'core/data/enum/environment.dart';
import 'core/data/services/navigation_service.dart';
import 'core/data/view_models/theme_selection_view_model.dart';
import 'core/utilities/secure_storage/secure_storage_init.dart';
import 'locator.dart';
import 'router.dart' as router;
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
  AppConfig.setEnvironment(Environment.staging);
  //await CountryUtils.readCountryJson();
  SecureStorageInit.initSecureStorage();
  setupLocator();
  // await locator<SecurityService>().init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {

  @override
  Widget build(BuildContext context) {
    final themeVm = ref.watch(themeSelectionViewModel);
    final themeMode = themeVm.themeMode;

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
            themeMode: themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            navigatorKey: locator<NavigationService>().navigationKey,
            onGenerateRoute: router.generateRoute,
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
