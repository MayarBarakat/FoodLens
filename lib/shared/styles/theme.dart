import 'package:FeedLens/shared/styles/colors.dart';
import 'package:flutter/material.dart';

import '../components/constants.dart';

ThemeData theme() {
  return ThemeData(
    // inputDecorationTheme: buildInputDecorationTheme(),
    appBarTheme: buildAppBarTheme(),
    fontFamily: "Cairo",
    scaffoldBackgroundColor: backgroundColor,
    textTheme: buildTextTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

TextTheme buildTextTheme() {
  return const TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

AppBarTheme buildAppBarTheme() {
  return AppBarTheme(
      iconTheme: buildIconThemeData(),
      color: defaultColor,
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
      ),
      textTheme: const TextTheme(),
      elevation: 0,
      centerTitle: true,
      brightness: Brightness.light
  );
}

IconThemeData buildIconThemeData() {
  return const IconThemeData(
    color: Colors.black,
  );
}

InputDecorationTheme buildInputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: kTextColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
    alignLabelWithHint: true,
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}