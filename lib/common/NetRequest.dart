import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video/common/global.dart';
import 'package:flutter_video/models/index.dart';

class NetRequest {
  // 在网络请求过程中可能会需要使用当前的context信息，比如在请求失败时
  // 打开一个新路由，而打开新路由需要context信息。
  NetRequest([this.context]) {
    _options = Options(extra: {"context": context});
  }

  BuildContext context;
  Options _options;
  static Dio dio = new Dio(BaseOptions(
    baseUrl: 'https://movie.douban.com/',
    headers: {
      HttpHeaders.acceptHeader: "application/json; charset=utf-8",
    },
  ));

  static void init() {
    // 添加缓存插件
    dio.interceptors.add(Global.netCache);
    // 设置用户token（可能为null，代表未登录）
    dio.options.headers[HttpHeaders.authorizationHeader] = Global.profile.token;

    // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
    // if (!Global.isRelease) {
    //   (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //       (client) {
    //     client.findProxy = (uri) {
    //       return "PROXY 192.168.2.5:8888";
    //     };
    //     //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
    //     client.badCertificateCallback =
    //         (X509Certificate cert, String host, int port) => true;
    //   };
    // }
  }

  //获取标签
  Future<List<String>> getTags({String type, refresh = false}) async {
    //query参数，用于接收分页信息
    Map<String, dynamic> queryParameters = {
      'type': type,
    };
    if (refresh) {
      // 列表下拉刷新，需要删除缓存（拦截器中会读取这些信息）
      _options.extra.addAll({"refresh": refresh, "list": true});
    }
    var response = await dio.get(
      "j/search_tags",
      queryParameters: queryParameters,
      options: _options,
    );
    return Tags.fromJson(response.data)?.tags;
  }

  //获取标签下节目
  //type:movie,tv,
  //sort:recommend,time,rank
  //playable=on
  Future<List<Subject>> getSubjects(
      {String type,
      String tag,
      String sort,
      int pageStart,
      int pageLimit,
      refresh = false}) async {
    //query参数，用于接收分页信息
    Map<String, dynamic> queryParameters = {
      'type': type,
      'tag': tag,
      'sort': sort,
      'page_start': pageStart,
      'page_limit': pageLimit
    };
    if (refresh) {
      // 列表下拉刷新，需要删除缓存（拦截器中会读取这些信息）
      _options.extra.addAll({"refresh": refresh, "list": true});
    }
    var response = await dio.get(
      "j/search_subjects",
      queryParameters: queryParameters,
      options: _options,
    );
    return Subjects.fromJson(response.data)?.subjects;
  }

  //获取节目的更多信息
  Future<Abstract> getSubjectsAbstract({String subjectId, refresh = false}) async {
    //query参数，用于接收分页信息
    Map<String, dynamic> queryParameters = {'subject_id': subjectId};
    if (refresh) {
      // 列表下拉刷新，需要删除缓存（拦截器中会读取这些信息）
      _options.extra.addAll({"refresh": refresh, "list": false});
    }
    var response = await dio.get(
      "j/subject_abstract",
      queryParameters: queryParameters,
      options: _options,
    );
    return SubjectAbstract.fromJson(response.data)?.subject;
  }

  //获取Top排行榜
  Future<List<TopSubject>> getTopList(
      {int type, int start, int limit, refresh = false}) async {
    //query参数，用于接收分页信息
    Map<String, dynamic> queryParameters = {
      'type': type,
      'interval_id': '100:90',
      'start': start,
      'limit': limit
    };
    if (refresh) {
      // 列表下拉刷新，需要删除缓存（拦截器中会读取这些信息）
      _options.extra.addAll({"refresh": refresh, "list": true});
    }
    var response = await dio.get<List>(
      "j/chart/top_list",
      queryParameters: queryParameters,
      options: _options,
    );
    return response.data.map((e) => TopSubject.fromJson(e)).toList();
  }

  //获取热门推荐
  Future<List<Recommend>> getRecommend({refresh = false}) async {
    //query参数，用于接收分页信息
    Map<String, dynamic> queryParameters = {'tag': '热门'};
    if (refresh) {
      // 列表下拉刷新，需要删除缓存（拦截器中会读取这些信息）
      _options.extra.addAll({"refresh": refresh, "list": true});
    }
    var response = await dio.get(
      "tv/recommend_groups",
      queryParameters: queryParameters,
      options: _options,
    );
    return RecommendGroups.fromJson(response.data)?.groups;
  }

  Future<List<Subject>> getNewSearchSubjects({refresh = false}) async {
    //query参数，用于接收分页信息
    Map<String, dynamic> queryParameters = {
      'sort': 'U',
      'range': '0,10',
      'tags': '',
      'start': 0
    };
    if (refresh) {
      // 列表下拉刷新，需要删除缓存（拦截器中会读取这些信息）
      _options.extra.addAll({"refresh": refresh, "list": true});
    }
    var response = await dio.get(
      "tv/new_search_subjects",
      queryParameters: queryParameters,
      options: _options,
    );
    return NewSearchSubjects.fromJson(response.data)?.data;
  }

  ///https://movie.douban.com/j/subject_abstract?subject_id=25907124
  ///https://movie.douban.com/j/tv/recommend_groups?tag=热门
  ///https://movie.douban.com/j/new_search_subjects?sort=U&range=0,10&tags=&start=0
  ///https://search.douban.com/movie/subject_search?search_text=棋魂&cat=1002
  ///https://movie.douban.com/j/chart/top_list?type=11&interval_id=100%3A90&action=&start=0&limit=20
}
