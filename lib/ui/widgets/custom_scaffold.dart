import 'package:flutter/material.dart';

import '../../core/constants/app_dimension.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final bool useSafeArea;
  final bool useHorizontalPadding;
  final EdgeInsetsGeometry? customPadding;
  final bool extendBodyBehindAppBar;
  final Color? backgroundColor;
  final bool extendBody;

  const CustomScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.useSafeArea = true,
    this.useHorizontalPadding = true,
    this.extendBodyBehindAppBar = false,
    this.extendBody = false,
    this.customPadding,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final EdgeInsetsGeometry defaultPadding = EdgeInsets.symmetric(
      horizontal: AppDimension.paddingLeft,
    );

    Widget content = useHorizontalPadding
        ? Padding(padding: customPadding ?? defaultPadding, child: body)
        : body;

    if (useSafeArea) {
      content = SafeArea(child: content);
    }

    final background = SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: content,
    );

    return Scaffold(
      appBar: appBar,
      extendBody: extendBody,
      backgroundColor:
          backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      body: background,
    );
  }
}
