import 'package:flutter/material.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    // case NamedRoutes.login:
    //   return _getPageRoute(
    //     routeName: settings.name!,
    //     viewToShow: Login(sessionExpired: true),
    //   );
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
