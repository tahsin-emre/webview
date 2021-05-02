import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  WebViewController _webViewController;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Teori Lekse',
        home: WillPopScope(
          onWillPop: () async {
            String url = await _webViewController.currentUrl();
            if (url == 'https://teorilekse.no/') {
              return true;
            } else {
              _webViewController.goBack();
              return false;
            }
          },
          child: SafeArea(
              child: WebView(
            onWebViewCreated: (WebViewController wc) {
              _webViewController = wc;
            },
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: 'https://teorilekse.no/',
          )),
        ));
  }
}
