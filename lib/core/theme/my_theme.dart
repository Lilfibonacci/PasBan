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

  //elevatedButton Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      iconColor: MyColors.white,
      iconSize: 22,
      foregroundColor: MyColors.white,
      textStyle: const TextStyle(fontFamily: "Cr", fontSize: 22),
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

  //Drawer Theme
  drawerTheme: const DrawerThemeData(
    backgroundColor: MyColors.white,
    elevation: 2,
    width: 280,
  ),
);

//dark theme
final ThemeData darkTheme = ThemeData(
  //appBar theme
  appBarTheme: const AppBarTheme(
    backgroundColor: MyColors.black,
    centerTitle: true,
    foregroundColor: MyColors.white,
    iconTheme: IconThemeData(color: MyColors.white, size: 30),
    titleTextStyle: TextStyle(
      fontFamily: "Cr",
      fontSize: 24,
      color: MyColors.white,
    ),
  ),

  //scaffold color
  scaffoldBackgroundColor: MyColors.black,

  //Dark mode
  brightness: Brightness.dark,

  //elevatedButton Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      iconColor: MyColors.white,
      iconSize: 22,
      foregroundColor: MyColors.white,
      textStyle: const TextStyle(fontFamily: "Cr", fontSize: 22),
      minimumSize: const Size(double.infinity, 50),
    ),
  ),

  //textTheme
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontFamily: "Cr", color: MyColors.white, fontSize: 32),
    bodyMedium: TextStyle(
      fontFamily: "Cr",
      color: MyColors.white,
      fontSize: 22,
    ),
  ),

  //Drawer Theme
  drawerTheme: const DrawerThemeData(
    backgroundColor: MyColors.black,
    elevation: 2,
    width: 280,
  ),
);
