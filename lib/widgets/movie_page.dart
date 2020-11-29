import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    super.build(context);
    return RefreshIndicator(
      onRefresh: () {
        _subjectList.clear();
        return _retrieveData();
      },
      child: CustomScrollView(
        slivers: [
          _bannerList.isNotEmpty
              ? SliverFixedExtentList(
                  itemExtent: 320.h,
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return _buildBanner();
                  }, childCount: 1),
                )
              : SliverPadding(padding: EdgeInsets.zero),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverGrid(
              //Grid
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, //Grid按4列显示
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 0.55,
              ),
              delegate: new SliverChildBuilderDelegate(
                _buildItem,
                childCount: _subjectList.length,
              ),
            ),
          ),
        ],
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
    return PhysicalModel(
      color: Color(0xfff0f0f0),
      child: Container(
        height: 320.h,
        child: Swiper(
          itemCount: _bannerList.length,
          autoplayDelay: 3000,
          pagination: SwiperPagination(
              alignment: Alignment.bottomRight,
              builder: FractionPaginationBuilder(
                color: Color(0xffadadad),
                fontSize: 36.nsp,
                activeFontSize: 50.nsp,
              ),
              margin: EdgeInsets.all(5)),
          itemBuilder: (context, index) {
            return BannerItem(
              banner: _bannerList[index],
            );
          },
          autoplay: true,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
