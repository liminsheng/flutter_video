import 'package:json_annotation/json_annotation.dart';
import "abstract.dart";
part 'subjectAbstract.g.dart';

@JsonSerializable()
class SubjectAbstract {
    SubjectAbstract();

    num r;
    Abstract subject;
    
    factory SubjectAbstract.fromJson(Map<String,dynamic> json) => _$SubjectAbstractFromJson(json);
    Map<String, dynamic> toJson() => _$SubjectAbstractToJson(this);
}
