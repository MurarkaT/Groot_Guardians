import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:groot_guardians/authentication2/signup.dart';
import 'package:groot_guardians/components/text_box.dart';
import 'package:groot_guardians/components/Button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groot_guardians/homepage.dart';
import 'package:groot_guardians/main.dart';
import 'package:groot_guardians/schema/parent.dart';
import 'package:groot_guardians/src/features/authentication/screens/welcome/welcome_screen.dart';

import '../src/constants/image_strings.dart';
import '../src/constants/sizes.dart';
import '../src/constants/text_strings.dart';
class Login2 extends StatefulWidget{
  Login2({super.key});

  @override
  State<Login2> createState() => _LoginState2();
}

class _LoginState2 extends State<Login2> {
  final usernameController=TextEditingController();

  final passwordController=TextEditingController();

  void signUserIn() async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      );

      String pid=await FirebaseAuth.instance.currentUser!.uid;
      sharedPreferences.setString('parentUid', pid);
      Navigator.push(context,MaterialPageRoute(builder: (context)=> HomePage()));
    } on FirebaseAuthException catch (e) {
      if(e.code=='user-not-found'){
        print("USER NOT FOUND");
        wrongEmailDialog();
      }
      else if(e.code=='wrong-password'){
        wrongPasswordDialog();
      }
      else invalidDialog();
    }
  }





  void invalidDialog(){
    Widget okButton=TextButton(
      child:Text("OK"),
      onPressed: (){
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert=AlertDialog(
      title:Text("Wrong Credentials"),
      content: Text("Your email or password might be wrong"),
      actions: [
        okButton,
      ],
    );
    showDialog(context: context, builder: (context){
      return alert;
    });
  }
  void wrongEmailDialog(){
    Widget okButton=TextButton(
      child:Text("OK"),
      onPressed: (){},
    );

    AlertDialog alert=AlertDialog(
      title:Text("Wrong Email"),
      content: Text("Please try with correct email"),
      actions: [
        okButton,
      ],
    );
    showDialog(context: context, builder: (context){
      return alert;
    });
  }

  void wrongPasswordDialog(){
    Widget okButton=TextButton(
      child:Text("OK"),
      onPressed: (){},
    );

    AlertDialog alert=AlertDialog(
      title:Text("Wrong Password"),
      content: Text("Please try with correct password"),
      actions: [
        okButton,
      ],
    );
    showDialog(context: context, builder: (context){
      return alert;
    });
  }


  @override
  Widget build(BuildContext context){
    final size=MediaQuery.of(context).size;
    return Stack(
        children:[
          Image.asset("assets/images/on_boarding_images/stars.gif",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,),
          Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body:SafeArea(
                  child:SingleChildScrollView(
                      child: Center(
                          child:Column(
                              children:[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image(
                                        image: const AssetImage(tWelcomeScreenImage1),
                                        height: size.height * 0.2),
                                    Text(tLoginTitle, style: GoogleFonts.shadowsIntoLightTwo(textStyle: TextStyle(color: Colors.amber,fontSize: 33)),),
                                    Text(tLoginSubTitle, style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.orange,fontSize: 15)),),
                                  ],
                                ),
                                SizedBox(height:25),
                                TextBox(
                                    controller: usernameController,
                                    hintText: 'Email',
                                    obscureText: false,
                                    icon1:Icon(Icons.account_circle_outlined,color:Colors.white)
                                ),
                                TextBox(
                                  controller: passwordController,
                                  hintText: 'Password',
                                  obscureText: true,
                                  icon1:Icon(Icons.fingerprint,color:Colors.white),

                                ),

                                SizedBox(height: 20,),
                                Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center ,//Center Row contents horizontally,
                                      crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
                                      children: [
                                        Text("Don't have an Account?",style:TextStyle(fontFamily: 'VT323',color: Colors.white,fontSize: 20)),
                                        TextButton(child:Text('Sign Up',style: TextStyle(fontFamily: 'VT323',color: Colors.red,fontSize: 20)),onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUp()));
                                        },),
                                      ],
                                    )),
                                SizedBox(height: 20,),
                                Button(
                                  onTap: signUserIn,
                                  text1:"LOGIN",
                                ),

                              ]
                          )
                      )
                  ))
          )

        ]

    );
  }
}