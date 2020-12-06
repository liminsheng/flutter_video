// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'downloadSubject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DownloadSubject _$DownloadSubjectFromJson(Map<String, dynamic> json) {
  return DownloadSubject()
    ..episode = json['episode'] as String
    ..img = json['img'] as String
    ..cover = json['cover'] as String
    ..title = json['title'] as String
    ..episodes = (json['episodes'] as List)
        ?.map((e) =>
            e == null ? null : Episode.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..type = json['type'] as String
    ..year = json['year'] as String
    ..sub_title = json['sub_title'] as String
    ..id = json['id'] as String;
}

Map<String, dynamic> _$DownloadSubjectToJson(DownloadSubject instance) =>
    <String, dynamic>{
      'episode': instance.episode,
      'img': instance.img,
      'cover': instance.cover,
      'title': instance.title,
      'episodes': instance.episodes,
      'type': instance.type,
      'year': instance.year,
      'sub_title': instance.sub_title,
      'id': instance.id
    };
