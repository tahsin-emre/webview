import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:connectivity/connectivity.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    runApp(NoConnection());
  } else {
    runApp(MyApp());
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var connectivityResult = (Connectivity().checkConnectivity());
  WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalemimce',
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        String url = await _MyAppState().webViewController.currentUrl();
        if (url == 'https://kalemimce.com/') {
          return true;
        } else {
          _MyAppState().webViewController.goBack();
          return false;
        }
      },
      child: Container(
        color: Colors.white,
        child: SafeArea(
            child: WebView(
          gestureNavigationEnabled: true,
          onWebViewCreated: (WebViewController wc) {
            _MyAppState().webViewController = wc;
          },
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: 'https://kalemimce.com/',
        )),
      ),
    );
  }
}

class NoConnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Check your connection',
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}
