import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video/models/index.dart';
import 'package:flutter_video/widgets/webview.dart';

class DownloadItem extends StatefulWidget {
  DownloadItem(this.subject, this.isBig);

  final DownloadSubject subject;
  final bool isBig;

  @override
  _DownloadItemState createState() => _DownloadItemState();
}

class _DownloadItemState extends State<DownloadItem> {
  @override
  Widget build(BuildContext context) {
    DownloadSubject subject = widget.subject;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return WebView(url: subject.h5_url);
        }));
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child:
              widget.isBig ? _buildBigItem(subject) : _buildSmallItem(subject),
        ),
      ),
    );
  }

  _buildBigItem(DownloadSubject subject) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 1,
            child: FractionallySizedBox(
              widthFactor: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.w),
                child: CachedNetworkImage(
                  imageUrl: subject.img,
                  fit: BoxFit.fitWidth,
                ),
              ),
            )),
        Padding(
          padding: EdgeInsets.all(5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subject.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 36.nsp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '${subject.year} ${subject.episode.isEmpty ? '' : '共${subject.episode}集'}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 32.nsp, color: Colors.grey),
              ),
            ],
          ),
        )
      ],
    );
  }

  _buildSmallItem(DownloadSubject subject) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4.w),
          child: CachedNetworkImage(
            imageUrl: subject.img,
            fit: BoxFit.contain,
          ),
        ),
        Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 36.nsp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    subject.year,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 32.nsp, color: Colors.grey),
                  ),
                  Text(
                    subject.episode.isEmpty ? '' : '共${subject.episode}集',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 32.nsp, color: Colors.grey),
                  ),
                ],
              ),
            ))
      ],
    );
  }
}
