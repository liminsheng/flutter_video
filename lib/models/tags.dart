import 'package:json_annotation/json_annotation.dart';

part 'tags.g.dart';

@JsonSerializable()
class Tags {
    Tags();

    List<String> tags;
    
    factory Tags.fromJson(Map<String,dynamic> json) => _$TagsFromJson(json);
    Map<String, dynamic> toJson() => _$TagsToJson(this);
}
