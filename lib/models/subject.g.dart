// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subject _$SubjectFromJson(Map<String, dynamic> json) {
  return Subject()
    ..rate = json['rate'] as String
    ..cover_x = json['cover_x'] as num
    ..title = json['title'] as String
    ..url = json['url'] as String
    ..playable = json['playable'] as bool
    ..cover = json['cover'] as String
    ..id = json['id'] as String
    ..cover_y = json['cover_y'] as num
    ..is_new = json['is_new'] as bool
    ..star = json['star'] as String
    ..directors = json['directors'] as List
    ..casts = json['casts'] as List;
}

Map<String, dynamic> _$SubjectToJson(Subject instance) => <String, dynamic>{
      'rate': instance.rate,
      'cover_x': instance.cover_x,
      'title': instance.title,
      'url': instance.url,
      'playable': instance.playable,
      'cover': instance.cover,
      'id': instance.id,
      'cover_y': instance.cover_y,
      'is_new': instance.is_new,
      'star': instance.star,
      'directors': instance.directors,
      'casts': instance.casts
    };
