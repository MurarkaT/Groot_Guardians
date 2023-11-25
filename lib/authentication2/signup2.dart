import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groot_guardians/components/text_box.dart';
import 'package:groot_guardians/components/Button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groot_guardians/homepage.dart';
import 'package:groot_guardians/main.dart';

import '../components/Button.dart';
import '../schema/parent.dart';
import '../src/constants/image_strings.dart';
import '../src/constants/sizes.dart';
import '../src/constants/text_strings.dart';
import 'login2.dart';
class SignUp2 extends StatefulWidget{
  SignUp2({super.key});

  @override
  State<SignUp2> createState() => _SignUpState2();
}

class _SignUpState2 extends State<SignUp2> {
  final usernameController=TextEditingController();

  final passwordController=TextEditingController();


  void signUserUp () async {
    try{
      UserCredential credential=await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: usernameController.text,
          password: passwordController.text);

      Parent parent=new Parent(credential.user!.uid,'','','','',{},'');
      await FirebaseFirestore.instance.collection('p').doc(credential.user!.uid).set(parent.toJSON());

      sharedPreferences.setString('parentUid', credential.user!.uid);
      Navigator.push(context,MaterialPageRoute(builder: (context)=> HomePage()));

    } on FirebaseAuthException catch(e){
      print(e);
      invalidDialog(e.toString());
    }


  }
  void invalidDialog(String err){
    Widget okButton=TextButton(
      child:Text("OK"),
      onPressed: (){
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert=AlertDialog(
      title:Text("Wrong Credentials"),
      content: Text(err),
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
                                    Text("Welcome!", style: GoogleFonts.shadowsIntoLightTwo(textStyle: TextStyle(color: Colors.amber,fontSize: 33)),),
                                    Text("Your child's digital safety journey begins here.", style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.orange,fontSize: 15)),),
                                  ],
                                ),
                                SizedBox(height:25),

                                TextBox(
                                    controller: usernameController,
                                    hintText: 'Email',
                                    obscureText: false,
                                    icon1:Icon(Icons.email,color:Colors.white)
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
                                        Text("Already Have an Account?",style:TextStyle(fontFamily: 'VT323',color: Colors.white,fontSize: 20)),
                                        TextButton(child:Text('Log In',style: TextStyle(fontFamily: 'VT323',color: Colors.red,fontSize: 20)),onPressed: (){

                                        },),
                                      ],
                                    )),
                                SizedBox(height: 20,),
                                Button(
                                  onTap: (){
                                    signUserUp();
                                  },
                                  text1:"Sign In",
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