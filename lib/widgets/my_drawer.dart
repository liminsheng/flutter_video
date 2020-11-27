import 'package:flutter/material.dart';
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
      padding: EdgeInsets.only(top: 40, bottom: 20),
      height: 350,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ClipOval(
              child: Image.asset('images/avatar-default.jpg', width: 80),
            ),
          ),
          Text(
            MyLocalizations.of(context).title,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
