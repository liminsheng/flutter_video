import 'package:json_annotation/json_annotation.dart';
import "subject.dart";
part 'subjects.g.dart';

@JsonSerializable()
class Subjects {
    Subjects();

    List<Subject> subjects;
    
    factory Subjects.fromJson(Map<String,dynamic> json) => _$SubjectsFromJson(json);
    Map<String, dynamic> toJson() => _$SubjectsToJson(this);
}
