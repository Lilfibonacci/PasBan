import 'package:flutter/material.dart';
import 'package:flutter_authenticator/core/routing/routing.dart';
import 'package:flutter_authenticator/core/theme/my_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "PasBan",
      routerConfig: appGlobalRouter,
      theme: lightTheme,
    );
  }
}
