import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:usage_stats/usage_stats.dart';
import 'package:o3d/o3d.dart';
import 'package:intl/intl.dart';
class UsageDetails extends StatefulWidget{
  final Application application;
  UsageDetails({super.key,required this.application});

  @override
  State<UsageDetails> createState()=> _UsageDetailsState();
}

class _UsageDetailsState extends State<UsageDetails>{
  O3DController o3dController=O3DController();
  UsageInfo? appUsageInfo;
   getUsage() async {

    DateTime endDate = new DateTime.now();
    DateTime startDate = DateTime(endDate.year, endDate.month, endDate.day, 0, 0, 0);


    // query events
    //List<EventUsageInfo> events = await UsageStats.queryEvents(startDate, endDate);

    // query usage stats
    List<UsageInfo> usageStats = await UsageStats.queryUsageStats(startDate, endDate);
 // print(await UsageStats.queryUsageStats(startDate, endDate));
    if(usageStats.isNotEmpty){
      usageStats.forEach((element){
        if(element.packageName==widget.application.packageName){
          setState((){
            appUsageInfo=element;
            print('VALUE INISDE APP USAGE ${appUsageInfo!.packageName}');

          });
        }
      });
    }
    // query eventStats API Level 28
    //List<EventInfo> eventStats = await UsageStats.queryEventStats(startDate, endDate);

    // query configurations
    //List<ConfigurationInfo> configurations = await UsageStats.queryConfiguration(startDate, endDate);

    // query aggregated usage statistics
    //Map<String, UsageInfo> queryAndAggregateUsageStats = await UsageStats.queryAndAggregateUsageStats(startDate, endDate);

    // query network usage statistics
   // List<NetworkInfo> networkInfos = await UsageStats.queryNetworkUsageStats(startDate, endDate, networkType: NetworkType.all);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsage();
  }

  String giveScreenTimeInHours(){
     if(appUsageInfo==null){
       return "0.00 Hours";
     }

     return "${(double.parse(appUsageInfo!.totalTimeInForeground!) / 1000 / 3600).toStringAsFixed(2)} Hours";
  }

  String giveLastTimeInHours(){
     if(appUsageInfo==null) return "Not Used Today";
     return "${DateFormat('dd-MM-yyyy HH:mm:ss').format( DateTime.fromMillisecondsSinceEpoch(int.parse(appUsageInfo!.lastTimeUsed!)))
          }";
  }

  @override
  Widget build(BuildContext context){
    return
      Stack(
      children:[
        Image.asset("assets/images/stars.gif",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,),
        //groot animation

        Scaffold(
          backgroundColor:Colors.transparent,
          appBar: AppBar(title:Text("${widget.application.appName}"),
          backgroundColor: Colors.purple,),
      body:Column(
        children:[
          SizedBox(height: 30,),
        Padding(padding:EdgeInsets.only(left: 20,right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            Text(
              "Screen Time",
              textAlign: TextAlign.left,
              style:TextStyle(
                decoration: TextDecoration.none,
                fontFamily: 'Poppins',
                fontSize: 15,
                color: const Color(0xFFD78BE3),
              )
            ),
            Text(
              giveScreenTimeInHours(),
              textAlign: TextAlign.left,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontFamily: 'Poppins',
                fontSize: 15,
                color: const Color(0xD68CE3FF),
              ),
            )
          ]
        )),
          Padding(padding:EdgeInsets.only(top:10,left:20,right:20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text(
                        "Last Used Time",
                        textAlign: TextAlign.left,
                        style:TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: const Color(0xFFD78BE3),
                        )
                    ),
                    Text(
                      giveLastTimeInHours(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        color: const Color(0xD68CE3FF),
                      ),
                    )
                  ]
              )),
        ],
    )),
        Container(child:O3D(src:'assets/animation/groot_dancing.glb',
          controller: o3dController,
          autoPlay: true,
        ),
          margin: EdgeInsets.only(top: 250),),
      ]);
  }
}
/*
child:appUsageInfo==null?Text("0.00 Hours",
              style: TextStyle(
                decoration: TextDecoration.none,
              fontFamily: 'Poppins',
              fontSize: 25,
                color: const Color(0xD68CE3FF),
              ),):
    Text("${(double.parse(appUsageInfo!.totalTimeInForeground!) / 1000 / 3600).toStringAsFixed(2)} Hours",
    style: TextStyle(
      decoration: TextDecoration.none,
      fontFamily: 'Poppins',
      fontSize: 25,
      color: const Color(0xD68CE3FF),
    ),
    ),
 */