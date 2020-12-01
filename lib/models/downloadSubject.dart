import 'package:json_annotation/json_annotation.dart';

part 'downloadSubject.g.dart';

@JsonSerializable()
class DownloadSubject {
    DownloadSubject();

    String episode;
    String img;
    String cover;
    String title;
    String h5_url;
    String url;
    String type;
    String year;
    String sub_title;
    String id;
    
    factory DownloadSubject.fromJson(Map<String,dynamic> json) => _$DownloadSubjectFromJson(json);
    Map<String, dynamic> toJson() => _$DownloadSubjectToJson(this);
}
