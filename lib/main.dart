import 'package:flutter/material.dart';
import 'package:flutter_authenticator/bloc/localization/localization_bloc.dart';
import 'package:flutter_authenticator/bloc/localization/localization_event.dart';
import 'package:flutter_authenticator/bloc/localization/localization_state.dart';
import 'package:flutter_authenticator/bloc/theme/theme_bloc.dart';
import 'package:flutter_authenticator/bloc/theme/theme_event.dart';
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
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(locator.get())..add(LoadThemeEvent()),
        ),
        BlocProvider(
          create: (context) =>
              LocalizationBloc(locator.get())..add(LoadLocalEvent()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<LocalizationBloc, LocalizationState>(
          builder: (context, localizationState) {
            return MaterialApp.router(
              localizationsDelegates: AppLocalizations.localizationsDelegates,

              supportedLocales: AppLocalizations.supportedLocales,

              locale: localizationState.locale,

              debugShowCheckedModeBanner: false,
              title: "PasBan",
              routerConfig: appGlobalRouter,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeState.themeMode,
            );
          },
        );
      },
    );
  }
}
