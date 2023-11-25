import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groot_guardians/homepage.dart';
import 'package:groot_guardians/HomeManagement.dart';
import 'package:groot_guardians/authentication2/login.dart';
import 'package:groot_guardians/allApps.dart';

import '../authentication2/login.dart';


class Auth extends StatelessWidget{
  const Auth({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
        body:StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                return HomePage();
              }
              else{
                return Login();
              }
            }

        )
    );
  }
}