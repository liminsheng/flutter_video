import 'package:flutter/material.dart';
import 'package:flutter_video/common/global.dart';
import 'package:flutter_video/models/profile.dart';

class ProfileChangeNotifier extends ChangeNotifier {
  Profile get profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile();
    super.notifyListeners();
  }
}
