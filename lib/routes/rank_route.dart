import 'package:flutter/material.dart';
import 'package:flutter_video/l10n/localization_intl.dart';

class RankRoute extends StatefulWidget {
  @override
  _RankRouteState createState() => _RankRouteState();
}

class _RankRouteState extends State<RankRoute> {
  @override
  Widget build(BuildContext context) {
    var my = MyLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(my.rank),
      ),
    );
  }
}
