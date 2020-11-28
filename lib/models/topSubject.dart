import 'package:json_annotation/json_annotation.dart';

part 'topSubject.g.dart';

@JsonSerializable()
class TopSubject {
    TopSubject();

    List rating;
    num rank;
    String cover_url;
    bool is_playable;
    String id;
    List types;
    List regions;
    String title;
    String url;
    String release_date;
    num actor_count;
    num vote_count;
    String score;
    List actors;
    bool is_watched;
    
    factory TopSubject.fromJson(Map<String,dynamic> json) => _$TopSubjectFromJson(json);
    Map<String, dynamic> toJson() => _$TopSubjectToJson(this);
}
