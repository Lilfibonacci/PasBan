import 'package:flutter_authenticator/screen/about_screen.dart';
import 'package:flutter_authenticator/screen/home_screen.dart';
import 'package:flutter_authenticator/screen/loading_screen.dart';
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
  ],
);
