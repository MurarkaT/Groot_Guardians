import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groot_guardians/authentication2/signup.dart';

import '../../../../../helpers/auth.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../login/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {


    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;


    return Stack(
      children:[
      Image.asset("assets/images/on_boarding_images/stars.gif",
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,),
      Scaffold(
        backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.all(tDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(image: const AssetImage(tWelcomeScreenImage), height: height * 0.6),
            Column(
              children: [
                Text(tWelcomeTitle, style: GoogleFonts.shadowsIntoLightTwo(textStyle: TextStyle(color: Colors.amber,fontSize: 33,height: 1.0)),),
                Text(tWelcomeSubTitle,
                    style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.orange,fontSize: 14)),
                    textAlign: TextAlign.center),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.to(() => const Auth()),
                    child: Text(tLogin.toUpperCase(),style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.amber,fontSize: 14)),),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => SignUp()),
                    child: Text(tSignup.toUpperCase(),style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.black,fontSize: 14)),),
                  ),
                ),
              ],
            )
          ],
        ),
      ),

    ),
      ]
    );
  }
}