// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'abstract.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Abstract _$AbstractFromJson(Map<String, dynamic> json) {
  return Abstract()
    ..episodes_count = json['episodes_count'] as String
    ..star = json['star'] as num
    ..blacklisted = json['blacklisted'] as String
    ..title = json['title'] as String
    ..url = json['url'] as String
    ..collection_status = json['collection_status'] as String
    ..rate = json['rate'] as String
    ..short_comment = json['short_comment'] as Map<String, dynamic>
    ..is_tv = json['is_tv'] as bool
    ..subtype = json['subtype'] as String
    ..directors = json['directors'] as List
    ..actors = json['actors'] as List
    ..duration = json['duration'] as String
    ..region = json['region'] as String
    ..playable = json['playable'] as bool
    ..id = json['id'] as String
    ..types = json['types'] as List
    ..release_year = json['release_year'] as String;
}

Map<String, dynamic> _$AbstractToJson(Abstract instance) => <String, dynamic>{
      'episodes_count': instance.episodes_count,
      'star': instance.star,
      'blacklisted': instance.blacklisted,
      'title': instance.title,
      'url': instance.url,
      'collection_status': instance.collection_status,
      'rate': instance.rate,
      'short_comment': instance.short_comment,
      'is_tv': instance.is_tv,
      'subtype': instance.subtype,
      'directors': instance.directors,
      'actors': instance.actors,
      'duration': instance.duration,
      'region': instance.region,
      'playable': instance.playable,
      'id': instance.id,
      'types': instance.types,
      'release_year': instance.release_year
    };
