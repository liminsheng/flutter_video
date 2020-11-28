import 'package:flutter/material.dart';
import 'package:flutter_video/common/NetRequest.dart';
import 'package:flutter_video/common/global.dart';
import 'package:flutter_video/l10n/localization_intl.dart';
import 'package:flutter_video/widgets/movie_page.dart';

class TvRoute extends StatefulWidget {
  @override
  _TvRouteState createState() => _TvRouteState();
}

class _TvRouteState extends State<TvRoute>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List<String> _tags = [];
  TabController _controller;

  @override
  void initState() {
    _getTags();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var my = MyLocalizations.of(context);
    return _tags.isEmpty
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              TabBar(
                controller: _controller,
                tabs: _buildTabs(),
                isScrollable: true,
                unselectedLabelColor: Colors.grey,
                labelColor: Theme.of(context).primaryColor,
              ),
              Expanded(
                  flex: 1,
                  child: TabBarView(
                    controller: _controller,
                    children: _buildTabBarViews(),
                  ))
              // MoviePage('热门')
            ],
          );
  }

  ///获取标签
  void _getTags() {
    NetRequest(context).getTags(type: Global.type_tv).then((value) {
      print(value);
      setState(() {
        _tags = value;
      });
      _controller = TabController(length: _tags.length, vsync: this);
    }).catchError((error) {
      print(error);
    });
  }

  List<Widget> _buildTabs() {
    return _tags
        .map<Widget>((tag) => Tab(
              text: tag,
            ))
        .toList();
  }

  @override
  bool get wantKeepAlive => true;

  List<Widget> _buildTabBarViews() {
    return _tags.map<Widget>((tag) => MoviePage(tag)).toList();
  }
}
