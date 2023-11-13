import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../controllers/splash_screen_controller.dart';


class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final splashController = Get.put(SplashScreenController());


  @override
  Widget build(BuildContext context) {
    SplashScreenController.find.startAnimation();


    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Obx(
                () => AnimatedPositioned(
              duration: const Duration(milliseconds: 1600),
              top: splashController.animate.value ? 0 : -30,
              left: splashController.animate.value ? 0 : -30,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1600),
                opacity: splashController.animate.value ? 1 : 0,
                child:  Image(image: AssetImage(tSplashTopIcon)),
              ),
            ),
          ),
          Center(
            child: Container(
              child: Image.network('https://media.giphy.com/media/W9VeKPg5t9jJhq2o4k/giphy.gif'),
            ),
          ),
          Obx(
                () => AnimatedPositioned(
              duration: const Duration(milliseconds: 3000),
              top: 555,
              left: splashController.animate.value ? tDefaultSize : -20,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 3000),
                opacity: splashController.animate.value ? 1 : 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tApp, style: GoogleFonts.shadowsIntoLight(
                      textStyle: TextStyle(color: Colors.orange,fontSize: 30)
                    ),),
                    Text(tAppName,style: GoogleFonts.shadowsIntoLightTwo(textStyle: TextStyle(color: Colors.amber,fontSize: 44,height: 1.0)),),
                    Text(tAppTagLine, style: GoogleFonts.shadowsIntoLight(
                        textStyle: TextStyle(color: Colors.orange,fontSize: 25,height: 1.0)
                    ),),
                  ],
                ),
              ),
            ),
          ),
          //Obx(
           //     () => AnimatedPositioned(
           //   duration: const Duration(milliseconds: 2400),
            //  bottom: splashController.animate.value ? -40 : 0,
            //  child: AnimatedOpacity(
            //    duration: const Duration(milliseconds: 2000),
             //   opacity: splashController.animate.value ? 1 : 0,

             //   child:  Image(image: AssetImage(tSplashImage)),
           //   ),
          //  ),
         // ),
          Obx(
                () => AnimatedPositioned(
              duration: const Duration(milliseconds: 2400),
              bottom: splashController.animate.value ? 60 : 0,
              right: tDefaultSize,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 2000),
                opacity: splashController.animate.value ? 1 : 0,
                child: Container(
                  width: tSplashContainerSize,
                  height: tSplashContainerSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: tPrimaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}