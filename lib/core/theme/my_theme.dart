import 'package:flutter/material.dart';
import 'package:flutter_authenticator/core/constants/my_colors.dart';

// --- Light Theme ---
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: MyColors.white,

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

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      iconColor: MyColors.white,
      iconSize: 22,
      foregroundColor: MyColors.white,
      textStyle: const TextStyle(fontFamily: "Cr", fontSize: 22),
      minimumSize: const Size(double.infinity, 50),
    ),
  ),

  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontFamily: "Cr", color: MyColors.black, fontSize: 32),
    bodyMedium: TextStyle(
      fontFamily: "Cr",
      color: MyColors.black,
      fontSize: 22,
    ),
  ),

  drawerTheme: const DrawerThemeData(
    backgroundColor: MyColors.white,
    elevation: 2,
    width: 280,
  ),
);

// --- Dark Theme ---
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: MyColors.black,

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

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      iconColor: MyColors.white,
      iconSize: 22,
      foregroundColor: MyColors.white,
      textStyle: const TextStyle(fontFamily: "Cr", fontSize: 22),
      minimumSize: const Size(double.infinity, 50),
    ),
  ),

  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontFamily: "Cr", color: MyColors.white, fontSize: 32),
    bodyMedium: TextStyle(
      fontFamily: "Cr",
      color: MyColors.white,
      fontSize: 22,
    ),
  ),

  drawerTheme: const DrawerThemeData(
    backgroundColor: MyColors.black,
    elevation: 2,
    width: 280,
  ),
);
