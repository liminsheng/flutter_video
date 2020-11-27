import 'package:json_annotation/json_annotation.dart';

part 'abstract.g.dart';

@JsonSerializable()
class Abstract {
    Abstract();

    String episodes_count;
    num star;
    String blacklisted;
    String title;
    String url;
    String collection_status;
    String rate;
    Map<String,dynamic> short_comment;
    bool is_tv;
    String subtype;
    List directors;
    List actors;
    String duration;
    String region;
    bool playable;
    String id;
    List types;
    String release_year;
    
    factory Abstract.fromJson(Map<String,dynamic> json) => _$AbstractFromJson(json);
    Map<String, dynamic> toJson() => _$AbstractToJson(this);
}
