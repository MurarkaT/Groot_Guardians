import 'app_info.dart';

class Parent{
  String userId;
  String name;
  String deviceToken;
  String latitude;
  String longitude;
  Map<String,List<AppInfo>> mp;//date,
  String parentCode;

  Parent(
      this.userId,
      this.name,
      this.deviceToken,
      this.latitude,
      this.longitude,
      this.mp,
      this.parentCode,
      );

  Map<String,dynamic> toJSON(){
    return {
      "userId":userId,
      "name":name,
      "deviceToken":deviceToken,
      "latitude":latitude,
      "longitude":longitude,
      "mp":mp,
      "parentCode":parentCode,
    };
  }
}