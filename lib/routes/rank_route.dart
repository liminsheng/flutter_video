import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video/common/global.dart';
import 'package:flutter_video/models/category.dart';

class RankRoute extends StatefulWidget {
  @override
  _RankRouteState createState() => _RankRouteState();
}

class _RankRouteState extends State<RankRoute>
    with AutomaticKeepAliveClientMixin {
  List<Category> _categoryList = [];

  @override
  void initState() {
    _loadTopData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.all(5),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          childAspectRatio: 1.5,
        ),
        itemCount: _categoryList.length,
        itemBuilder: _buildItem,
      ),
    );
  }

  void _loadTopData() {
    rootBundle.loadString('assets/category_list.json').then((value) {
      var list = json.decode(value) as List;
      setState(() {
        _categoryList = list.map((e) => Category.fromJson(e)).toList();
      });
    });
  }

  @override
  bool get wantKeepAlive => true;

  Widget _buildItem(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        if (_categoryList[index].type == 32) {
          Navigator.pushNamed(context, 'downloadZone');
        } else {
          Navigator.pushNamed(context, 'top', arguments: _categoryList[index]);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: _randomColor, borderRadius: BorderRadius.circular(4)),
        child: Center(
          child: Text(
            _categoryList[index].title,
            style: TextStyle(color: Colors.blueGrey, fontSize: 32.nsp),
          ),
        ),
      ),
    );
  }

  Color get _randomColor {
    return Color(int.parse(
        '0xff' + Global.colors[Random().nextInt(Global.colors.length - 1)]));
  }
}
