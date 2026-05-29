import 'package:flutter/material.dart';
import 'package:flutter_authenticator/screen/home_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  static String get routeName => "/LoadingScreen";

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    if (context.mounted) {
      Future.delayed(const Duration(seconds: 3), () {
        context.goNamed(HomeScreen.routeName);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [SpinKitFoldingCube(color: Colors.blueGrey, size: 50.0)],
        ),
      ),
    );
  }
}
