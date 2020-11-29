import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video/l10n/localization_intl.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              Expanded(child: _buildMenus(context))
            ],
          )),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
      height: 500.h,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: ClipOval(
              child: Image.asset(
                'images/avatar-default.jpg',
                width: 160.w,
                height: 160.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            '夜雨声烦',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 40.nsp,
                fontFamily: 'ZhiMangXing'),
          )
        ],
      ),
    );
  }

  Widget _buildMenus(BuildContext context) {
    var gm = MyLocalizations.of(context);
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.color_lens),
          title: Text(gm.theme),
          onTap: () => Navigator.pushNamed(context, 'themes'),
        ),
        ListTile(
          leading: Icon(Icons.language),
          title: Text(gm.language),
          onTap: () => Navigator.pushNamed(context, 'language'),
        ),
      ],
    );
  }
}
