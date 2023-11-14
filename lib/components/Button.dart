import 'package:flutter/material.dart';

class Button extends StatelessWidget{
  final Function()? onTap;
  Button({super.key,required this.onTap});

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child:Container(
      padding: EdgeInsets.all(15),
      margin:const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color:const Color(0xB1795EDC),
        borderRadius: BorderRadius.circular(8),
      ),
        child:Center(
            child:Text("Sign Up",style: TextStyle(color: Colors.white,fontFamily: 'Poppins',fontSize:16,fontWeight: FontWeight.bold),),
        )
    )
    );
  }
}