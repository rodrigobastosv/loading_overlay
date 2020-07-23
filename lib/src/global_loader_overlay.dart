import 'package:flutter/material.dart';

import '../loader_overlay.dart';

/// Global widget that can be used to wrap the whole app
class GlobalLoaderOverlay extends StatelessWidget {
  GlobalLoaderOverlay({
    @required this.child,
    this.useDefaultLoading,
    this.overlayColor,
    this.overlayOpacity,
    this.overlayWidget,
    this.textDirection = TextDirection.ltr,
  }) : assert(child != null);

  final Widget child;
  final bool useDefaultLoading;
  final Color overlayColor;
  final double overlayOpacity;
  final Widget overlayWidget;
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
        child: child,
      ),
    );
  }
}
