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
        child: MyHomePage(title: 'Flutter Demo Home Page'),
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
          '/': (context) => Page1(),
        },
      ),
    );
  }
}

class Page1 extends StatefulWidget {
  Page1({Key key}) : super(key: key);

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  void initState() {
    context.loaderOverlay.show();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoaderVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
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
