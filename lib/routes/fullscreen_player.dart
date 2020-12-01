import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FullscreenPlayer extends StatefulWidget {

  final Map<String, dynamic> data;

  const FullscreenPlayer({Key key, this.data}) : super(key: key);
  @override
  _FullscreenPlayerState createState() => _FullscreenPlayerState();
}

class _FullscreenPlayerState extends State<FullscreenPlayer> {

  @override
  void initState() {
    super.initState();
    // AutoOrientation.landscapeAutoMode();
  }

  @override
  void dispose() {
    AutoOrientation.portraitAutoMode();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
          tag: 'player',
          child: AspectRatio(
            aspectRatio: widget.data['controller'].value.aspectRatio,
            child: VideoPlayer(widget.data['controller']),
          )),
    );
  }
}
