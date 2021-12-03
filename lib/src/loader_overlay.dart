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
    required this.child,
  }) : super(key: key);

  final Widget? overlayWidget;
  final bool useDefaultLoading;
  final double? overlayOpacity;
  final Color? overlayColor;
  final bool disableBackButton;
  final Widget child;

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
                if (isLoading)
                  ..._getLoadingWidget(isLoading, widgetOverlay)
                else
                  const SizedBox.shrink(),
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
            child: Container(
              key: LoaderOverlay.containerForOverlayColorKey,
              color: widget.overlayColor ?? LoaderOverlay.defaultOverlayColor,
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
        child: CircularProgressIndicator(
          key: LoaderOverlay.defaultOverlayWidgetKey,
        ),
      );
}
