import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/image_strings.dart';
import '../../../../constants/text_strings.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
            image: const AssetImage(tWelcomeScreenImage1),
            height: size.height * 0.2),
        Text(tLoginTitle, style: GoogleFonts.shadowsIntoLightTwo(textStyle: TextStyle(color: Colors.amber,fontSize: 33)),),
        Text(tLoginSubTitle, style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.orange,fontSize: 15)),),
      ],
    );
  }
}