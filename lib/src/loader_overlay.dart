library loader_overlay;

import 'package:flutter/material.dart';

import '../loader_overlay.dart';

/// Class that efetivally display the overlay on the screen. It's a Stateful widget
/// so we can dispose when not needed anymore
class LoaderOverlay extends StatefulWidget {
  LoaderOverlay(
      {this.overlayWidget,
      this.useDefaultLoading = false,
      this.overlayOpacity,
      this.overlayColor = Colors.grey,
      @required this.child})
      : assert(overlayWidget != null || useDefaultLoading != null),
        assert(child != null);

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
    context.getOverlayController().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayControllerWidget(
      child: Builder(
        builder: (innerContext) => StreamBuilder<bool>(
          stream: innerContext.getOverlayController().visibilityStream,
          initialData: false,
          builder: (_, snapshot) {
            return Stack(
              children: <Widget>[
                widget.child,
                snapshot.data
                    ? Opacity(
                        opacity:
                            snapshot.data ? (widget.overlayOpacity ?? 0.4) : 0,
                        child: Container(
                          color: widget.overlayColor,
                          child: widget.useDefaultLoading
                              ? _getDefaultLoadingWidget()
                              : widget.overlayWidget,
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _getDefaultLoadingWidget() => Center(
        child: CircularProgressIndicator(),
      );
}
