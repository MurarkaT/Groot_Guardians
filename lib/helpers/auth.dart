import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kanha1011/HomeManagement.dart';
import 'package:kanha1011/authentication/login.dart';
import 'package:kanha1011/Locate.dart';
import 'package:kanha1011/allApps.dart';


class Auth extends StatelessWidget{
  const Auth({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
       body:StreamBuilder<User?>(
         stream: FirebaseAuth.instance.authStateChanges(),
         builder: (context,snapshot){
           if(snapshot.hasData){
             return HomeManagement();
           }
           else{
             return Login();
           }
         }

       )
    );
  }
}