// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myBanner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyBanner _$MyBannerFromJson(Map<String, dynamic> json) {
  return MyBanner()
    ..title = json['title'] as String
    ..sub_title = json['sub_title'] as String
    ..cover = json['cover'] as String
    ..url = json['url'] as String;
}

Map<String, dynamic> _$MyBannerToJson(MyBanner instance) => <String, dynamic>{
      'title': instance.title,
      'sub_title': instance.sub_title,
      'cover': instance.cover,
      'url': instance.url
    };
