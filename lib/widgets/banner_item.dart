import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video/models/myBanner.dart';
import 'package:flutter_video/widgets/webview.dart';

class BannerItem extends StatelessWidget {
  final MyBanner banner;

  const BannerItem({Key key, this.banner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return WebView(url: banner.url);
        }));
      },
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: banner.cover,
            width: 233,
          ),
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
                child: Column(
                  children: [
                    Text(
                      banner.title,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      banner.title,
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
