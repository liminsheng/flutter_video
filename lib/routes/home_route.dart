import 'package:flutter/material.dart';
import 'package:flutter_video/l10n/localization_intl.dart';

class HomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((MyLocalizations.of(context).title)),
      ),
    );
  }
}
