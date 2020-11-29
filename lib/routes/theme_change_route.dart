import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video/common/global.dart';
import 'package:flutter_video/l10n/localization_intl.dart';
import 'package:flutter_video/states/theme_model.dart';
import 'package:provider/provider.dart';

class ThemeChangeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeModel = Provider.of<ThemeModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(MyLocalizations.of(context).theme,
            style: TextStyle(fontFamily: 'ZhiMangXing')),
      ),
      body: ListView(
        //显示主题色块
        children: Global.themes.map<Widget>((e) {
          return ListTile(
            leading: Container(
              width: 80.w,
              height: 80.w,
              color: e,
            ),
            title: Text(
              _getThemeName(context, e),
              style: TextStyle(
                  color: themeModel.theme == e
                      ? Theme.of(context).primaryColor
                      : null),
            ),
            trailing: themeModel.theme == e
                ? Icon(
                    Icons.done,
                    color: Theme.of(context).primaryColor,
                  )
                : null,
            onTap: () {
              themeModel.theme = e;
            },
          );
        }).toList(),
      ),
    );
  }

  String _getThemeName(BuildContext context, MaterialColor color) {
    var my = MyLocalizations.of(context);
    String name = '';
    if (color == Global.themes[0]) {
      name = my.blue;
    } else if (color == Global.themes[1]) {
      name = my.cyan;
    } else if (color == Global.themes[2]) {
      name = my.teal;
    } else if (color == Global.themes[3]) {
      name = my.green;
    } else if (color == Global.themes[4]) {
      name = my.red;
    }
    return name;
  }
}
