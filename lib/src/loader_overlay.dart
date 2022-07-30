library loader_overlay;

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';

import '../loader_overlay.dart';

/// Class that efetivally display the overlay on the screen. It's a Stateful widget
/// so we can dispose when not needed anymore
class LoaderOverlay extends StatefulWidget {
  const LoaderOverlay({
    Key? key,
    this.overlayWidget,
    this.useDefaultLoading = useDefaultLoadingValue,
    this.overlayOpacity,
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
    required this.child,
  }) : super(key: key);

  /// The widget of the overlay. This is great if you want to insert your own widget to serve as
  /// an overlay.
  final Widget? overlayWidget;

  /// Whether or not to use a default loading if none is provided.
  final bool useDefaultLoading;

  /// The opacity of the overlay
  final double? overlayOpacity;

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

  static const _prefix = '@loader-overlay';

  static const defaultOverlayWidgetKey = Key('$_prefix/default-widget');

  static const opacityWidgetKey = Key('$_prefix/opacity-widget');

  static const defaultOpacityValue = 0.4;

  static const defaultOverlayColor = Colors.grey;

  static const containerForOverlayColorKey =
      Key('$_prefix/container-for-overlay-color');

  static const useDefaultLoadingValue = true;

  @override
  _LoaderOverlayState createState() => _LoaderOverlayState();
}

// Has the Center CircularProgressIndicator as the default loader
class _LoaderOverlayState extends State<LoaderOverlay> {
  OverlayControllerWidget? _overlayControllerWidget;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      _overlayControllerWidget = OverlayControllerWidget.of(context);
    });
  }

  @override
  void dispose() {
    _overlayControllerWidget?.dispose();
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    if (context.loaderOverlay.visible && widget.closeOnBackButton) {
      context.loaderOverlay.hide();
    }
    return widget.disableBackButton;
  }

  @override
  Widget build(BuildContext context) {
    return OverlayControllerWidget(
      child: Builder(
        builder: (innerContext) => StreamBuilder<Map<String, dynamic>>(
          stream: innerContext.loaderOverlay.overlayController.visibilityStream,
          initialData: const <String, dynamic>{
            'loading': false,
            'widget': null,
          },
          builder: (_, snapshot) {
            final isLoading = snapshot.data!['loading'] as bool;
            final widgetOverlay = snapshot.data!['widget'] as Widget?;

            if (isLoading) {
              BackButtonInterceptor.add(myInterceptor);
            } else {
              BackButtonInterceptor.remove(myInterceptor);
            }

            return Stack(
              children: <Widget>[
                widget.child,
                AnimatedSwitcher(
                  duration: widget.duration,
                  reverseDuration: widget.reverseDuration,
                  switchInCurve: widget.switchInCurve,
                  switchOutCurve: widget.switchOutCurve,
                  transitionBuilder: widget.transitionBuilder,
                  layoutBuilder: widget.layoutBuilder,
                  child: isLoading
                      ? Stack(
                          children: _getLoadingWidget(
                          isLoading,
                          widgetOverlay,
                        ))
                      : const SizedBox.shrink(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> _getLoadingWidget(bool isLoading, Widget? widgetOverlay) => [
        WillPopScope(
          onWillPop: () async => !widget.disableBackButton,
          child: Opacity(
            key: LoaderOverlay.opacityWidgetKey,
            opacity: isLoading
                ? (widget.overlayOpacity ?? LoaderOverlay.defaultOpacityValue)
                : 0,
            child: widget.overlayWholeScreen
                ? Container(
                    key: LoaderOverlay.containerForOverlayColorKey,
                    color: widget.overlayColor ??
                        LoaderOverlay.defaultOverlayColor,
                  )
                : Center(
                    child: Container(
                      height: widget.overlayHeight,
                      width: widget.overlayWidth,
                      key: LoaderOverlay.containerForOverlayColorKey,
                      color: widget.overlayColor ??
                          LoaderOverlay.defaultOverlayColor,
                    ),
                  ),
          ),
        ),
        if (widgetOverlay != null)
          _widgetOverlay(widgetOverlay)
        else
          widget.useDefaultLoading
              ? _getDefaultLoadingWidget()
              : widget.overlayWidget!,
      ];

  Widget _widgetOverlay(Widget widget) => SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Material(
          color: Colors.transparent,
          child: widget,
        ),
      );

  Widget _getDefaultLoadingWidget() => const Center(
        child: CircularProgressIndicator.adaptive(
          key: LoaderOverlay.defaultOverlayWidgetKey,
        ),
      );
}
