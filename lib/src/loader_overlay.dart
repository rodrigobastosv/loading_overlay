library loader_overlay;

import 'package:flutter/material.dart';

import '../loader_overlay.dart';

/// Class that efetivally display the overlay on the screen. It's a Stateful widget
/// so we can dispose when not needed anymore
class LoaderOverlay extends StatefulWidget {
  const LoaderOverlay(
      {this.overlayWidget,
      this.useDefaultLoading = true,
      this.overlayOpacity,
      this.overlayColor = Colors.grey,
      @required this.child})
      : assert(child != null);

  final Widget overlayWidget;
  final bool useDefaultLoading;
  final double overlayOpacity;
  final Color overlayColor;
  final Widget child;

  @override
  _LoaderOverlayState createState() => _LoaderOverlayState();
}

// Has the Center CircularProgressIndicator as the default loader
class _LoaderOverlayState extends State<LoaderOverlay> {
  @override
  void dispose() {
    context.loaderOverlay.overlayController.dispose();
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
            final isLoading = snapshot.data['loading'] as bool;
            final widgetOverlay = snapshot.data['widget'] as Widget;
            return Stack(
              children: <Widget>[
                widget.child,
                isLoading
                    ? Opacity(
                        opacity: isLoading ? (widget.overlayOpacity ?? 0.4) : 0,
                        child: Container(
                          color: widget.overlayColor,
                          child: widgetOverlay != null
                              ? _widgetOverlay(widgetOverlay)
                              : widget.useDefaultLoading
                                  ? _getDefaultLoadingWidget()
                                  : widget.overlayWidget,
                        ),
                      )
                    : const SizedBox.shrink(),
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
        child: CircularProgressIndicator(),
      );
}
