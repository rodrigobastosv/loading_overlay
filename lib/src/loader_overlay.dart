library loader_overlay;

import 'package:flutter/material.dart';

import '../loader_overlay.dart';

/// Class that efetivally display the overlay on the screen. It's a Stateful widget
/// so we can dispose when not needed anymore
class LoaderOverlay extends StatefulWidget {
  const LoaderOverlay({
    this.overlayWidget,
    this.useDefaultLoading = useDefaultLoadingValue,
    this.overlayOpacity,
    this.overlayColor = defaultOverlayColor,
    required this.child,
  });

  final Widget? overlayWidget;
  final bool useDefaultLoading;
  final double? overlayOpacity;
  final Color? overlayColor;
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
    super.dispose();
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
            return Stack(
              children: <Widget>[
                widget.child,
                if (isLoading) ...[
                  Opacity(
                    key: LoaderOverlay.opacityWidgetKey,
                    opacity: isLoading
                        ? (widget.overlayOpacity ??
                            LoaderOverlay.defaultOpacityValue)
                        : 0,
                    child: Container(
                      key: LoaderOverlay.containerForOverlayColorKey,
                      color: widget.overlayColor,
                    ),
                  ),
                  if (widgetOverlay != null)
                    _widgetOverlay(widgetOverlay)
                  else
                    widget.useDefaultLoading
                        ? _getDefaultLoadingWidget()
                        : widget.overlayWidget!,
                ] else
                  const SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
    );
  }

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
