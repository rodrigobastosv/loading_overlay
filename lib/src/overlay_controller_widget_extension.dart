import 'package:flutter/material.dart';

import 'overlay_controller_widget.dart';

extension OverlayControllerWidgetExtension on BuildContext {
  OverlayControllerWidget getOverlayController() =>
      OverlayControllerWidget.of(this);

  void showLoadingOverlay() => getOverlayController().setOverlayVisible(true);

  void hideLoadingOverlay() => getOverlayController().setOverlayVisible(false);
}
