import 'package:flutter/material.dart';

abstract class AppColors {
  static Color scaffoldBackgroundColor = const Color(0xFFFFFFFF);
  static Color defaultRedColor = const Color(0xffff698a);
  static Color defaultYellowColor = const Color(0xFFfedd69);
  static Color defaultBlueColor = const Color(0xff52beff);
  static Color defaultGreyColor = const Color(0xff77839a);
  static Color defaultLightGreyColor = const Color(0xffc4c4c4);
  static Color defaultLightWhiteColor = const Color(0xFFf2f6fe);

  static Color darkBlue = const Color(0xff0d3b66);

  //  Color Palette
  static Color hotPink = const Color(0xffd9296a);
  static Color deepPink = const Color(0xffa6296e);
  static Color deepPurple = const Color(0xff642568);
  static Color brightBlue = const Color(0xff030a8c);
  static Color lightOrange = const Color(0xffffae6b);

  // new Color palette
  static const background = Color(0xFFEBE8E8);
  static const primary = Color(0xffD7406F);
  static const secondary = Color(0xff241D23);
  static const accent = Color(0xffF7896B);
  static ScrollbarThemeData scrollbarTheme =
  const ScrollbarThemeData().copyWith(
    thumbColor: MaterialStateProperty.all(defaultGreyColor),
    interactive: true,
  );
}