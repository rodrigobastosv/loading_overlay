import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';

void main() => runApp(MyApp());

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
        child: MyHomePage(),
      ),
    );
  }
}

class MyAppGlobalLoaderOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.black,
          fontFamily: 'Baloo',
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => MyHomePage(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoaderVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                context.loaderOverlay.show();
                setState(() {
                  _isLoaderVisible = context.loaderOverlay.visible;
                });
                await Future.delayed(Duration(seconds: 2));
                if (_isLoaderVisible) {
                  context.loaderOverlay.hide();
                }
                setState(() {
                  _isLoaderVisible = context.loaderOverlay.visible;
                });
              },
              child: Text('Show loader overlay for 2 seconds'),
            ),
            ElevatedButton(
              onPressed: () async {
                context.loaderOverlay.show(widget: ReconnectingOverlay());
                setState(() {
                  _isLoaderVisible = context.loaderOverlay.visible;
                });
                await Future.delayed(Duration(seconds: 3));
                if (_isLoaderVisible &&
                    context.loaderOverlay.overlayWidgetType ==
                        ReconnectingOverlay) {
                  context.loaderOverlay.hide();
                }
                setState(() {
                  _isLoaderVisible = context.loaderOverlay.visible;
                });
              },
              child: Text('Show custom loader overlay for 2 seconds'),
            ),
            Text('Is loader visible: $_isLoaderVisible'),
          ],
        ),
      ),
    );
  }
}

class ReconnectingOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 12),
            Text(
              'Reconnecting...',
            ),
          ],
        ),
      );
}
