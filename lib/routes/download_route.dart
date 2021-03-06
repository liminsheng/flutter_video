import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video/common/download_provider.dart';
import 'package:flutter_video/l10n/localization_intl.dart';
import 'package:flutter_video/models/episode.dart';

class DownloadRoute extends StatefulWidget {
  @override
  _DownloadRouteState createState() => _DownloadRouteState();
}

class _DownloadRouteState extends State<DownloadRoute> {
  DownloadProvider downloadProvider = DownloadProvider();
  Future loadDataFuture;

  @override
  void initState() {
    setState(() {
      loadDataFuture = getData();
    });
    super.initState();
  }

  @override
  void dispose() {
    downloadProvider.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyLocalizations.of(context).download,
            style: TextStyle(fontFamily: 'ZhiMangXing')),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {
            loadDataFuture = getData();
          });
          return loadDataFuture;
        },
        child: Column(
          children: [
            ListTile(
              title: Text(MyLocalizations.of(context).downloading),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 28.nsp,
                color: Colors.grey,
              ),
              onTap: () {
                Navigator.pushNamed(context, 'downloading');
              },
            ),
            Divider(height: 1.5.h, color: Colors.grey),
            Container(
              padding: EdgeInsets.fromLTRB(0, 20.h, 0, 20.h),
              margin: EdgeInsets.only(left: 30.w),
              alignment: Alignment.centerLeft,
              child: Text(
                MyLocalizations.of(context).downloaded,
                style: TextStyle(color: Colors.grey, fontSize: 24.nsp),
              ),
            ),
            Expanded(
                flex: 1,
                child: FutureBuilder<List<Episode>>(
                  future: loadDataFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return _noData;
                      } else if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return _buildItem(snapshot.data[index]);
                            });
                      } else {
                        return _noData;
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }

  Widget get _noData => Center(
    child: Wrap(
      children: [
        Text('没有下载的视频哦！'),
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
    var list = await downloadProvider.getEpisodes(true);
    return list;
  }

  Widget _buildItem(Episode episode) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Container(
          width: 160.h,
          height: 90.w,
          child: CachedNetworkImage(
            imageUrl: episode.cover,
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
      title: Text(episode.title),
      subtitle: Text('第${episode.episode}集'),
      onTap: () {
        Navigator.pushNamed(context, 'downloadPlay', arguments: episode);
      },
    );
  }
}
