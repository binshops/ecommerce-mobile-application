import 'package:flutter/material.dart';
import 'package:prestashop_mobile_app/const_values/assets.dart';
import 'package:prestashop_mobile_app/ui/shared/colors.dart';

TextStyle raleWayBoldWhiteStyle(double size) {
  return TextStyle(
    fontSize: size,
    fontWeight: FontWeight.bold,
    fontFamily: Assets.Raleway,
    color: white,
  );
}

TextStyle raleWayBoldPrimaryDarkStyle(double size) {
  return TextStyle(
    fontSize: size,
    fontWeight: FontWeight.bold,
    fontFamily: Assets.Raleway,
    color: primaryDark,
  );
}

TextStyle raleWayBoldBlackStyle(double size) {
  return TextStyle(
    fontSize: size,
    fontWeight: FontWeight.bold,
    fontFamily: Assets.Raleway,
    color: black,
  );
}

TextStyle raleWayNormalPrimaryDarkStyle(double size) {
  return TextStyle(
    fontSize: size,
    fontWeight: FontWeight.normal,
    fontFamily: Assets.Raleway,
    color: primaryDark,
  );
}

TextStyle normalPrimaryDarkStyle(double size) {
  return TextStyle(
    fontSize: size,
    fontWeight: FontWeight.normal,
    color: primaryDark,
  );
}

TextStyle robotoNormalBlackStyle(double size) {
  return TextStyle(
    color: black,
    fontFamily: Assets.Roboto,
    fontSize: size,
  );
}

TextStyle robotoNormalPrimaryDarkStyle(double size) {
  return TextStyle(
    color: primaryDark,
    fontFamily: Assets.Roboto,
    fontSize: size,
  );
}

TextStyle robotoNormalPrimaryGrayStyle(double size) {
  return TextStyle(
    color: primaryGray,
    fontFamily: Assets.Roboto,
    fontSize: size,
  );
}

TextStyle robotoNormalPrimaryDarkLineThroughStyle(double size) {
  return TextStyle(
    color: primaryDark,
    fontFamily: Assets.Roboto,
    decoration: TextDecoration.lineThrough,
    fontSize: size,
  );
}
