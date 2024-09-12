import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loader_overlay/loader_overlay.dart';

void main() {
  testWidgets('default properties', (WidgetTester tester) async {
    await tester.pumpWidget(const TestApp());

    expect(
      find.byKey(LoaderOverlay.defaultOverlayWidgetKey, skipOffstage: false),
      findsNothing,
    );

    // click to show overlay widget

    await tester.tap(
      find.byKey(TestApp.showHideOverlayIconKey),
    );

    await tester.pump();

    expect(
      find.byKey(LoaderOverlay.defaultOverlayWidgetKey),
      findsOneWidget,
    );

    final opacityFinder = find.byKey(LoaderOverlay.containerForOverlayColorKey);

    expect(opacityFinder, findsOneWidget);

    final containerFinder =
        find.byKey(LoaderOverlay.containerForOverlayColorKey);

    expect(containerFinder, findsOneWidget);

    final containerWidget = tester.firstWidget(containerFinder) as ColoredBox;

    expect(
      containerWidget.color,
      equals(LoaderOverlay.defaultOverlayColor),
    );

    await tester.pump(Duration.zero);

    expect(
      find.byKey(LoaderOverlay.defaultOverlayWidgetKey, skipOffstage: false),
      findsNothing,
    );

    expect(
      find.byKey(LoaderOverlay.containerForOverlayColorKey,
          skipOffstage: false),
      findsNothing,
    );
  });

  testWidgets(
      'custom overlayWidget is ignored when `useDefaultLoading` is not set to `false`',
      (WidgetTester tester) async {
    const containerKey = Key('b');

    await tester.pumpWidget(
      TestApp(
        // useDefaultLoading is true by default
        overlayWidgetBuilder: (progress) => Container(key: containerKey),
      ),
    );

    // default overlay widget is not visible

    expect(
      find.byKey(LoaderOverlay.defaultOverlayWidgetKey, skipOffstage: false),
      findsNothing,
    );

    // custom overlay widget is not visible

    expect(
      find.byKey(containerKey, skipOffstage: false),
      findsNothing,
    );

    // click to show overlay widget

    await tester.tap(
      find.byKey(TestApp.showHideOverlayIconKey),
    );

    await tester.pump();

    // custom overlay widget is never shown (ignored) because
    // `useDefaultLoading` has not been set to `false`

    expect(
      find.byKey(containerKey, skipOffstage: false),
      findsNothing,
    );

    // we will still show the default overlay widget even though user specified
    // a custom loader for the reason given above

    expect(
      find.byKey(LoaderOverlay.defaultOverlayWidgetKey),
      findsOneWidget,
    );

    await tester.pump(Duration.zero);

    expect(
      find.byKey(LoaderOverlay.defaultOverlayWidgetKey, skipOffstage: false),
      findsNothing,
    );
  });
  testWidgets(
      'custom overlayWidget is used when `useDefaultLoading` is set to `false`',
      (WidgetTester tester) async {
    const containerKey = Key('b');

    await tester.pumpWidget(
      TestApp(
        overlayWidgetBuilder: (progress) => Container(key: containerKey),
      ),
    );

    expect(
      find.byKey(containerKey, skipOffstage: false),
      findsNothing,
    );

    await tester.tap(
      find.byKey(TestApp.showHideOverlayIconKey),
    );

    await tester.pump();

    // we will show user's custom overlay widget

    expect(
      find.byKey(containerKey),
      findsOneWidget,
    );

    // we will not show the default overlay widget because user specified a
    // custom overlay widget and set `useDefaultLoading` to false

    expect(
      find.byKey(LoaderOverlay.defaultOverlayWidgetKey, skipOffstage: false),
      findsNothing,
    );

    await tester.pump(Duration.zero);

    expect(
      find.byKey(containerKey, skipOffstage: false),
      findsNothing,
    );
  });

  testWidgets('custom `overlayColor` and `overlayOpacity`',
      (WidgetTester tester) async {
    const overlayColor = Colors.red;
    const overlayOpacity = 0.8;

    await tester.pumpWidget(
      const TestApp(overlayColor: overlayColor),
    );

    expect(
      find.byKey(LoaderOverlay.defaultOverlayWidgetKey, skipOffstage: false),
      findsNothing,
    );

    await tester.tap(
      find.byKey(TestApp.showHideOverlayIconKey),
    );

    await tester.pump();

    expect(
      find.byKey(LoaderOverlay.defaultOverlayWidgetKey),
      findsOneWidget,
    );

    expect(
      overlayOpacity,
      equals(overlayOpacity),
    );

    final containerFinder =
        find.byKey(LoaderOverlay.containerForOverlayColorKey);

    expect(containerFinder, findsOneWidget);

    final containerWidget = tester.firstWidget(containerFinder) as ColoredBox;

    expect(
      containerWidget.color,
      isNot(
        equals(LoaderOverlay.defaultOverlayColor),
      ),
    );

    expect(
      containerWidget.color,
      equals(overlayColor),
    );

    await tester.pump(Duration.zero);

    expect(
      find.byKey(LoaderOverlay.defaultOverlayWidgetKey, skipOffstage: false),
      findsNothing,
    );
  });

  testWidgets('loading widget without no overlay layer',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TestApp());

    expect(
      find.byKey(LoaderOverlay.defaultOverlayWidgetKey, skipOffstage: false),
      findsNothing,
    );

    // click to show overlay widget

    await tester.tap(
      find.byKey(TestApp.showHideOverlayOptionalKey),
    );

    await tester.pump();

    expect(
      find.byKey(LoaderOverlay.defaultOverlayWidgetKey),
      findsOneWidget,
    );

    final opacityFinder = find.byKey(LoaderOverlay.containerForOverlayColorKey);

    expect(opacityFinder, findsNothing);

    final containerFinder =
        find.byKey(LoaderOverlay.containerForOverlayColorKey);

    expect(containerFinder, findsNothing);

    await tester.pump(Duration.zero);

    expect(
      find.byKey(LoaderOverlay.defaultOverlayWidgetKey, skipOffstage: false),
      findsNothing,
    );

    expect(
      find.byKey(LoaderOverlay.containerForOverlayColorKey,
          skipOffstage: false),
      findsNothing,
    );
  });
}

class TestApp extends StatelessWidget {
  const TestApp({
    Key? key,
    this.overlayWidgetBuilder,
    this.overlayColor,
  }) : super(key: key);

  final Widget Function(dynamic progress)? overlayWidgetBuilder;
  final Color? overlayColor;

  static const showHideOverlayIconKey = Key('@test/show-hide-overlay');
  static const showHideOverlayOptionalKey =
      Key('@test/show-hide-overlay-optional');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoaderOverlay(
        overlayWidgetBuilder: overlayWidgetBuilder,
        overlayColor: overlayColor ?? LoaderOverlay.defaultOverlayColor,
        child: Scaffold(
          body: Column(
            children: [
              IconButton(
                key: TestApp.showHideOverlayIconKey,
                onPressed: () async {
                  context.loaderOverlay.show();

                  await Future.delayed(Duration.zero);

                  context.loaderOverlay.hide();
                },
                icon: const Icon(Icons.add),
              ),
              IconButton(
                key: TestApp.showHideOverlayOptionalKey,
                onPressed: () async {
                  context.loaderOverlay.show(showOverlay: false);

                  await Future.delayed(Duration.zero);

                  context.loaderOverlay.hide();
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
