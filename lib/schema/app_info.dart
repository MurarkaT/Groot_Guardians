class AppInfo{
  String appName;
  String appPackageName;
  String screenTime;
  String lastTimeUsed;

  AppInfo(this.appName,this.appPackageName,this.screenTime,this.lastTimeUsed);

  Map<String, dynamic> toJSON(){
    return {
      'appName':appName,
      'appPackageName':appPackageName,
      'screenTime':screenTime,
      'lastTimeUsed':lastTimeUsed,
    };
  }
}