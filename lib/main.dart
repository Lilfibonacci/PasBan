import 'package:flutter/material.dart';
import 'package:flutter_authenticator/bloc/theme/theme_bloc.dart';
import 'package:flutter_authenticator/bloc/theme/theme_state.dart';
import 'package:flutter_authenticator/core/di/di.dart';
import 'package:flutter_authenticator/core/routing/routing.dart';
import 'package:flutter_authenticator/core/theme/my_theme.dart';
import 'package:flutter_authenticator/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await getItInit();

  runApp(
    BlocProvider<ThemeBloc>(
      create: (context) => ThemeBloc(locator.get()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) => MaterialApp.router(
        localizationsDelegates: AppLocalizations.localizationsDelegates,

        supportedLocales: AppLocalizations.supportedLocales,

        locale: const Locale('fa'),

        debugShowCheckedModeBanner: false,
        title: "PasBan",
        routerConfig: appGlobalRouter,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: state.themeMode,
      ),
    );
  }
}
