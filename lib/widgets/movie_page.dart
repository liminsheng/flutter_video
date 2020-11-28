import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_video/common/NetRequest.dart';
import 'package:flutter_video/common/global.dart';
import 'package:flutter_video/models/index.dart';
import 'package:flutter_video/widgets/banner_item.dart';
import 'package:flutter_video/widgets/movie_item.dart';

class MoviePage extends StatefulWidget {
  MoviePage(this.tag, {this.type});

  final String type;
  final String tag;

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage>
    with AutomaticKeepAliveClientMixin {
  List<MyBanner> _bannerList = [];
  List<Subject> _subjectList = [];

  @override
  void initState() {
    if (widget.type == Global.type_movie && widget.tag == '热门') {
      _loadBannerData();
    }
    _retrieveData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: RefreshIndicator(
        onRefresh: () {
          _subjectList.clear();
          return _retrieveData();
        },
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.55,
            ),
            itemCount: _subjectList.length,
            itemBuilder: _buildItem),
      ),
    );
  }

  void _loadBannerData() {
    rootBundle.loadString('assets/banner_list.json').then((value) {
      var list = json.decode(value) as List;
      setState(() {
        _bannerList = list.map((e) => MyBanner.fromJson(e)).toList();
      });
    });
  }

  Future<Null> _retrieveData() async {
    List<Subject> subjects = await NetRequest(context).getSubjects(
        type: Global.type_movie,
        tag: widget.tag,
        sort: Global.sort_recommend,
        pageStart: _subjectList.length ~/ 20,
        pageLimit: 20,
        refresh: false);
    setState(() {
      _subjectList.addAll(subjects);
    });
  }

  Widget _buildItem(BuildContext context, int index) {
    if (index == _subjectList.length - 1) {
      _retrieveData();
    }
    return MovieItem(_subjectList[index]);
  }

  Widget _buildBanner() {
    return Container(
      height: 160,
      child: Swiper(
        itemCount: _bannerList.length,
        autoplayDelay: 3000,
        pagination: SwiperPagination(
            alignment: Alignment.bottomLeft,
            builder: SwiperPagination.fraction,
            margin: EdgeInsets.all(5)),
        itemBuilder: (context, index) {
          return BannerItem(
            banner: _bannerList[index],
          );
        },
        autoplay: true,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
