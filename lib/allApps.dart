import 'dart:ffi';
import 'package:tuple/tuple.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:groot_guardians/main.dart';
import 'package:groot_guardians/usage_details.dart';
import 'package:usage_stats/usage_stats.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'MyBarGraph.dart';
import 'homepage.dart';
import 'main2.dart';
import 'schema/app_info.dart';
import 'package:tuple/tuple.dart';


class AllApps extends StatefulWidget{
  const AllApps({super.key});

  State<AllApps> createState()=> _AllAppsState();
}

class _AllAppsState extends State<AllApps>{
  List<UsageInfo> events=[];
  List<Tuple2<double,String>>result=[];
  List<AppInfo> appInfos=[];
  String lat=sharedPreferences.getDouble('latitude').toString();
  String lon=sharedPreferences.getDouble('longitude').toString();
  LocationData? _locationData;
  bool? _serviceEnabled;
  String? date;
  Location _location= Location();
  PermissionStatus? _permissionGranted;

  void getLocation() async {

    setState(() {
      date=new DateFormat('yyyy-MMM-dd').format(new DateTime.now());
    });
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await _location.requestService();
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
    }
    String userId=await FirebaseAuth.instance.currentUser!.uid;
    var docu=await FirebaseFirestore.instance.collection('p').doc(userId);
    await _location.getLocation().then((value){

      setState(() {
        _locationData=value;
        docu.update({
          'latitude': _locationData!.latitude,
          'longitude':_locationData!.longitude,
        });

      });
    });
  }


  void getAllInstalledApps() async{
    UsageStats.grantUsagePermission();
    // check if permission is granted
    bool isPermission = UsageStats.checkUsagePermission() as bool;

    List<Application> apps = await DeviceApps.getInstalledApplications(
      includeSystemApps: true,onlyAppsWithLaunchIntent: true,
      includeAppIcons: true,
    );

    DateTime endDate = new DateTime.now();
    DateTime startDate = DateTime(endDate.year, endDate.month, endDate.day, 0, 0, 0);
    print("HEY");
    List<UsageInfo> usageStats = await UsageStats.queryUsageStats(startDate, endDate);
    Map<String,String> scr={};
    print("HEY");
    if(usageStats.isNotEmpty){
      for(int i=0;i<usageStats.length;i++){
        scr[usageStats[i].packageName!]=usageStats[i].totalTimeInForeground!;
          print(scr[usageStats[i].packageName!]);
      }
    }
    print("HEY ${usageStats.length} ${apps.length}");
    if(apps.isNotEmpty) {
      apps.forEach((element) {
        String scrtime1=(scr.containsKey(element.packageName))?scr[element.packageName]!:"0";
        //  print("SCREEN TIME : ${scrtime}");
        String scrtime=(double.parse(scrtime1!) / 1000 / 3600).toStringAsFixed(2);
        AppInfo infos = AppInfo(element.appName, element.packageName, scrtime, '');
        setState(() {
          appInfos.add(infos);
        });
      });

      String userId=await FirebaseAuth.instance.currentUser!.uid;


      try {
        await FirebaseFirestore.instance.collection('p').doc(userId).update({
          'mp.$date': appInfos.map((e)=> e.toJSON()).toList(),
        });
        print("SUCCESS");
      } catch (e){
        print('ERROR : $e');
      }
      print("HEY I AM HERE");

      /*    if(docSnapshot.exists){
        Map<String,List<AppInfo>> mp;
        print('I AM IN INSTALLED APPS');
        Map<String,dynamic> data=docSnapshot.data()!;
       mp=data['mp'];
       print(data);
        setState(() {
          mp[date]=appInfos;
        });
        await FirebaseFirestore.instance.collection('p').doc(userId).update({'mp':mp,'latitude': lat,'longitude': lon});
      }
*/
    }
    //  await FirebaseFirestore.instance.collection('p').doc(FirebaseAuth.instance.currentUser!.uid.toString()).update({'app'});
  }

  void getPieData() async{

    List<Tuple2<double,String>> allUsage=[];
    double totalScreenTime=0.00;
    try{
      String userId=await FirebaseAuth.instance.currentUser!.uid;
      DocumentReference docRef= FirebaseFirestore.instance.collection('p').doc(userId);
      var snapshot = await docRef.get();

      if(snapshot.exists){
        // String date=new DateFormat('yyyy-MMM-dd').format(new DateTime.now());
        List<dynamic> fieldValue=snapshot.get('mp')[date];
        // print(fieldValue);

        //now we have got the mp so
        fieldValue.forEach((element){
          allUsage.add(Tuple2(double.parse(element['screenTime']),element['appName']));
          totalScreenTime+=double.parse(element['screenTime']);
        });

        //now got the tuple array now sort it
        allUsage.sort((a,b)=> a.item1.compareTo(b.item1));
        allUsage=allUsage.reversed.toList();
        for(int i=0;i<3;i++){
          setState(() {
            result.add(Tuple2(allUsage[i].item1,allUsage[i].item2));
          });
          // print("${allUsage[i].item1} ${allUsage[i].item2}");
        }
        setState(() {
          result.add(Tuple2(totalScreenTime-allUsage[0].item1-allUsage[1].item1-allUsage[2].item1,"OTHERS"));
        });
      }
    } catch(e){
      print('ERROR RETRIEVING DATA : ${e}');
    }

  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
    getAllInstalledApps();
    getPieData();
  }


  @override
  Widget build(BuildContext context){
    return Stack(
        children:[Image.asset("assets/images/on_boarding_images/stars.gif",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,),
          Container(
              child:FutureBuilder(
                  future:DeviceApps.getInstalledApplications(
                    includeSystemApps: true,onlyAppsWithLaunchIntent: true,
                    includeAppIcons: true,
                  ),

                  builder:(context,snapshot){
                    if(!snapshot.hasData){
                      return Container(child:Text("We do not have any apps installed",style:TextStyle(decoration: TextDecoration.none,fontSize: 1,color: Colors.black)),);
                    }

                    List<Application> apps=snapshot.data as List<Application>;

                    //print("LENGTH OF THE APPInfos ${appInfos.length}");


                    return Padding(padding: EdgeInsets.only(top:30,left:5),
                        child:Column(
                            children:[
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:[
                                    Text("All Installed Apps : ",style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontFamily: 'Glass Antiqua',
                                      decoration: TextDecoration.none
                                    ),),
                                    IconButton(onPressed: () async{await FirebaseAuth.instance.signOut();
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                      return HomePage();
                                    }));},
                                        icon: Icon(Icons.logout,color: Colors.white,))
                                  ]
                              ),
                              SizedBox(height:1),
                              SizedBox(
                                  height: 140.0,
                                  child:ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: apps.length,
                                      //       shrinkWrap: true,
                                      //      physics: const ScrollPhysics(),
                                      itemBuilder: (context,index){
                                        return Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child:GestureDetector(
                                                onTap: () async {
                                                  await FirebaseFirestore.instance.collection('users').add({
                                                    'appName':apps[index].appName,
                                                  });
                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                                    return UsageDetails(application: apps[index],);
                                                  }));
                                                },
                                                child:Container(
                                                    width: 100,
                                                    height: 125,
                                                    decoration: BoxDecoration(
                                                      color:Colors.deepPurple.withOpacity(0.05),
                                                      borderRadius: BorderRadius.circular(15),

                                                    ),
                                                    child:Column(
                                                        children:[ Image.memory((apps[index] as ApplicationWithIcon).icon),
                                                          Text('${apps[index].appName}',style: TextStyle(
                                                            fontFamily: 'Poppins',
                                                            color:Colors.white,
                                                            decoration: TextDecoration.none,
                                                            fontSize: 10,
                                                          ),),
                                                        ]
                                                    ))));
                                      }
                                  )),
                              Expanded(
                                  child: Padding(
                                      padding: EdgeInsets.only(top:5,left:30,right:30),
                                      child:GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => MyBarGraph(apps)));},
                                          child:AbsorbPointer(
                                              child:Stack(
                                                  children:[
                                                    PieChart(
                                                        PieChartData(
                                                            sections: [
                                                              PieChartSectionData(
                                                                value: result[0].item1,
                                                                title: result[0].item2,
                                                                titleStyle: TextStyle(
                                                                  fontSize: 12,
                                                                  color:Colors.white,
                                                                  decoration: TextDecoration.none,
                                                                ),
                                                                color:Color(0xFFA30C1B),
                                                              ),
                                                              PieChartSectionData(
                                                                value: result[1].item1,
                                                                title: result[1].item2,
                                                                titleStyle: TextStyle(
                                                                  fontSize: 12,
                                                                  decoration: TextDecoration.none,
                                                                  color:Colors.white,
                                                                ),
                                                                color:Color(
                                                                    0xFF249254),
                                                              ),
                                                              PieChartSectionData(
                                                                value: result[2].item1,
                                                                title: result[2].item2,
                                                                titleStyle: TextStyle(
                                                                  fontSize: 12,
                                                                  decoration: TextDecoration.none,
                                                                  color:Colors.white,
                                                                ),
                                                                color:Color(0xFF14570F),
                                                              ),
                                                              PieChartSectionData(
                                                                value: result[3].item1,
                                                                title: result[3].item2,
                                                                titleStyle: TextStyle(
                                                                  fontSize: 12,
                                                                  decoration: TextDecoration.none,
                                                                  color:Colors.white,
                                                                ),
                                                                color:Color(0xFFFADB01),
                                                              )
                                                            ]
                                                        )
                                                    ),

                                                    Center(child:Text(date!,style: TextStyle(color: Colors.white,fontSize: 14,decoration: TextDecoration.none),)),
                                                  ]
                                              )))



                                  ))
                            ]));}))]);


  }
}