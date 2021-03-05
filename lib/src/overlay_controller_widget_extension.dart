import 'package:flutter/material.dart';

import 'overlay_controller_widget.dart';

///Just a extension to make it cleaner to show or hide the overlay
extension OverlayControllerWidgetExtension on BuildContext {
  @Deprecated('Use context.loaderOverlay instead')
  OverlayControllerWidget? getOverlayController() =>
      OverlayControllerWidget.of(this);

  ///Extension created to show the overlay
  @Deprecated('Use context.loaderOverlay.show() instead')
  void showLoaderOverlay({
    Widget? widget,
  }) =>
      getOverlayController()!.setOverlayVisible(true, widget: widget);

  ///Extension created to hide the overlay
  @Deprecated('Use context.loaderOverlay.hide() instead')
  void hideLoaderOverlay() => getOverlayController()?.setOverlayVisible(false);

  _OverlayExtensionHelper get loaderOverlay =>
      _OverlayExtensionHelper(OverlayControllerWidget.of(this));
}

class _OverlayExtensionHelper {
  static final _OverlayExtensionHelper _singleton =
      _OverlayExtensionHelper._internal();
  late OverlayControllerWidget _overlayController;

  Widget? _widget;
  bool? _visible;

  OverlayControllerWidget get overlayController => _overlayController;
  bool get visible => _visible ?? false;

  factory _OverlayExtensionHelper(OverlayControllerWidget? overlayController) {
    if (overlayController != null) {
      _singleton._overlayController = overlayController;
    }

    return _singleton;
  }
  _OverlayExtensionHelper._internal();

  Type? get overlayWidgetType => _widget?.runtimeType;

  void show({Widget? widget}) {
    _widget = widget;
    _visible = true;
    _overlayController.setOverlayVisible(_visible!, widget: _widget);
  }

  void hide() {
    _visible = false;
    _overlayController.setOverlayVisible(_visible!);
  }
}
