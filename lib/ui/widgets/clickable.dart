import 'package:flutter/material.dart';

class Clickable extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  const Clickable({super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      color: Colors.transparent,
      child: InkResponse(
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        onTap: onPressed,
        child: child,
      ),
    );
  }
}
