import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video/common/download_provider.dart';
import 'package:flutter_video/common/download_task.dart';
import 'package:flutter_video/common/download_util.dart';
import 'package:flutter_video/l10n/localization_intl.dart';
import 'package:flutter_video/models/episode.dart';

class DownloadingRoute extends StatefulWidget {
  @override
  _DownloadingRouteState createState() => _DownloadingRouteState();
}

class _DownloadingRouteState extends State<DownloadingRoute> {
  DownloadProvider downloadProvider = DownloadProvider();
  Future loadDataFuture;
  List<DownloadTask> _downloadTasks = [];
  Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      var tasks = DownloadUtil.getInstance(context).downloadTask;
      print('periodic ${tasks.length}');
      setState(() {
        _downloadTasks = tasks;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    downloadProvider.close();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyLocalizations.of(context).downloading,
            style: TextStyle(fontFamily: 'ZhiMangXing')),
      ),
      body: _downloadTasks.length == 0
          ? _noData
          : ListView.builder(
              itemCount: _downloadTasks.length,
              itemBuilder: (context, index) {
                return _buildItem(_downloadTasks[index]);
              }),
    );
  }

  Widget get _noData => Center(
        child: Wrap(
          children: [
            Text('没有正在下载的视频哦！'),
            InkWell(
              child: Icon(Icons.refresh),
              onTap: () {
                setState(() {
                  loadDataFuture = getData();
                });
              },
            )
          ],
        ),
      );

  Future<List<Episode>> getData() async {
    var list = await downloadProvider.getEpisodes(false);
    return list;
  }

  Widget _buildItem(DownloadTask task) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Container(
          width: 160.h,
          height: 90.w,
          child: CachedNetworkImage(
            imageUrl: task.episode.cover,
            fit: BoxFit.cover,
            placeholder: (context, url) {
              return Image.asset(
                'images/default_placeholder.png',
                fit: BoxFit.cover,
              );
            },
          ),
        ),
      ),
      title: Text(task.episode.title),
      subtitle: Text('第${task.episode.episode}集 已下载: ${task.episode.progress}'),
      onTap: () {
        // Navigator.pushNamed(context, 'downloadPlay', arguments: task.episode);
      },
    );
  }
}
