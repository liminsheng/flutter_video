import 'package:json_annotation/json_annotation.dart';
import "recommend.dart";
part 'recommendGroups.g.dart';

@JsonSerializable()
class RecommendGroups {
    RecommendGroups();

    String tag;
    List<Recommend> groups;
    
    factory RecommendGroups.fromJson(Map<String,dynamic> json) => _$RecommendGroupsFromJson(json);
    Map<String, dynamic> toJson() => _$RecommendGroupsToJson(this);
}
