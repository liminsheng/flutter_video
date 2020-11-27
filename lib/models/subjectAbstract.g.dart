// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subjectAbstract.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectAbstract _$SubjectAbstractFromJson(Map<String, dynamic> json) {
  return SubjectAbstract()
    ..r = json['r'] as num
    ..subject = json['subject'] == null
        ? null
        : Abstract.fromJson(json['subject'] as Map<String, dynamic>);
}

Map<String, dynamic> _$SubjectAbstractToJson(SubjectAbstract instance) =>
    <String, dynamic>{'r': instance.r, 'subject': instance.subject};
