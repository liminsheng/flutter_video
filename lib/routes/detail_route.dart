import 'package:flutter/material.dart';
import 'package:flutter_video/common/NetRequest.dart';
import 'package:flutter_video/models/abstract.dart';
import 'package:flutter_video/models/downloadSubject.dart';
import 'package:flutter_video/widgets/movie_detail.dart';
import 'package:flutter_video/widgets/player.dart';

class DetailRoute extends StatefulWidget {
  final DownloadSubject downloadSubject;

  const DetailRoute({Key key, @required this.downloadSubject})
      : super(key: key);

  @override
  _DetailRouteState createState() => _DetailRouteState();
}

class _DetailRouteState extends State<DetailRoute> {
  Abstract _detail;

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
                title: widget.downloadSubject.title,
                url: widget.downloadSubject?.url ?? '',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 9 / 16,
              ),
              Expanded(
                  flex: 1,
                  child: MovieDetail(
                    abstract: _detail,
                    onDownload: () {},
                  )),
            ],
          )),
    );
  }

  void _getDetail() async {
    Abstract abstract = await NetRequest(context)
        .getSubjectsAbstract(subjectId: widget.downloadSubject.id);
    setState(() {
      _detail = abstract;
    });
  }
}
