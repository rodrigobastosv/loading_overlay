import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

void main() => runApp(MyAppGlobalLoaderOverlay());

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
      /*useDefaultLoading: false,
      overlayWidgetBuilder: (_) { //ignored progress for the moment
        return Center(
          child: SpinKitCubeGrid(
            color: Colors.red,
            size: 50.0,
          ),
        );
      },*/
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
              child: Text('Show overlay for 2 seconds'),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                context.loaderOverlay.show(
                    widgetBuilder: (progress) {
                      return ReconnectingOverlay(
                        progress != null ? progress as String : null,
                      );
                    },
                    progress: 'Trying to reconnect');
                setState(() {
                  _isLoaderVisible = context.loaderOverlay.visible;
                });
                await Future.delayed(Duration(seconds: 3));
                if (_isLoaderVisible) {
                  context.loaderOverlay.hide();
                }
                setState(() {
                  _isLoaderVisible = context.loaderOverlay.visible;
                });
              },
              child: Text('Show custom loader overlay for 2 seconds'),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                context.loaderOverlay.show(
                  progress: 'Doing progress #0',
                );
                setState(() {
                  _isLoaderVisible = context.loaderOverlay.visible;
                });

                await Future.delayed(Duration(seconds: 1));
                context.loaderOverlay.progress('Doing progress #1');
                await Future.delayed(Duration(seconds: 1));
                context.loaderOverlay.progress('Doing progress #2');
                await Future.delayed(Duration(seconds: 1));
                context.loaderOverlay.progress('Doing progress #3');
                await Future.delayed(Duration(seconds: 1));

                if (_isLoaderVisible) {
                  context.loaderOverlay.hide();
                }
                setState(() {
                  _isLoaderVisible = context.loaderOverlay.visible;
                });
              },
              child: Text('Show loader overlay for 5 seconds with progress'),
            ),
            SizedBox(height: 34),
            Text('Is loader visible: $_isLoaderVisible'),
          ],
        ),
      ),
    );
  }
}

class ReconnectingOverlay extends StatelessWidget {
  String? progress;

  ReconnectingOverlay(this.progress);

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 12),
            Text(
              'Reconnecting...',
            ),
            SizedBox(height: 12),
            Text(
              progress ?? '',
            ),
          ],
        ),
      );
}
