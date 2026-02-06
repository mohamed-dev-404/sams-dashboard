import 'package:flutter/material.dart';

class SizeConfig {
  SizeConfig._();

  // Base design size for web dashboard
  static const Size webBaseSize = Size(1440, 1024);
  static const int kSmallWebLayoutbreakPoint = 1000;

  // Screen dimensions helpers
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
}
