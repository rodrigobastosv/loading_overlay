import 'package:flutter/material.dart';

import '../loader_overlay.dart';

/// Global widget that can be used to wrap the whole app
class GlobalLoaderOverlay extends StatelessWidget {
  GlobalLoaderOverlay({
    required this.child,
    this.useDefaultLoading = true,
    this.overlayColor,
    this.overlayOpacity,
    this.overlayWidget,
    this.disableBackButton = true,
    this.textDirection = TextDirection.ltr,
  });

  final Widget child;
  final bool useDefaultLoading;
  final Color? overlayColor;
  final double? overlayOpacity;
  final Widget? overlayWidget;
  final bool disableBackButton;
  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: textDirection,
      child: LoaderOverlay(
        useDefaultLoading: useDefaultLoading,
        overlayColor: overlayColor,
        overlayOpacity: overlayOpacity,
        overlayWidget: overlayWidget,
        disableBackButton: disableBackButton,
        child: child,
      ),
    );
  }
}
