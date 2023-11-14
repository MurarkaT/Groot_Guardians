import 'package:flutter/material.dart';
import 'package:kanha1011/components/text_box.dart';
import 'package:kanha1011/components/Button.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Login extends StatefulWidget{
     Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
    final usernameController=TextEditingController();

    final passwordController=TextEditingController();

     void signUserIn() async{
       try {
         await FirebaseAuth.instance.signInWithEmailAndPassword(
           email: usernameController.text,
           password: passwordController.text,
         );
       } on FirebaseAuthException catch (e) {
         if(e.code=='user-not-found'){
           wrongEmailDialog();
         }
         else if(e.code=='wrpng-password'){
            wrongPassword();
         }
       }
     }

     void wrongEmailDialog(){
       showDialog(context: context, builder: (context){
         return const AlertDialog(
           title: Text("Incorrect Email"),
         );
       });
     }

     void wrongPassword(){
       showDialog(context: context, builder: (context){
         return const AlertDialog(
           title: Text("Incorrect Password"),
         );
       });
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
            resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body:SafeArea(
                  child: Center(
                      child:Column(
                          children:[
                            Image.asset("assets/images/liner.png",height:100),
                            Image.asset("assets/images/panda.gif"),
                            SizedBox(height:25),
                            TextBox(
                              controller: usernameController,
                              hintText: 'Username',
                              obscureText: false,
                            ),
                            TextBox(
                              controller: passwordController,
                              hintText: 'Password',
                              obscureText: true,
                            ),

                            SizedBox(height: 20,),
                            Text('Sign In',style: TextStyle(fontFamily: 'VT323',color: Colors.white,fontSize: 20),),
                            SizedBox(height: 20,),
                            Button(
                              onTap: signUserIn,
                            ),
                          ]
                      )
                  )
              )
          )

        ]


      );
    }
}