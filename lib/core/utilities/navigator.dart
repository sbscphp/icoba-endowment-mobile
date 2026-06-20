import 'package:flutter/material.dart';

/// push navigation
void pushNavigation({
  required BuildContext context,
  required Widget widget,
  String? routeName,
  String transitionType = 'fade',
  Duration? transitionDuration,
}) {
  Navigator.push(
    context,
    _getPageRoute(widget, routeName, transitionType, transitionDuration),
  );
}

/// push and clear
void pushAndClearNavigation({
  required BuildContext context,
  required Widget widget,
  String? routeName,
  String? clearRoute,
  String transitionType = 'fade',
  Duration? transitionDuration,
}) {
  Navigator.pushAndRemoveUntil(
    context,
    _getPageRoute(widget, routeName, transitionType, transitionDuration),
    ModalRoute.withName(clearRoute ?? '/'),
  );
}

/// push and clear all
void pushAndClearAllNavigation({
  required BuildContext context,
  required Widget widget,
  String? routeName,
  String transitionType = 'fade',
  Duration? transitionDuration,
}) {
  Navigator.pushAndRemoveUntil(
    context,
    _getPageRoute(widget, routeName, transitionType, transitionDuration),
        (Route<dynamic> route) => false,
  );
}

/// push replacement
void replaceNavigation({
  required BuildContext context,
  required Widget widget,
  String? routeName,
  String transitionType = 'fade',
  Duration? transitionDuration,
}) {
  Navigator.pushReplacement(
    context,
    _getPageRoute(widget, routeName, transitionType, transitionDuration),
  );
}

/// pop
void popNavigation({required BuildContext context}) {
  Navigator.of(context).pop();
}

/// pop until
void popUntilNavigation({required BuildContext context, required String route}) {
  Navigator.popUntil(context, ModalRoute.withName(route));
}

/// Selects the appropriate transition type
PageRouteBuilder _getPageRoute(
    Widget widget,
    String? routeName,
    String transitionType,
    Duration? transitionDuration,
    ) {
  return PageRouteBuilder(
    settings: RouteSettings(name: routeName),
    transitionDuration: transitionDuration ?? const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      switch (transitionType) {
        case 'slide_left':
          return SlideTransition(
            position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
            child: child,
          );

        case 'slide_right':
          return SlideTransition(
            position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(animation),
            child: child,
          );

        case 'slide_top':
          return SlideTransition(
            position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(animation),
            child: child,
          );

        case 'slide_bottom':
          return SlideTransition(
            position: Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(animation),
            child: child,
          );

        case 'scale':
          return ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0).animate(animation),
            child: child,
          );

        case 'rotation':
          return RotationTransition(
            turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
            child: child,
          );

        case 'fade':
        default:
          return FadeTransition(
            opacity: animation,
            child: child,
          );
      }
    },
  );
}