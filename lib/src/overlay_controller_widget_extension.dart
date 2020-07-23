import 'package:flutter/material.dart';

import 'overlay_controller_widget.dart';

///Just a extension to make it cleaner to show or hide the overlay
extension OverlayControllerWidgetExtension on BuildContext {
  OverlayControllerWidget getOverlayController() =>
      OverlayControllerWidget.of(this);

  ///Extension created to show the overlay
  void showLoaderOverlay() => getOverlayController().setOverlayVisible(true);

  ///Extension created to hide the overlay
  void hideLoaderOverlay() => getOverlayController().setOverlayVisible(false);
}
