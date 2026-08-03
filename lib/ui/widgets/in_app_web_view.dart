import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/data/enum/view_state.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/donation_vm.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/ui/pages/donation_and_pledge/successful_donation.dart';
import 'package:icoba_endowment_mobile/ui/widgets/show_flush_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../core/data/enum/contribution_type.dart';
import 'app_loader.dart';
import 'custom_appbar.dart';

class InAppWebView extends StatefulWidget {
  final String url;
  final String title;
  final ContributionType? contributionType;
  final bool isGuest;

  final void Function()? leadingIconOnPressed;
  const InAppWebView({
    super.key,
    required this.url,
    required this.title,
    this.leadingIconOnPressed,
    this.contributionType = ContributionType.donation,
    this.isGuest = false,
  });

  @override
  State<InAppWebView> createState() => _InAppWebViewState();
}

class _InAppWebViewState extends State<InAppWebView> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    initControllerDynamics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: widget.title,
        context: context,
        leadingIconOnPressed: widget.leadingIconOnPressed,
        // textColor: ColorPath.shaftBlack
      ),
      body: _isLoading
          ? const Center(child: AppLoader(size: 80))
          : WebViewWidget(controller: _controller),
    );
  }

  initControllerDynamics() {
    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },

          onUrlChange: (change) {
            debugPrint('change::::${change.url}>>>');

            if (change.url?.contains("icoba-endowment") ?? false) {
              setState(() {
                // _isLoading = true;
              });
              replaceNavigation(
                context: context,
                widget: SuccessfulDonation(isGuest: widget.isGuest),
                routeName: NamedRoutes.successfulDonation,
              );
            }
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..loadRequest(Uri.parse(widget.url));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }
}
