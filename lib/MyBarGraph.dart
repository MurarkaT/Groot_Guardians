import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'ProgressChart.dart';

class MyBarGraph extends StatefulWidget{
  MyBarGraph({super.key});

  @override
  _MyBarGraphState createState() => _MyBarGraphState();
}

const dayCount=7;

class _MyBarGraphState extends State<MyBarGraph> {
  bool _isLoaded = false;
  List<Score> _scores=[];
  late Map<DateTime,String> mp;
  List<dynamic>? fieldValue=[];

  @override
  void initState(){
    super.initState();
    getData().then((value) {
      _isLoaded=true;
      setState(() {
      });
    });

  }


  Future<List<Score>> getData() async{
    List<Score> lst=[];
    for(int i=0;i<7;i++){
      final d=DateTime.now().subtract(Duration(days: DateTime.now().weekday-i));
      String dt = new DateFormat('yyyy-MMM-dd').format(d);
      //get data for this date

      double totalScreenTime=0.00;
      try{
        String userId=await FirebaseAuth.instance.currentUser!.uid;
        DocumentReference docRef= FirebaseFirestore.instance.collection('p').doc(userId);
        var snapshot = await docRef.get();

        if(snapshot.exists){
          setState(() {
            fieldValue=snapshot.get('mp')[dt];
            //print(fieldValue);
          });

          if(fieldValue!=null){
          fieldValue!.forEach((element) {
            totalScreenTime+=double.parse(element['screenTime']);
          });
        }else{
            totalScreenTime=0;
          }}

        lst.add(Score(totalScreenTime,d));



      } catch(e){
          print('ERROR RETRIEVING : ${e}');
      }

      //lst.forEach((element) { print("${element.value} ${element.time}");});
      setState(() {
        _scores=lst;
      });
    }

    _scores.forEach((p){print(p.value);});
    return _scores;
  }
  @override
  Widget build(BuildContext context){
    return Stack(
      children:[
        Image.asset("assets/images/stars.gif",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,),
        Scaffold(
          backgroundColor: Colors.transparent,
      body:Column(
      children:[Container(
        margin: EdgeInsets.only(top:100),
        child:SizedBox(
          height:250.0,
          child:LayoutBuilder(builder: (context,constraints){
            if(_isLoaded) return ProgressChart(_scores);
            return Text("HEY",style: TextStyle(color: Colors.white),);
          },),

          ),


        ),


        Expanded(
          child: SingleChildScrollView(
            child:ListView.builder(
                shrinkWrap: true,
              itemCount:5,
              itemBuilder: (context,index){
                return Padding(
                    padding: const EdgeInsets.only(top:25.0,bottom: 25.0),
                    child:ListTile(
                      leading: Image.asset('assets/images/user.png',color: Colors.white,),
                      title: Text("Youtube",style: TextStyle(color: Colors.white),),
                        trailing: Text("4.05 Hours",style: TextStyle(color: Colors.white),),
                    )
                );
              }
            )
          ),
        ),

      ]),
    ),


      ]
    );
  }
}