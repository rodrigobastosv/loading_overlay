#  Introduction

Have you ever found yourself in the situation of doing some async processing your screen and wanting to prevent the user from interacting with the screen while the application is loading? If so, this package was made just for you.

# Basic Usage

The most simple usage is just wrap the widget that you want an overlay on LoadingOverlay with the useDefaultLoading set to true.

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoadingOverlay(
        useDefaultLoading: true,
        child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
```

This simple step will already configure the loading overlay for use.

After that configuration you can just run the command:

```
context.showLoadingOverlay()
```

This will show the overlay with the default loading indicator. The default loading configured is to just show a centered CircularProgressIndicator

To hide the overlay (after the async processing, for example), just run the command:

```
context.hideLoadingOverlay()
```

*Note: You will always need the context to show or hide the loading overlay

![enter image description here](https://s5.gifyu.com/images/default.gif)

# More Advanced Usage
If you don't like the default widget behavior, you can set the background colors of the image, the color of the shimmer base effect, and the color of the highlighted effect.

```dart
FancyShimmerImage(
  imageUrl: 'https://static.businessinsider.sg/2018/12/12/5c1c90f8e04d6243c7019cf6.png',
  shimmerBaseColor: randomColor(),
  shimmerHighlightColor: randomColor(),
  shimmerBackColor: randomColor(),
)
```

By randomizing the colors you can have a result similar to this:

![enter image description here](https://s5.gifyu.com/images/randomad6f88534e0cedf4.gif)

Other thing you can do is to configure the direction of the Shimmer and it's speed. In the above example i configured it to have top to bottom direction and 300 milliseconds of speed.

![enter image description here](https://s5.gifyu.com/images/fast.gif)

One last step you can configure is to configure the widget that will appear in case the image upload fails for some reason. In this case just pass the desired widget in the `errorWidget` parameter. If no value is passed, a default error widget will be used.

```dart
FancyShimmerImage(
  imageUrl: 'https://static.businessinsider.sg/2018/12/12/5c1c90f8e04d6243c7019cf6.png',
  errorWidget: Image.network('https://i0.wp.com/www.dobitaobyte.com.br/wp-content/uploads/2016/02/no_image.png?ssl=1'),
)
```

![enter image description here](https://s5.gifyu.com/images/error.png)