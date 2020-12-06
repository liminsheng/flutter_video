import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video/common/download_provider.dart';
import 'package:flutter_video/common/download_task.dart';
import 'package:flutter_video/models/episode.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadUtil {
  static DownloadUtil _downloadUtil;
  Dio _dio;
  String _savePath;
  BuildContext _context;
  List<DownloadTask> _downloadTask = [];
  DownloadProvider _downloadHelp;

  List<DownloadTask> get downloadTask => _downloadTask;

  DownloadUtil(BuildContext context) {
    _dio = Dio();
    _context = context;
    _downloadHelp = DownloadProvider();
  }

  static DownloadUtil instance(BuildContext context) {
    return _downloadUtil == null ? DownloadUtil(context) : _downloadUtil;
  }

  void addDownload(DownloadTask task) async {
    var exists = await checkExists(task.episode);
    print('addDownload ${exists ? '已在下载列表中' : '添加下载'}');
    if (exists) {
      Fluttertoast.showToast(msg: '已在下载列表中');
    } else {
      downloadTask.add(task);
    }
  }

  ///PermissionGroup.storage 对应的是
  ///android 的外部存储 （External Storage）
  ///ios 的Documents` or `Downloads`
  Future<bool> checkPermissionsFunction() async {
    if (Theme.of(_context).platform == TargetPlatform.android) {
      ///安卓平台中 checkPermissionStatus方法校验是否有储存卡的读写权限
      PermissionStatus permission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
      if (permission != PermissionStatus.granted) {
        ///无权限那么 调用方法 requestPermissions 申请权限
        Map<PermissionGroup, PermissionStatus> permissions =
            await PermissionHandler()
                .requestPermissions([PermissionGroup.storage]);

        ///校验用户对权限申请的处理
        if (permissions[PermissionGroup.storage] == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  ///获取手机的存储目录路径
  ///getExternalStorageDirectory() 获取的是  android 的外部存储 （External Storage）
  ///  getApplicationDocumentsDirectory 获取的是 ios 的Documents` or `Downloads` 目录
  Future<String> getPhoneLocalPath() async {
    final directory = Theme.of(_context).platform == TargetPlatform.android
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }

  String _getFileName(Episode episode) {
    var split = episode.url.split('/');
    return '/' + episode.parentId + '/' + split.last;
  }

  Future<Response> downloadMovie(Episode episode, onProgressChange) async {
    bool granted = await checkPermissionsFunction();
    if (granted) {
      if (_savePath == null) {
        _savePath = await getPhoneLocalPath();
      }
      await _downloadHelp.insert(episode);
      String path = _savePath + _getFileName(episode);
      return await _dio.download(episode.url, path,
          onReceiveProgress: (int count, int total) {
        if (total != -1) {
          onProgressChange(count, total, path);
          _downloadTask.remove(episode);
          _downloadHelp.update(episode);
        }
      });
    } else {
      Fluttertoast.showToast(msg: '请同意开启存储权限');
      return null;
    }
  }

  Future<bool> checkExists(Episode episode) async {
    if (_downloadTask.contains(episode)) {
      print('已在下载列表中...');
      return true;
    } else {
      var queryEpisode = await _downloadHelp.getEpisode(episode.url);
      var exists = await File(queryEpisode.path).exists();
      if (queryEpisode?.finish == true && exists) {
        print('下载已完成...');
        return true;
      }
    }
    return false;
  }
}
