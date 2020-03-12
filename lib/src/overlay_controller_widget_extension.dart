import 'package:flutter/material.dart';

import 'overlay_controller_widget.dart';

extension OverlayControllerWidgetExtension on BuildContext {
  OverlayControllerWidget getOverlayController() =>
      OverlayControllerWidget.of(this);

  void showLoaderOverlay() => getOverlayController().setOverlayVisible(true);

  void hideLoaderOverlay() => getOverlayController().setOverlayVisible(false);
}
