import 'package:flutter/material.dart';
class TextBox extends StatelessWidget{
  final controller;
  final String hintText;
  final bool obscureText;


  const TextBox({
    super.key,
    required this.controller,
  required this.hintText,
    required this.obscureText,
  });


  @override
  Widget build(BuildContext context){
    return  Padding(padding: const EdgeInsets.symmetric(horizontal:25.0,vertical:10.0),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color:Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color:Colors.grey.shade400),),
            fillColor:Colors.grey.shade200,
            hintText: hintText,
            hintStyle: TextStyle(color:Colors.grey,fontFamily: 'Poppins'),

            //filled:true,
          ),
          style: TextStyle(color:Colors.white,fontFamily: 'Poppins'),
        )
    );
  }
}