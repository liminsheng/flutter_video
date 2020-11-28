import 'package:json_annotation/json_annotation.dart';

part 'myBanner.g.dart';

@JsonSerializable()
class MyBanner {
    MyBanner();

    String title;
    String sub_title;
    String cover;
    String url;
    
    factory MyBanner.fromJson(Map<String,dynamic> json) => _$MyBannerFromJson(json);
    Map<String, dynamic> toJson() => _$MyBannerToJson(this);
}
