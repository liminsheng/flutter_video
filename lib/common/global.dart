import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_video/common/NetRequest.dart';
import 'package:flutter_video/common/net_cache.dart';
import 'package:flutter_video/models/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

//提供五套可选主题色
const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];

class Global {
  static SharedPreferences _prefs;
  static Profile profile = Profile();

  //网络缓存对象
  static NetCache netCache = NetCache();

  //可选的主题列表
  static List<MaterialColor> get themes => _themes;

  //是否为release版
  static bool get isRelease => bool.fromEnvironment('dart.vm.product');

  static const type_movie = 'movie';
  static const type_tv = 'tv';
  static const sort_recommend = 'recommend';
  static const sort_time = 'time';
  static const sort_rank = 'rank';

  //初始化全局信息，会在App启动时调用
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString('profile');
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    }

    //如果没有缓存策略，设置默认缓存策略
    profile.cache = profile.cache ?? CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;

    //初始化网络请求相关配置
    NetRequest.init();
  }

  //持久化Profile信息
  static saveProfile() =>
      _prefs.setString('profile', jsonEncode(profile.toString()));
}
