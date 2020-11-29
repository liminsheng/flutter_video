// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'downloadSubject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DownloadSubject _$DownloadSubjectFromJson(Map<String, dynamic> json) {
  return DownloadSubject()
    ..episode = json['episode'] as String
    ..img = json['img'] as String
    ..title = json['title'] as String
    ..h5_url = json['h5_url'] as String
    ..url = json['url'] as String
    ..type = json['type'] as String
    ..year = json['year'] as String
    ..sub_title = json['sub_title'] as String
    ..id = json['id'] as String;
}

Map<String, dynamic> _$DownloadSubjectToJson(DownloadSubject instance) =>
    <String, dynamic>{
      'episode': instance.episode,
      'img': instance.img,
      'title': instance.title,
      'h5_url': instance.h5_url,
      'url': instance.url,
      'type': instance.type,
      'year': instance.year,
      'sub_title': instance.sub_title,
      'id': instance.id
    };
