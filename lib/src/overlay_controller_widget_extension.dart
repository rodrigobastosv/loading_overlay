import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

final _keyScaff = GlobalKey<ScaffoldState>();

const globalLoaderContext = _GlobalLoaderContext._();

class _GlobalLoaderContext {
  const _GlobalLoaderContext._();

  _OverlayExtensionHelper get loaderOverlay => _OverlayExtensionHelper(
      OverlayControllerWidget.of(_keyScaff.currentState!.context));

  /// init GlobalLoaderContext: Add in your MaterialApp
  /// return MaterialApp(
  ///         builder: GlobalLoaderContext.builder,
  ///         ...
  ///
  /// Example:
  /// ```
  /// import 'package:loader_overlay/loader_overlay.dart';
  ///
  ///  MaterialApp(
  ///      builder: GlobalLoaderContext.builder,
  ///      navigatorObservers: [
  ///         GlobalLoaderContext.globalLoaderContextHeroController //if u don`t add this Hero will not work
  ///      ],
  ///  );
  /// ```
  Widget builder(BuildContext context, Widget? child) {
    return GlobalLoaderOverlay(
      child: Navigator(
        initialRoute: '/',
        observers: [globalLoaderContextHeroController],
        onGenerateRoute: (_) => MaterialPageRoute(
          builder: (context) => _BuildPage(child: child),
        ),
      ),
    );
  }

  HeroController get globalLoaderContextHeroController => HeroController(
      createRectTween: (begin, end) =>
          MaterialRectCenterArcTween(begin: begin, end: end));
}

class _BuildPage extends StatefulWidget {
  final Widget? child;

  const _BuildPage({Key? key, this.child}) : super(key: key);

  @override
  __BuildPageState createState() => __BuildPageState();
}

class __BuildPageState extends State<_BuildPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _keyScaff,
      body: widget.child,
    );
  }
}

///Just a extension to make it cleaner to show or hide the overlay
extension OverlayControllerWidgetExtension on BuildContext {
  @Deprecated('Use context.loaderOverlay instead')
  OverlayControllerWidget? getOverlayController() =>
      OverlayControllerWidget.of(this);

  _OverlayExtensionHelper get loaderOverlay =>
      _OverlayExtensionHelper(OverlayControllerWidget.of(this));
}

class _OverlayExtensionHelper {
  static final _OverlayExtensionHelper _singleton =
      _OverlayExtensionHelper._internal();
  late OverlayControllerWidget _overlayController;

  Widget Function(dynamic progress)? _widgetBuilder;
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

  void show({
    Widget Function(dynamic progress)? widgetBuilder,
    dynamic progress,
  }) {
    _widgetBuilder = widgetBuilder;
    _visible = true;
    _overlayController.setOverlayVisible(
      _visible!,
      widgetBuilder: _widgetBuilder,
      progress: progress,
    );
  }

  void progress(dynamic progress, {bool onlyOnVisible = true}) {
    if (onlyOnVisible && visible) {
      _overlayController.setOverlayVisible(
        visible,
        widgetBuilder: _widgetBuilder,
        progress: progress,
      );
    }
  }

  void hide() {
    _visible = false;
    _overlayController.setOverlayVisible(_visible!);
  }
}
