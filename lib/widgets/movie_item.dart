import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_video/models/index.dart';
import 'package:flutter_video/widgets/webview.dart';

class MovieItem extends StatefulWidget {
  MovieItem(this.subject);

  final Subject subject;

  @override
  _MovieItemState createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  @override
  Widget build(BuildContext context) {
    Subject subject = widget.subject;
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) {
              return WebView(url: subject.url, title: '');
            }));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: FractionallySizedBox(
                widthFactor: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(
                    imageUrl: subject.cover,
                    fit: BoxFit.cover,
                  ),
                ),
              )),
          Text(
            subject.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          Row(
            children: [
              subject.rate.isEmpty
                  ? Container()
                  : RatingBar(
                      initialRating: double.parse(subject.rate) / 2.0,
                      minRating: 0.5,
                      itemSize: 14,
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
              Text(
                subject.rate,
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }
}
