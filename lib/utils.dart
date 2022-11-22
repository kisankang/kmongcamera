import 'package:flutter/material.dart';

class Constants {
  static Color selectionColor = Colors.red;
  static Color guideBoxColor = Colors.black.withOpacity(0.9);
}

class Helper {
  BuildContext context;
  Helper(this.context);
  double scaledScreenWidth(double width) {
    double result;
    result = width * MediaQuery.of(context).size.width;
    return result;
  }

  double scaledScreenHeight(double height) {
    double result;
    result = height * MediaQuery.of(context).size.height;
    return result;
  }
}
