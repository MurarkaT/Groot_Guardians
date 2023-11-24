import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/image_strings.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("OR",style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.orange,fontSize: 14)),),
        const SizedBox(height: tFormHeight - 20),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            icon: const Image(image: AssetImage(tGoogleLogoImage), width: 20.0),
            onPressed: () {},
            label: const Text(tSignInWithGoogle),
          ),
        ),
        const SizedBox(height: tFormHeight - 20),
        TextButton(
          onPressed: () {},
          child: Text.rich(
            TextSpan(
                text: tDontHaveAnAccount,
                style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.amber,fontSize: 14)),
                children: const [
                  TextSpan(text: tSignup, style: TextStyle(color: Colors.orange))
                ]),
          ),
        ),
      ],
    );
  }
}