import 'package:flutter/material.dart';

class Styles {
  static Color scaffoldBackgroundColor = Color.fromRGBO(242, 242, 242, 0.961);
  static Color defaultRedColor = Color.fromRGBO(201, 22, 22, 1);
  static Color defaultYellowColor = Color.fromRGBO(121, 157, 240, 1);
  static Color defaultBlueColor = Color.fromRGBO(19, 47, 186, 1);
  static Color defaultGreyColor = Color.fromRGBO(119, 131, 154, 1);
  static Color defaultLightGreyColor = Color.fromRGBO(238, 238, 238, 238);
  static Color defaultLightWhiteColor = Color.fromRGBO(238, 238, 238, 238);

  static double defaultPadding = 18.0;

  static BorderRadius defaultBorderRadius = BorderRadius.circular(20);

  static ScrollbarThemeData scrollbarTheme =
      const ScrollbarThemeData().copyWith(
    thumbColor: WidgetStateProperty.all(defaultYellowColor),
    trackColor: WidgetStateProperty.all(Color(0xFFBBBBBB)),
    trackVisibility: WidgetStatePropertyAll(true),
    thumbVisibility: WidgetStateProperty.all(false),
    interactive: true,
    thickness: WidgetStateProperty.all(10.0),
    radius: Radius.circular(20),
  );
}
