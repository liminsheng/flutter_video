// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topSubject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopSubject _$TopSubjectFromJson(Map<String, dynamic> json) {
  return TopSubject()
    ..rating = json['rating'] as List
    ..rank = json['rank'] as num
    ..cover_url = json['cover_url'] as String
    ..is_playable = json['is_playable'] as bool
    ..id = json['id'] as String
    ..types = json['types'] as List
    ..regions = json['regions'] as List
    ..title = json['title'] as String
    ..url = json['url'] as String
    ..release_date = json['release_date'] as String
    ..actor_count = json['actor_count'] as num
    ..vote_count = json['vote_count'] as num
    ..score = json['score'] as String
    ..actors = json['actors'] as List
    ..is_watched = json['is_watched'] as bool;
}

Map<String, dynamic> _$TopSubjectToJson(TopSubject instance) =>
    <String, dynamic>{
      'rating': instance.rating,
      'rank': instance.rank,
      'cover_url': instance.cover_url,
      'is_playable': instance.is_playable,
      'id': instance.id,
      'types': instance.types,
      'regions': instance.regions,
      'title': instance.title,
      'url': instance.url,
      'release_date': instance.release_date,
      'actor_count': instance.actor_count,
      'vote_count': instance.vote_count,
      'score': instance.score,
      'actors': instance.actors,
      'is_watched': instance.is_watched
    };
