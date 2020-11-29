import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video/l10n/localization_intl.dart';
import 'package:flutter_video/routes/movie_route.dart';
import 'package:flutter_video/routes/profile_route.dart';
import 'package:flutter_video/routes/rank_route.dart';
import 'package:flutter_video/routes/tv_route.dart';
import 'package:flutter_video/widgets/my_drawer.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  int _currentIndex = 0;
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    var my = MyLocalizations.of(context);
    ScreenUtil.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (MyLocalizations.of(context).title),
          style: TextStyle(fontFamily: 'ZhiMangXing'),
        ),
      ),
      drawer: MyDrawer(),
      body: PageView(
        controller: _pageController,
        children: [
          MovieRoute(),
          TvRoute(),
          RankRoute(),
          ProfileRoute(),
        ],
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          _onItemTap(index);
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.slow_motion_video), label: my.movie),
          BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: my.tv),
          BottomNavigationBarItem(
              icon: Icon(Icons.star_half_rounded), label: my.rank),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_outlined), label: my.profile),
        ],
      ),
    );
  }

  void _onItemTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }
}
