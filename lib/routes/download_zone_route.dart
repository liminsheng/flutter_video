import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_video/models/downloadSubject.dart';
import 'package:flutter_video/widgets/download_item.dart';

class DownloadZoneRoute extends StatefulWidget {
  @override
  _DownloadZoneRouteState createState() => _DownloadZoneRouteState();
}

class _DownloadZoneRouteState extends State<DownloadZoneRoute> {
  List<DownloadSubject> _downloadList = [];

  @override
  void initState() {
    _loadDownloadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('下载专区', style: TextStyle(fontFamily: 'ZhiMangXing')),
      ),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: _downloadList.length,
        itemBuilder: (BuildContext context, int index) =>
            DownloadItem(_downloadList[index], index.isEven),
        staggeredTileBuilder: (int index) =>
            StaggeredTile.count(2, index.isEven ? 2 : 1),
        mainAxisSpacing: 4.0.h,
        crossAxisSpacing: 4.0.w,
      ),
    );
  }

  void _loadDownloadData() {
    rootBundle.loadString('assets/download_list.json').then((value) {
      var list = json.decode(value) as List;
      setState(() {
        _downloadList = list.map((e) => DownloadSubject.fromJson(e)).toList();
      });
    });
  }
}
