import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';

void main() => runApp(const MyAppGlobalLoaderOverlay());

class MyAppGlobalLoaderOverlay extends StatelessWidget {
  const MyAppGlobalLoaderOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      duration: Durations.medium4,
      reverseDuration: Durations.medium4,
      overlayColor: Colors.grey.withOpacity(0.8),
      overlayWidgetBuilder: (_) {
        //ignored progress for the moment
        return const Center(
          child: SpinKitCubeGrid(
            color: Colors.red,
            size: 50.0,
          ),
        );
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.black,
          fontFamily: 'Baloo',
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const MyHomePage(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
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
                await Future.delayed(const Duration(seconds: 2));
                if (_isLoaderVisible && context.mounted) {
                  context.loaderOverlay.hide();
                }
                setState(() {
                  _isLoaderVisible = context.loaderOverlay.visible;
                });
              },
              child: const Text('Show overlay for 2 seconds'),
            ),
            const SizedBox(height: 24),
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
                await Future.delayed(const Duration(seconds: 3));
                if (_isLoaderVisible && context.mounted) {
                  context.loaderOverlay.hide();
                }
                setState(() {
                  _isLoaderVisible = context.loaderOverlay.visible;
                });
              },
              child: const Text('Show custom loader overlay for 2 seconds'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                context.loaderOverlay.show(
                  progress: 'Doing progress #0',
                );
                setState(() {
                  _isLoaderVisible = context.loaderOverlay.visible;
                });

                await Future.delayed(const Duration(seconds: 1));
                if (context.mounted) {
                  context.loaderOverlay.progress('Doing progress #1');
                }
                await Future.delayed(const Duration(seconds: 1));
                if (context.mounted) {
                  context.loaderOverlay.progress('Doing progress #2');
                }
                await Future.delayed(const Duration(seconds: 1));
                if (context.mounted) {
                  context.loaderOverlay.progress('Doing progress #3');
                }
                await Future.delayed(const Duration(seconds: 1));

                if (_isLoaderVisible && context.mounted) {
                  context.loaderOverlay.hide();
                }
                setState(() {
                  _isLoaderVisible = context.loaderOverlay.visible;
                });
              },
              child:
                  const Text('Show loader overlay for 5 seconds with progress'),
            ),
            const SizedBox(height: 34),
            Text('Is loader visible: $_isLoaderVisible'),
          ],
        ),
      ),
    );
  }
}

class ReconnectingOverlay extends StatelessWidget {
  final String? progress;

  const ReconnectingOverlay(this.progress, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 12),
            const Text(
              'Reconnecting...',
            ),
            const SizedBox(height: 12),
            Text(
              progress ?? '',
            ),
          ],
        ),
      );
}
