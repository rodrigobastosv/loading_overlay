import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../loader_overlay.dart';

/// Global widget that can be used to wrap the whole app
class GlobalLoaderOverlay extends StatefulWidget {
  const GlobalLoaderOverlay({
    Key? key,
    this.textDirection = TextDirection.ltr,
    this.overlayWidgetBuilder,
    this.useDefaultLoading = true,
    this.overlayColor,
    this.disableBackButton = true,
    this.overlayWholeScreen = true,
    this.overlayHeight,
    this.overlayWidth,
    this.closeOnBackButton = false,
    this.duration = Duration.zero,
    this.reverseDuration = Duration.zero,
    this.switchInCurve = Curves.linear,
    this.switchOutCurve = Curves.linear,
    this.transitionBuilder = AnimatedSwitcher.defaultTransitionBuilder,
    this.layoutBuilder = AnimatedSwitcher.defaultLayoutBuilder,
    this.useBackButtonInterceptor = !kIsWeb,
    required this.child,
  }) : super(key: key);

  final bool useBackButtonInterceptor;

  /// The widget of the overlay. This is great if you want to insert your own widget to serve as
  /// an overlay.
  final Widget Function(dynamic progress)? overlayWidgetBuilder;

  /// Whether or not to use a default loading if none is provided.
  final bool useDefaultLoading;

  /// The color of the overlay
  final Color? overlayColor;

  /// Whether or not to disable the back button while loading.
  final bool disableBackButton;

  //Hide the loader when back button pressed
  final bool closeOnBackButton;

  /// This should be false if you want to have full control of the size of the overlay.
  /// This is generaly used in conjunction with [overlayHeight] and [overlayWidth] to
  /// define the desired size of the overlay.
  final bool overlayWholeScreen;

  /// The desired height of the overlay
  final double? overlayHeight;

  /// The desired width of the overlay
  final double? overlayWidth;

  /// The child that will have the overlay upon
  final Widget child;

  /// The duration when the overlay enters
  final Duration duration;

  /// The duration when the overlay exits
  final Duration? reverseDuration;

  /// The curve for the overlay to transition in
  final Curve switchInCurve;

  /// The curve for the overlay to transition out
  final Curve switchOutCurve;

  /// The transition builder for the overlay
  final Widget Function(Widget, Animation<double>) transitionBuilder;

  /// The layout builder for the overlay
  final Widget Function(Widget?, List<Widget>) layoutBuilder;

  /// TextDirection of the app. This is generaly used when putting [LoaderOverlay] above MaterialApp.
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
        overlayWidgetBuilder: widget.overlayWidgetBuilder,
        useDefaultLoading: widget.useDefaultLoading,
        overlayColor: widget.overlayColor,
        disableBackButton: widget.disableBackButton,
        overlayWholeScreen: widget.overlayWholeScreen,
        overlayHeight: widget.overlayHeight,
        overlayWidth: widget.overlayWidth,
        closeOnBackButton: widget.closeOnBackButton,
        duration: widget.duration,
        reverseDuration: widget.reverseDuration,
        switchInCurve: widget.switchInCurve,
        switchOutCurve: widget.switchOutCurve,
        transitionBuilder: widget.transitionBuilder,
        layoutBuilder: widget.layoutBuilder,
        child: widget.child,
      ),
    );
  }
}
