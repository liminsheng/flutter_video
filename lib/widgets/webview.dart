import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video/l10n/localization_intl.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebView extends StatefulWidget {
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  WebView(
      {this.url,
      this.statusBarColor,
      this.title,
      this.hideAppBar,
      this.backForbid = false});

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final FlutterWebviewPlugin webviewPlugin = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;
  bool exiting = false;

  @override
  void initState() {
    super.initState();
    webviewPlugin.close();
    _onUrlChanged = webviewPlugin.onUrlChanged.listen((url) {});
    _onStateChanged = webviewPlugin.onStateChanged.listen((state) {
      switch (state.type) {
        case WebViewState.startLoad:
          // if (!exiting) {
          //   if (widget.backForbid) {
          //     webviewPlugin.launch(state.url);
          //   } else {
          //     Navigator.pop(context);
          //     exiting = true;
          //   }
          // }
          break;
        default:
          break;
      }
    });
    _onHttpError = webviewPlugin.onHttpError.listen((error) {
      print(error);
    });
  }

  @override
  void dispose() {
    _onHttpError.cancel();
    _onStateChanged.cancel();
    _onUrlChanged.cancel();
    webviewPlugin.dispose();
    super.dispose();
  }

  // _isToMain(String url) {
  //   bool contain = false;
  //   for (final value in CATCH_URLS) {
  //     if (url?.endsWith(value) ?? false) {
  //       contain = true;
  //       break;
  //     }
  //   }
  //   return contain;
  // }

  @override
  Widget build(BuildContext context) {
    String statusBarColor = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColor == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }
    return Scaffold(
      body: Column(
        children: [
          _appBar(Color(int.parse('0xff' + statusBarColor)), backButtonColor),
          Expanded(
            child: WebviewScaffold(
              url: widget.url,
              withLocalStorage: true,
              withZoom: true,
              hidden: true,
              initialChild: Container(
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text(MyLocalizations.of(context).waiting)
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _appBar(Color backgroundColor, Color backButtonColor) {
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backgroundColor,
        height: 30,
      );
    }
    return Container(
      padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
      color: backgroundColor,
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 26,
                ),
              ),
            ),
            Center(
              child: Text(widget.title ?? MyLocalizations.of(context).title,
                  style: TextStyle(fontSize: 20, color: backButtonColor)),
            ),
          ],
        ),
      ),
    );
  }
}
