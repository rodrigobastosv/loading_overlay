import 'package:flutter/material.dart';

import '../loader_overlay.dart';

/// Global widget that can be used to wrap the whole app
class GlobalLoaderOverlay extends StatefulWidget {
  const GlobalLoaderOverlay({
    Key? key,
    required this.child,
    this.useDefaultLoading = true,
    this.overlayColor,
    this.overlayOpacity,
    this.overlayWidget,
    this.disableBackButton = true,
    this.textDirection = TextDirection.ltr,
  }) : super(key: key);

  final Widget child;
  final bool useDefaultLoading;
  final Color? overlayColor;
  final double? overlayOpacity;
  final Widget? overlayWidget;
  final bool disableBackButton;
  final TextDirection textDirection;

  @override
  _GlobalLoaderOverlayState createState() => _GlobalLoaderOverlayState();
}

class _GlobalLoaderOverlayState extends State<GlobalLoaderOverlay> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: widget.textDirection,
      child: LoaderOverlay(
        useDefaultLoading: widget.useDefaultLoading,
        overlayColor: widget.overlayColor,
        overlayOpacity: widget.overlayOpacity,
        overlayWidget: widget.overlayWidget,
        disableBackButton: widget.disableBackButton,
        child: widget.child,
      ),
    );
  }
}
