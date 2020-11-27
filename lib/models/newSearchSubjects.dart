import 'package:json_annotation/json_annotation.dart';
import "subject.dart";
part 'newSearchSubjects.g.dart';

@JsonSerializable()
class NewSearchSubjects {
    NewSearchSubjects();

    List<Subject> data;
    
    factory NewSearchSubjects.fromJson(Map<String,dynamic> json) => _$NewSearchSubjectsFromJson(json);
    Map<String, dynamic> toJson() => _$NewSearchSubjectsToJson(this);
}
