import 'dart:io';

import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class UrlType {
  static const String asset = 'asset', network = 'network', file = 'file';
}

class Player extends StatefulWidget {
  final String title;
  final String url;
  final String type;
  final double width;
  final double height;
  final Function toggleFullScreen;

  const Player(
      {Key key,
      this.title,
      this.url,
      this.type = UrlType.network,
      this.width,
      this.height,
      this.toggleFullScreen})
      : super(key: key);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  VideoPlayerController controller;
  Future videoInitializeFuture;
  bool _isFullScreen = false;
  int _position = 0, _duration = 0;

  @override
  void initState() {
    super.initState();
    AutoOrientation.portraitAutoMode();
    print('Player url: ${widget.url}');
    if (widget.type == UrlType.network) {
      controller = VideoPlayerController.network(widget.url);
    } else if (widget.type == UrlType.asset) {
      controller = VideoPlayerController.asset(widget.url);
    } else {
      controller = VideoPlayerController.file(File(widget.url));
    }
    controller.addListener(_videoListener);
    videoInitializeFuture = controller.initialize().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.removeListener(_videoListener);
    controller.dispose();
    AutoOrientation.portraitAutoMode();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant Player oldWidget) {
    if (oldWidget.url != widget.url) {
      _urlChange();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _videoListener() async {
    if (controller.value.hasError) {
      print(controller.value.errorDescription);
    } else {
      var position = await controller.position;
      if (position >= controller.value.duration) {
        await controller.seekTo(Duration(seconds: 0));
        await controller.pause();
      }
      if (controller.value.isPlaying) {
        setState(() {
          _position = position.inSeconds;
          _duration = controller.value.duration.inSeconds;
        });
      }
    }
  }

  void _urlChange() {
    print('_urlChange url: ${widget.url}');
    if (widget.url != null && widget.url.isNotEmpty) {
      return;
    }
    if (controller != null) {
      controller.removeListener(_videoListener);
      controller.dispose();
    }
    controller = VideoPlayerController.network(widget.url);
    controller.addListener(_videoListener);
    videoInitializeFuture = controller.initialize().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (_isFullScreen) {
            AutoOrientation.portraitAutoMode();
            setState(() {
              _isFullScreen = !_isFullScreen;
            });
            return false;
          }
          return true;
        },
        child: Stack(
          children: [
            Container(
              color: Colors.black,
              width: _isFullScreen
                  ? MediaQuery.of(context).size.width
                  : widget.width,
              height: _isFullScreen
                  ? MediaQuery.of(context).size.height
                  : widget.height,
              child: Center(
                child: FutureBuilder(
                  future: videoInitializeFuture,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Hero(
                          tag: 'player',
                          child: AspectRatio(
                            aspectRatio: controller.value.aspectRatio,
                            child: VideoPlayer(controller),
                          ));
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ),
            Positioned(
                top: ScreenUtil().statusBarHeight,
                left: 0,
                child: Wrap(
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 20.w,
                  children: [
                    InkWell(
                      onTap: () {
                        if (_isFullScreen) {
                          setState(() {
                            AutoOrientation.portraitAutoMode();
                            _isFullScreen = !_isFullScreen;
                          });
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.w, 20.w, 10.w),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    InkWell(
                      child: Text(
                        widget.title ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white, fontSize: 36.nsp),
                      ),
                    ),
                  ],
                )),
            Positioned(
                left: 0,
                bottom: 0,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        controller.value.isPlaying
                            ? controller.pause()
                            : controller.play();
                      },
                      child: Padding(
                        padding: EdgeInsets.all(20.w),
                        child: Icon(
                          controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 190.w,
                      height: 50.h,
                      alignment: Alignment.center,
                      child: Slider(
                        value: _position.toDouble(),
                        max: _duration.toDouble(),
                        onChanged: _onProgressChanged,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _toggleFullScreen();
                      },
                      child: Padding(
                        padding: EdgeInsets.all(20.w),
                        child: Icon(
                          _isFullScreen
                              ? Icons.fullscreen_exit
                              : Icons.fullscreen,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ));
  }

  void _onProgressChanged(double value) {
    print('_onProgressChanged: $value');
  }

  void _toggleFullScreen() {
    setState(() {
      if (_isFullScreen) {
        AutoOrientation.portraitAutoMode();
        // Navigator.of(context).pop();
      } else {
        AutoOrientation.landscapeAutoMode();
        // Map<String, dynamic> map = {
        //   'controller': controller,
        //   'title': widget.title
        // };
        // Navigator.of(context).pushNamed('fullscreenPlayer', arguments: map);
      }
      _isFullScreen = !_isFullScreen;
    });
  }
}
