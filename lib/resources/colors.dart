import 'package:flutter/material.dart';

class AppColors {
  static const Map<int, Color> primaryColorScheme = {
    50: Color.fromRGBO(88, 119, 72, .1),
    100: Color.fromRGBO(88, 119, 72, .2),
    200: Color.fromRGBO(88, 119, 72, .3),
    300: Color.fromRGBO(88, 119, 72, .4),
    400: Color.fromRGBO(88, 119, 72, .5),
    500: Color.fromRGBO(88, 119, 72, .6),
    600: Color.fromRGBO(88, 119, 72, .7),
    700: Color.fromRGBO(88, 119, 72, .8),
    800: Color.fromRGBO(88, 119, 72, .9),
    900: Color.fromRGBO(88, 119, 72, 1),
  };
  static const primaryColor = MaterialColor(0xFF587748, primaryColorScheme);
  static const primaryColorLight = Color.fromRGBO(132, 174, 110, 1);
  static const deactivateColour = Color.fromRGBO(255, 56, 94, 1);
}
