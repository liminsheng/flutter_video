import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video/l10n/localization_intl.dart';

class ProfileRoute extends StatefulWidget {
  @override
  _ProfileRouteState createState() => _ProfileRouteState();
}

class _ProfileRouteState extends State<ProfileRoute> {
  @override
  Widget build(BuildContext context) {
    var my = MyLocalizations.of(context);
    return ListView(
      children: [
        _buildHeader(context),
        ListTile(
          leading: Icon(Icons.color_lens),
          title: Text(my.theme),
          onTap: () => Navigator.pushNamed(context, 'themes'),
        ),
        ListTile(
          leading: Icon(Icons.language),
          title: Text(my.language),
          onTap: () => Navigator.pushNamed(context, 'language'),
        ),
        ListTile(
          leading: Icon(Icons.download_rounded),
          title: Text(my.download),
          onTap: () => Navigator.pushNamed(context, 'download'),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(top: 60.h),
      height: 320.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: ClipOval(
                  child: Image.asset(
                    'images/avatar-default.jpg',
                    width: 120.w,
                    height: 120.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                '夜雨声烦',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 36.nsp,
                    fontFamily: 'ZhiMangXing'),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(180.w, 20.h, 30.w, 20.h),
            child: Text(
              '这家伙太懒了，什么都没有留下。',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 36.nsp,
                  fontFamily: 'ZhiMangXing'),
            ),
          )
        ],
      ),
    );
  }
}
