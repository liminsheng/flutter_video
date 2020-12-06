import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video/models/abstract.dart';

class MovieDetail extends StatelessWidget {
  final Abstract abstract;
  final Function onDownload;

  const MovieDetail({Key key, @required this.abstract, this.onDownload})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return abstract == null
        ? Center(child: CircularProgressIndicator())
        : ListView(
            children: [
              ListTile(
                trailing: GestureDetector(
                  onTap: onDownload,
                  child: Icon(Icons.download_rounded),
                ),
                title: Text(
                  abstract.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40.nsp,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    abstract.rate.isEmpty
                        ? Container()
                        : Container(
                            margin: EdgeInsets.only(right: 5.w),
                            child: RatingBar(
                              initialRating: double.parse(abstract.rate) / 2.0,
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
                          ),
                    Container(
                      margin: EdgeInsets.only(right: 40.w),
                      child: Text(
                        abstract.rate,
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20.w),
                      child: Text(
                        abstract.duration.isEmpty
                            ? ''
                            : '片长：${abstract.duration}',
                        style: TextStyle(color: Colors.grey, fontSize: 32.nsp),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: abstract.episodes_count.isEmpty
                            ? Container()
                            : Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '共${abstract.episodes_count}集',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 32.nsp),
                                ),
                              )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 40.w),
                child: Text(
                  '${abstract.types.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '/')},${abstract.region} ${abstract.release_year}',
                  style: TextStyle(color: Colors.grey, fontSize: 32.nsp),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 40.w),
                child: Text(
                  '导演：${abstract.directors.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '/')}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey, fontSize: 32.nsp),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 40.w),
                child: Text(
                  '主演：${abstract.actors.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '/')}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey, fontSize: 32.nsp),
                ),
              ),
            ],
          );
  }
}
