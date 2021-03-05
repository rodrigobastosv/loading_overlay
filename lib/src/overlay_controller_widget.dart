import 'dart:async';

import 'package:flutter/cupertino.dart';

///The inherited widget that guarantees the behavior of the overlay
class OverlayControllerWidget extends InheritedWidget {
  OverlayControllerWidget({required Widget child}) : super(child: child);

  static OverlayControllerWidget? of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<OverlayControllerWidget>();

  final StreamController<Map<String, dynamic>> visibilityController = StreamController();

  Stream<Map<String, dynamic>> get visibilityStream => visibilityController.stream;

  ///Set the visibility of the overlay
  void setOverlayVisible(
    bool loading, {
    Widget? widget,
  }) =>
      visibilityController.add(<String, dynamic>{
        'loading': loading,
        'widget': widget,
      });

  ///Dispose the controller
  void dispose() => visibilityController.close();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
