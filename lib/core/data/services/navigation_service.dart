import 'package:flutter/material.dart';

class NavigationService {

  final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> clearAllRoutes({required String routeName}) {
    return _navigationKey.currentState!.pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false);
  }

  Future<dynamic> pushAndClearRoutes({required String routeName, required String clearRoute}) {
    return _navigationKey.currentState!.pushNamedAndRemoveUntil(routeName, ModalRoute.withName(clearRoute),);
  }

  void popUntil({required String routeName}) {
    _navigationKey.currentState!.popUntil(ModalRoute.withName(routeName));
  }

}