import 'package:flutter/material.dart';
import 'package:groot_guardians/src/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:groot_guardians/src/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:groot_guardians/src/utils/theme/widget_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData LightTheme= ThemeData(
    brightness: Brightness.light,
    textTheme: TTextTheme.LightTextTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: TTextTheme.darkTextTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
      elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme
  );
}