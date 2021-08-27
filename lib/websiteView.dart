// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'website.dart';
import 'Extensions.dart';

class WebsiteView extends StatefulWidget {
  const WebsiteView(
      {required this.website, required this.dateTimeOpened, Key? key})
      : super(key: key);
  final Website website;
  final DateTime dateTimeOpened;

  @override
  _WebsiteViewState createState() => _WebsiteViewState();
}

class _WebsiteViewState extends State<WebsiteView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: true,
        title: Text(widget.website.name),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0, top: 20),
            child: Text(widget.dateTimeOpened.toFormatterString()),
          )
        ],
      ),
      body: Builder(builder: (context) {
        return WebView(
          initialUrl: widget.website.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) => {_controller.complete(controller)},
        );
      }),
    );
  }
}
// // ignore: use_key_in_widget_constructors
// class WebViewExample extends StatefulWidget {
//   @override
//   _WebViewExampleState createState() => _WebViewExampleState();
// }

// class _WebViewExampleState extends State<WebViewExample> {
//   final Completer<WebViewController> _controller =
//       Completer<WebViewController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Flutter WebView example'),
//         ),
//         // We're using a Builder here so we have a context that is below the Scaffold
//         // to allow calling Scaffold.of(context) so we can show a snackbar.
//         body: Builder(builder: (BuildContext context) {
//           return WebView(
//             initialUrl: 'https://flutter.dev',
//             javascriptMode: JavascriptMode.unrestricted,
//             onWebViewCreated: (WebViewController webViewController) {
//               _controller.complete(webViewController);
//             },
//             onProgress: (int progress) {
//               // ignore: avoid_print
//               print("WebView is loading (progress : $progress%)");
//             },
//             navigationDelegate: (NavigationRequest request) {
//               if (request.url.startsWith('https://www.youtube.com/')) {
//                 print('blocking navigation to $request}');
//                 return NavigationDecision.prevent;
//               }
//               print('allowing navigation to $request');
//               return NavigationDecision.navigate;
//             },
//             onPageStarted: (String url) {
//               // ignore: avoid_print
//               print('Page started loading: $url');
//             },
//             onPageFinished: (String url) {
//               print('Page finished loading: $url');
//             },
//             gestureNavigationEnabled: true,
//           );
//         }));
//   }
// }
