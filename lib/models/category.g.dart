// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category()
    ..title = json['title'] as String
    ..type = json['type'] as num;
}

Map<String, dynamic> _$CategoryToJson(Category instance) =>
    <String, dynamic>{'title': instance.title, 'type': instance.type};
