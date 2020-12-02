import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video/models/index.dart';
import 'package:flutter_video/widgets/webview.dart';

class TopSubjectItem extends StatefulWidget {
  TopSubjectItem(this.subject);

  final TopSubject subject;

  @override
  _TopSubjectItemState createState() => _TopSubjectItemState();
}

class _TopSubjectItemState extends State<TopSubjectItem> {
  @override
  Widget build(BuildContext context) {
    TopSubject subject = widget.subject;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return WebView(url: subject.url);
        }));
      },
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: subject.cover_url,
                width: 220.w,
                height: 320.h,
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return Image.asset(
                    'images/default_placeholder.png',
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(left: 40.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 20.h, 0, 20.h),
                        child: Row(
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
                              subject.is_playable ? '[可播放]' : '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 36.nsp,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    subject.rank.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 36.nsp,
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Text(
                        subject.actors.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 30.nsp, color: Colors.grey),
                      ),
                      Text(
                        subject.types.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 30.nsp, color: Colors.grey),
                      ),
                      Text(
                        subject.regions.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 30.nsp, color: Colors.grey),
                      ),
                      Text(
                        subject.release_date.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 30.nsp, color: Colors.grey),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          subject.rating[0].isEmpty
                              ? Container()
                              : RatingBar(
                                  initialRating:
                                      double.parse(subject.rating[0]) / 2.0,
                                  minRating: 0.5,
                                  itemSize: 40.nsp,
                                  updateOnDrag: false,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  ratingWidget: RatingWidget(
                                    full: Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                    ),
                                    half: Icon(
                                      Icons.star_half,
                                      color: Colors.orange,
                                    ),
                                    empty: Icon(
                                      Icons.star,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                          Container(
                            margin: EdgeInsets.only(left: 5.w),
                            child: Text(
                              subject.rating[0],
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 40.w, bottom: 2.h),
                            child: Text(
                              '${subject.vote_count}人评价',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 32.nsp),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
