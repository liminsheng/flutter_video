// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newSearchSubjects.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewSearchSubjects _$NewSearchSubjectsFromJson(Map<String, dynamic> json) {
  return NewSearchSubjects()
    ..data = (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Subject.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$NewSearchSubjectsToJson(NewSearchSubjects instance) =>
    <String, dynamic>{'data': instance.data};
