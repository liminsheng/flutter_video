import 'package:flutter/material.dart';
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
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(top: 15),
      height: 160,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ClipOval(
              child: Image.asset(
                'images/avatar-default.jpg',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            '夜雨声烦',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'ZhiMangXing'),
          )
        ],
      ),
    );
  }
}
