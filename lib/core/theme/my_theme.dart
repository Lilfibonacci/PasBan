import 'package:flutter/material.dart';
import 'package:flutter_authenticator/core/constants/my_colors.dart';

//light theme
final ThemeData lightTheme = ThemeData(
  //appBar theme
  appBarTheme: const AppBarTheme(
    backgroundColor: MyColors.white,
    centerTitle: true,
    foregroundColor: MyColors.black,
    iconTheme: IconThemeData(color: MyColors.black, size: 30),
    titleTextStyle: TextStyle(
      fontFamily: "Cr",
      fontSize: 24,
      color: MyColors.black,
    ),
  ),

  //scaffold color
  scaffoldBackgroundColor: MyColors.white,

  //light mode
  brightness: Brightness.light,

  //card theme
  cardTheme: const CardThemeData(color: MyColors.mistyRose, elevation: 1),

  //elevatedButton Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      iconColor: MyColors.white,
      iconSize: 22,
      foregroundColor: MyColors.white,
      textStyle: const TextStyle(fontFamily: "Cr", fontSize: 22),
      backgroundColor: MyColors.salmon,
      minimumSize: const Size(double.infinity, 50),
    ),
  ),

  //textTheme
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontFamily: "Cr", color: MyColors.black, fontSize: 32),
    bodyMedium: TextStyle(
      fontFamily: "Cr",
      color: MyColors.black,
      fontSize: 22,
    ),
  ),
);

//dark theme
final ThemeData darkTheme = ThemeData();
