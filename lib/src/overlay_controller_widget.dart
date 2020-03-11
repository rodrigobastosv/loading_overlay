import 'dart:async';

import 'package:flutter/cupertino.dart';

class OverlayControllerWidget extends InheritedWidget {
  OverlayControllerWidget({Widget child}) : super(child: child);

  static OverlayControllerWidget of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<OverlayControllerWidget>();

  final StreamController visibilityController = StreamController<bool>();

  Stream<bool> get visibilityStream => visibilityController.stream;

  void setOverlayVisible(bool loading) => visibilityController.add(loading);

  void dispose() => visibilityController.close();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
