import 'app_info.dart';

class Children{
  String userId;
  String name;
  String mobile;
  String deviceToken;
  Map<String,List<AppInfo>> mp;

  Children(this.userId,
      this.name,
      this.mobile,
      this.deviceToken,
      this.mp,
  );


}