import 'package:flutter/material.dart';
import 'package:flutter_video/common/NetRequest.dart';
import 'package:flutter_video/common/download_task.dart';
import 'package:flutter_video/common/download_util.dart';
import 'package:flutter_video/models/abstract.dart';
import 'package:flutter_video/models/downloadSubject.dart';
import 'package:flutter_video/models/episode.dart';
import 'package:flutter_video/widgets/movie_detail.dart';
import 'package:flutter_video/widgets/player.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailRoute extends StatefulWidget {
  final DownloadSubject downloadSubject;

  const DetailRoute({Key key, @required this.downloadSubject})
      : super(key: key);

  @override
  _DetailRouteState createState() => _DetailRouteState();
}

class _DetailRouteState extends State<DetailRoute> {
  Abstract _detail;
  String _title;
  Episode _episode;

  @override
  void initState() {
    super.initState();
    _getDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Column(
            children: [
              Player(
                title: _title ?? '',
                url: _episode?.url ?? '',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 9 / 16,
              ),
              Expanded(
                  flex: 1,
                  child: MovieDetail(
                    abstract: _detail,
                    onDownload: _chooseDownload,
                  )),
            ],
          )),
    );
  }

  void _getDetail() async {
    Abstract abstract = await NetRequest(context)
        .getSubjectsAbstract(subjectId: widget.downloadSubject.id);
    setState(() {
      _episode = widget.downloadSubject.episodes[0];
      _title = widget.downloadSubject.type == 'movie'
          ? widget.downloadSubject.title
          : '${widget.downloadSubject.title} ${_episode.episode}';
      _detail = abstract;
    });
  }

  void _chooseDownload() {
    var episodes = widget.downloadSubject.episodes;
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              child: ListView.builder(
                  itemCount: episodes.length,
                  itemBuilder: (context, index) {
                    var episode = episodes[index];
                    var title = widget.downloadSubject.type == 'movie'
                        ? episode.title
                        : '${episode.title} ${episode.episode}';
                    return ListTile(
                      title: Text(title),
                      onTap: () => _downloadMovie(episodes[index]),
                    );
                  }),
            ));
  }

  void _downloadMovie(Episode episode) {
    print('下载${episode.title} ${episode.episode}');
    DownloadUtil.instance(context).addDownload(DownloadTask(context, episode));
  }
}
