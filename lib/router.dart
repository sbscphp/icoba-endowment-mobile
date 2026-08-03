import 'package:flutter/material.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/ui/pages/authentication/login.dart';

import 'ui/pages/landing.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case NamedRoutes.login:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: Login(
          // sessionExpired: true
        ),
      );
    case NamedRoutes.landing:
      return _getPageRoute(routeName: settings.name!, viewToShow: Landing());
    // case NamedRoutes.securityPrompt:
    //   return _getPageRoute(
    //     routeName: settings.name!,
    //     viewToShow: const SecurityPrompt(appName: 'Cardinalstone Pension'),
    //   );
    //todo::add more routes
    default:
      return MaterialPageRoute(
        builder: (context) =>
            Scaffold(body: Center(child: Text('No path for ${settings.name}'))),
      );
  }
}

PageRoute _getPageRoute({
  required String routeName,
  required Widget viewToShow,
}) {
  return MaterialPageRoute(
    settings: RouteSettings(name: routeName),
    builder: (_) => viewToShow,
  );
}
