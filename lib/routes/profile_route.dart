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
    return Scaffold(
      appBar: AppBar(
        title: Text(my.profile),
      ),
    );
  }
}
