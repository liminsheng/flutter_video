// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendGroups.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendGroups _$RecommendGroupsFromJson(Map<String, dynamic> json) {
  return RecommendGroups()
    ..tag = json['tag'] as String
    ..groups = (json['groups'] as List)
        ?.map((e) =>
            e == null ? null : Recommend.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$RecommendGroupsToJson(RecommendGroups instance) =>
    <String, dynamic>{'tag': instance.tag, 'groups': instance.groups};
