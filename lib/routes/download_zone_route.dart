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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('下载专区', style: TextStyle(fontFamily: 'ZhiMangXing')),
      ),
      body: FutureBuilder<List<DownloadSubject>>(
        future: _loadDownloadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text('网络跑到外星球去了...'),
              );
            } else {
              var downloadList = snapshot.data;
              return StaggeredGridView.countBuilder(
                crossAxisCount: 4,
                itemCount: downloadList.length,
                itemBuilder: (BuildContext context, int index) =>
                    DownloadItem(downloadList[index], index.isEven),
                staggeredTileBuilder: (int index) =>
                    StaggeredTile.count(2, index.isEven ? 2 : 1),
                mainAxisSpacing: 4.0.h,
                crossAxisSpacing: 4.0.w,
              );
            }
          } else {
            return _loading;
          }
        },
      ),
    );
  }

  Widget get _loading => Center(
        child: CircularProgressIndicator(),
      );

  Future<List<DownloadSubject>> _loadDownloadData() async {
    var value = await rootBundle.loadString('assets/download_list.json');
    var list = json.decode(value) as List;
    return list.map((e) => DownloadSubject.fromJson(e)).toList();
  }
}
