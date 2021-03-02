#  Introduction

Have you ever found yourself in the situation of doing some async processing your screen and wanting to prevent the user from interacting with the screen while the application is loading? If so, this package was made just for you.

# Basic Usage

The most simple usage is just wrap the widget that you want an overlay on LoaderOverlay. Default loader will be shown.

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoaderOverlay(
        child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
```

This simple step will already configure the loader overlay for use.

After that configuration you can just run the command:

```dart
context.loaderOverlay.show()
```

This will show the overlay with the default loading indicator. The default loading configured is to just show a centered CircularProgressIndicator

To hide the overlay (after the async processing, for example), just run the command:

```dart
context.loaderOverlay.hide()
```

You can check if overlay is visible:

```dart
final isVisible = context.loaderOverlay.visible
```

And get the type of overlay widget:

```dart
final type = context.loaderOverlay.overlayWidgetType
```


*Note: You will always need the context to show or hide the loader overlay

![enter image description here](https://media.giphy.com/media/IgGXIvgUtHNjWlWFQm/giphy.gif)

# Basic Usage on Named Routes
To use this package with named routes you can just wrap your MaterialApp with GlobalLoaderOverlay.
This widget has all the features of LoaderOverlay but it is provided for all the routes of the app.


```dart
@override
Widget build(BuildContext context) {
return GlobalLoaderOverlay(
  child: MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(primarySwatch: Colors.teal, fontFamily: 'Baloo'),
    initialRoute: '/',
    routes: {
      '/': (context) => Page1(),
      '/page2': (context) => Page2(),
    },
  ),
);
}
```

# Customisation
Your overlay loader widget can be any widget you want. For example you can import the package
 ![flutter_spinkit][flutter_spinkit] and customise your widget like this. To do that just pass your widget to `overlayWidget` and set `useDefaultLoading` to `false`.

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: Center(
          child: SpinKitCubeGrid(
            color: Colors.red,
            size: 50.0,
          ),
        ),
        child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
```

![enter image description here](https://media.giphy.com/media/Q8gY97DxhO8KZgQfT6/giphy.gif)

Another customisation you can do is configure the opacity of the overlay. The default opacity is 0.4, but you can pass your own opacity by setting the `overlayOpacity` property.

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: Center(
          child: SpinKitCubeGrid(
            color: Colors.red,
            size: 50.0,
          ),
        ),
        overlayOpacity: 0.8,
        child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
```

This is a much opaque overlay:

![enter image description here](https://media.giphy.com/media/StKBJJ50luIOPjDunM/giphy.gif)

You may want to have several different loaders in your app. In this case just pass any widget to the `loaderOverlay.show`:

```dart
class ReconnectingOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CircularProgressIndicator(),
            ),
            SizedBox(height: 12),
            Text(
              'Reconnecting...',
            ),
          ],
        ),
      );
}

context.loaderOverlay.show(
  widget: ReconnectingOverlay()
),
```

And then you can check the type before hide it:

```dart
if (context.loaderOverlay.visible && context.loaderOverlay.overlayWidgetType == ReconnectingOverlay) {
  context.loaderOverlay.hide();
}
```

If you pass widget to `context.loaderOverlay.show`, then `defaultLoader` and `widgetOverlay` will be ignored;

## Todo

- [ ] Tests

## Suggestions & Bugs

For any suggestions or bug report please head to [issue tracker][tracker].

[tracker]: https://github.com/rodrigobastosv/loading_overlay/issues
[flutter_spinkit]: https://pub.dev/packages/flutter_spinkit
