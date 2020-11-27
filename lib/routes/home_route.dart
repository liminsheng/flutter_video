import 'package:flutter/material.dart';
import 'package:flutter_video/l10n/localization_intl.dart';
import 'package:flutter_video/widgets/my_drawer.dart';

class HomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((MyLocalizations.of(context).title), style: TextStyle(fontFamily: 'ZhiMangXing'),),
      ),
      drawer: MyDrawer(),
    );
  }
}
