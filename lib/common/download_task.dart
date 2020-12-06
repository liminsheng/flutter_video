import 'package:flutter/cupertino.dart';
import 'package:flutter_video/common/download_util.dart';
import 'package:flutter_video/models/episode.dart';

class DownloadTask {
  DownloadTask(this.context, this.episode);

  final BuildContext context;
  final Episode episode;

  void download() async {
    await DownloadUtil.instance(context).downloadMovie(episode,
        (count, total, path) {
      episode.progress = count;
      episode.size = total;
      episode.path = path;
      episode.finish = count >= total;
    });
  }
}
