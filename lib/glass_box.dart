import 'dart:ui';

import 'package:flutter/material.dart';

class GlassBox extends StatelessWidget {
  final height;
  final width;
  final child;

  GlassBox({
    required this.height,
    required this.width,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRect(
        //borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 300,
          height: 250,
          child: Stack(
            children: [
              //blur effect
              BackdropFilter(
                filter: ImageFilter.blur(
                  //for level of blur
                  sigmaX: 5,
                  sigmaY: 5,
                ),
                child: Container(),
              ),
              //gradient effect
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                    //borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        colors: [
                          Colors.white.withOpacity(0.1),
                          Colors.white.withOpacity(0.2),
                        ]
                    )
                ),
              ),
              //child
              child,
            ],
          ),
        ),
      ),
    );
  }
}