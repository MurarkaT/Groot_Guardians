import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import'firebase_options.dart';
import 'package:location/location.dart';

import 'helpers/auth.dart';
import 'main.dart';




void main() async{
 // WidgetsFlutterBinding.ensureInitialized();
 // await Firebase.initializeApp(
 //   options: DefaultFirebaseOptions.currentPlatform,
 // );
  //sharedPreferences= await SharedPreferences.getInstance();
  // await dotenv.load(fileName: "assets/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Auth(),//Locate()
    );
  }
}