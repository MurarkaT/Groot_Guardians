import 'package:flutter/material.dart';
class TextBox extends StatelessWidget{
  final controller;
  final String hintText;
  final bool obscureText;
  final Icon icon1;

  const TextBox({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.icon1,
  });


  @override
  Widget build(BuildContext context){
    return  Padding(padding: const EdgeInsets.symmetric(horizontal:25.0,vertical:10.0),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: icon1,
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