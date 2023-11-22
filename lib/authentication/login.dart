import 'package:flutter/material.dart';
import 'package:kanha1011/components/text_box.dart';
import 'package:kanha1011/components/Button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kanha1011/schema/parent.dart';
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
           print("USER NOT FOUND");
           wrongEmailDialog();
         }
         else if(e.code=='wrong-password'){
            wrongPasswordDialog();
         }
         else invalidDialog();
       }
     }

     void signUserUp () async {
       try{
         UserCredential credential=await FirebaseAuth.instance.createUserWithEmailAndPassword(
             email: usernameController.text,
             password: passwordController.text);

         Parent parent=new Parent(credential.user!.uid,'','','','',{},'');
         await FirebaseFirestore.instance.collection('p').doc(credential.user!.uid).set(parent.toJSON());

       } on FirebaseAuthException catch(e){
         print(e);
         invalidDialog();
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
                              hintText: 'Username',
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
                                Text("Don't have an Account ",style:TextStyle(fontFamily: 'VT323',color: Colors.white,fontSize: 20)),
                                TextButton(child:Text('Sign Up',style: TextStyle(fontFamily: 'VT323',color: Colors.red,fontSize: 20)),onPressed: (){
                                  signUserUp();
                                },),
                              ],
                            )),
                            SizedBox(height: 20,),
                            Button(
                              onTap: signUserIn,
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