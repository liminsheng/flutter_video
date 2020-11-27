// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recommend _$RecommendFromJson(Map<String, dynamic> json) {
  return Recommend()
    ..url = json['url'] as String
    ..picture = json['picture'] as String
    ..name = json['name'] as String
    ..n_member = json['n_member'] as num;
}

Map<String, dynamic> _$RecommendToJson(Recommend instance) => <String, dynamic>{
      'url': instance.url,
      'picture': instance.picture,
      'name': instance.name,
      'n_member': instance.n_member
    };
