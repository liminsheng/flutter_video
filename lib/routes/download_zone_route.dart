import 'package:flutter/material.dart';

class DownloadZoneRoute extends StatefulWidget {
  @override
  _DownloadZoneRouteState createState() => _DownloadZoneRouteState();
}

class _DownloadZoneRouteState extends State<DownloadZoneRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('下载专区', style: TextStyle(fontFamily: 'ZhiMangXing')),
      ),
    );
  }
}
