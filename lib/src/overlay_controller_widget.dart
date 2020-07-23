import 'dart:async';

import 'package:flutter/cupertino.dart';

///The inherited widget that guarantees the behavior of the overlay
class OverlayControllerWidget extends InheritedWidget {
  OverlayControllerWidget({Widget child}) : super(child: child);

  static OverlayControllerWidget of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<OverlayControllerWidget>();

  final StreamController visibilityController = StreamController<bool>();

  Stream<bool> get visibilityStream => visibilityController.stream;

  ///Set the visibility of the overlay
  void setOverlayVisible(bool loading) => visibilityController.add(loading);

  ///Dispose the controller
  void dispose() => visibilityController.close();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
