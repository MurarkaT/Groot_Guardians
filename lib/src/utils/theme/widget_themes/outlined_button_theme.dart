import 'package:flutter/material.dart';
import 'package:groot_guardians/src/constants/colors.dart';
import 'package:groot_guardians/src/constants/sizes.dart';

class TOutlinedButtonTheme {
  TOutlinedButtonTheme._();

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(),
      foregroundColor: tPrimaryColor,
      side: BorderSide(color: tPrimaryColor),
      padding: EdgeInsets.symmetric(vertical: tButtonHeight),
    )
  );

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(),
        foregroundColor: tWhiteColor,
        side: BorderSide(color: tWhiteColor),
        padding: EdgeInsets.symmetric(vertical: tButtonHeight),
      )
  );
}