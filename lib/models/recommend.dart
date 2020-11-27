import 'package:json_annotation/json_annotation.dart';

part 'recommend.g.dart';

@JsonSerializable()
class Recommend {
    Recommend();

    String url;
    String picture;
    String name;
    num n_member;
    
    factory Recommend.fromJson(Map<String,dynamic> json) => _$RecommendFromJson(json);
    Map<String, dynamic> toJson() => _$RecommendToJson(this);
}
