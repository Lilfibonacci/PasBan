import 'package:flutter_authenticator/ui/screen/about_screen.dart';
import 'package:flutter_authenticator/ui/screen/home_screen.dart';
import 'package:flutter_authenticator/ui/screen/loading_screen.dart';
import 'package:flutter_authenticator/ui/screen/scanner_screen.dart';
import 'package:flutter_authenticator/ui/screen/setup_key_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appGlobalRouter = GoRouter(
  initialLocation: "/",
  debugLogDiagnostics: true,
  routes: [
    //LoadingScreen
    GoRoute(
      name: LoadingScreen.routeName,
      path: "/",
      builder: (context, state) => const LoadingScreen(),
    ),

    //homeScreen
    GoRoute(
      name: HomeScreen.routeName,
      path: "/HomeScreen",
      builder: (context, state) => const HomeScreen(),
    ),

    //AboutScreen
    GoRoute(
      name: AboutScreen.routeName,
      path: "/AboutScreen",
      builder: (context, state) => const AboutScreen(),
    ),

    //ScannerScreen
    GoRoute(
      path: "/ScannerScreen",
      name: ScannerScreen.routeName,
      builder: (context, state) => const ScannerScreen(),
    ),

    //setupScreen
    GoRoute(
      path: "/setupScreen",
      name: SetupScreen.routeName,
      builder: (context, state) => const SetupScreen(),
    ),
  ],
);
