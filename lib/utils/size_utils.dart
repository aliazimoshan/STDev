import 'package:flutter/material.dart';

class ScreenSize {
  static double height(context) {
    return MediaQuery.of(context).size.height;
  }

  static double width(context) {
    return MediaQuery.of(context).size.width;
  }

  static Size size(context) {
    return MediaQuery.of(context).size;
  }
}
