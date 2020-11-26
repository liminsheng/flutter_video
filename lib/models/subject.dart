import 'package:json_annotation/json_annotation.dart';

part 'subject.g.dart';

@JsonSerializable()
class Subject {
    Subject();

    String rate;
    num cover_x;
    String title;
    String url;
    bool playable;
    String cover;
    String id;
    num cover_y;
    bool is_new;
    
    factory Subject.fromJson(Map<String,dynamic> json) => _$SubjectFromJson(json);
    Map<String, dynamic> toJson() => _$SubjectToJson(this);
}
