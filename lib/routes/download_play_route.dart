import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video/models/episode.dart';
import 'package:flutter_video/widgets/player.dart';

class DownloadPlayRoute extends StatefulWidget {
  final Episode episode;

  const DownloadPlayRoute({Key key, this.episode}) : super(key: key);

  @override
  _DownloadPlayRouteState createState() => _DownloadPlayRouteState();
}

class _DownloadPlayRouteState extends State<DownloadPlayRoute> {
  @override
  Widget build(BuildContext context) {
    var title = widget.episode.type == 'movie'
        ? widget.episode.title
        : '${widget.episode.title} ${widget.episode.episode}';
    return Material(
      child: Player(
        title: title,
        url: widget.episode?.path ?? '',
        type: UrlType.file,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}
