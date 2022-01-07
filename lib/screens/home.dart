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
  late bool _isWatching;
  late WebViewController _controller;

  String? _currentUrl;
  bool _isAdBlocked = false;

  Future<void> _prepare() async {
    await _runJS('prepare');
  }

  Future<void> _blockAds() async {
    if (_isAdBlocked) { return; }
    await _runJS('adblocker');
    _isAdBlocked = true;
  }

  Future<void> _runJS(filename) async {
    String js = await rootBundle.loadString('assets/$filename.js');
    String res = await _controller.runJavascriptReturningResult(js);
    if (res == 'null') { return; }
    log('Result: $res');
  }

  bool _setWatchStatus() => _currentUrl != null && _currentUrl!.contains('watch');

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
          onWebViewCreated: (controller) async {
            setState(() {
              _controller = controller;
            });
            await _prepare();
          },
          onProgress: (progress) {
            log('Progress: $progress%');
          },
          onPageFinished: (url) async {
            log('URL: url');
            bool isWatching = _setWatchStatus();
            if (!isWatching) {
              await _prepare();
            }
            setState(() {
              _currentUrl = url;
              _isWatching = isWatching;
              log('Watching a video: $_isWatching');
            });
            _blockAds();
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
