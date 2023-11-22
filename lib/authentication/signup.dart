import 'package:flutter/material.dart';
import 'package:kanha1011/components/text_box.dart';
import 'package:kanha1011/components/Button.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SignUp extends StatefulWidget{
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final usernameController=TextEditingController();

  final passwordController=TextEditingController();

  @override
  Widget build(BuildContext context){
    final size=MediaQuery.of(context).size;
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
                  child:SingleChildScrollView(
                      child: Center(
                          child:Column(
                              children:[
                                Image.asset("assets/images/liner.png",height:100),
                                Image.asset("assets/images/panda.gif"),
                                SizedBox(height:25),
                                TextBox(
                                    controller: usernameController,
                                    hintText: 'Name',
                                    obscureText: false,
                                    icon1:Icon(Icons.account_circle_outlined,color:Colors.white)
                                ),
                                TextBox(
                                    controller: usernameController,
                                    hintText: 'Email',
                                    obscureText: false,
                                    icon1:Icon(Icons.email_outlined,color:Colors.white)
                                ),
                                TextBox(
                                    controller: usernameController,
                                    hintText: 'Phone Number',
                                    obscureText: false,
                                    icon1:Icon(Icons.numbers,color:Colors.white)
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
                                        Text("Not Signed Up ",style:TextStyle(fontFamily: 'VT323',color: Colors.white,fontSize: 20)),
                                        TextButton(child:Text('Sign Up',style: TextStyle(fontFamily: 'VT323',color: Colors.red,fontSize: 20)),onPressed: (){},),
                                      ],
                                    )),
                                SizedBox(height: 20,),
                                Button(
                                  onTap: (){},
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