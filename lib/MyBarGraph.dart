import 'dart:math';

import 'package:flutter/material.dart';

import 'ProgressChart.dart';

class MyBarGraph extends StatefulWidget{
  MyBarGraph({super.key});

  @override
  _MyBarGraphState createState() => _MyBarGraphState();
}

final rng=Random();
const dayCount=7;

class _MyBarGraphState extends State<MyBarGraph> {
  late List<Score> _scores;

  @override
  void initState(){
    super.initState();
    final scores=List<Score>.generate(dayCount, (index){
      final y=rng.nextDouble()*30.0;
      final d=DateTime.now().add(Duration(days: -dayCount+index));
      return Score(y,d);
    });

    setState(() {
      _scores=scores;
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:Container(
        color:Colors.red,
        margin: EdgeInsets.only(top:100),
        child:SizedBox(
          height:150.0,
          child:ProgressChart(_scores),
        )
      ),
    );
  }
}