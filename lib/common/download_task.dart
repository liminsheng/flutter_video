import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_video/common/download_util.dart';
import 'package:flutter_video/models/episode.dart';

class DownloadTask {
  DownloadTask(this.context, this.episode);

  final BuildContext context;
  final Episode episode;
  CancelToken _cancelToken = CancelToken();

  void download() async {
    await DownloadUtil.getInstance(context).downloadMovie(episode, _cancelToken,
        (count, total, path) {
      episode.progress = count;
      episode.size = total;
      episode.path = path;
      episode.finish = count >= total;
    });
  }

  void pause() {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
  }
}
