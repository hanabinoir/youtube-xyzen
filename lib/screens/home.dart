import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late WebViewController _controller;
  String? currentUrl;
  late bool _isWatching;

  Future<void> _blockAds() async {
    String js = await rootBundle.loadString('assets/adblocker.js');
    String res = await _controller.runJavascriptReturningResult(js);
    if (res == 'null') { return; }
    log('Result: $res');
  }

  bool _setWatchStatus() => currentUrl != null && currentUrl!.contains('watch');

  @override
  void initState() {
    super.initState();
    _isWatching = _setWatchStatus();
  }

  @override
  Widget build(BuildContext context) {
    const String _homeUrl = 'https://m.youtube.com';

    return Scaffold(
      backgroundColor: _isWatching
          ? Colors.grey[850]
          : Colors.white,
      body: SafeArea(
        child: WebView(
          initialUrl: _homeUrl,
          onWebViewCreated: (controller) {
            setState(() {
              _controller = controller;
            });
          },
          onProgress: (progress) {
            log('Progress: $progress%');
          },
          onPageFinished: (url) {
            log('URL: url');
            setState(() {
              _blockAds();
              _isWatching = _setWatchStatus();
              log('Watching a video: $_isWatching');
            });
          },
          onWebResourceError: (error) {
            log('Error: ${error.description}');
          },
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
