// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subjects.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subjects _$SubjectsFromJson(Map<String, dynamic> json) {
  return Subjects()
    ..subjects = (json['subjects'] as List)
        ?.map((e) =>
            e == null ? null : Subject.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$SubjectsToJson(Subjects instance) =>
    <String, dynamic>{'subjects': instance.subjects};
