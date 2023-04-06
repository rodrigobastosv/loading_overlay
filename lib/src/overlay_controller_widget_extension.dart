import 'package:flutter/material.dart';
import 'overlay_controller_widget.dart';
import 'package:loader_overlay/loader_overlay.dart';

final _keyScaff = GlobalKey<ScaffoldState>();
const GlobalLoaderContext = _GlobalLoaderContext._();

class _GlobalLoaderContext {
  const _GlobalLoaderContext._();
  static void _checkBuilderIsInMaterialApp() {
    assert(_keyScaff.currentState != null,
        """Add GlobalLoaderContext.builder in your MaterialApp;
       return MaterialApp(
         builder: GlobalLoaderContext.builder,
         ...
  """);
  }

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
