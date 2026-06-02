import 'package:flutter/material.dart';
import 'package:flutter_authenticator/bloc/theme/theme_event.dart';
import 'package:flutter_authenticator/bloc/theme/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SharedPreferences preferences;

  ThemeBloc(this.preferences) : super(ThemeState(ThemeMode.system)) {
    //Load theme
    on<LoadThemeEvent>((event, emit) async {
      final isDark = preferences.getBool("darkMood") ?? false;
      emit(ThemeState(isDark ? ThemeMode.dark : ThemeMode.light));
    });

    //Switch Theme
    on<SwitchThemeEvent>((event, emit) async {
      final isCurrentlyDark = state.themeMode == ThemeMode.dark;
      final newTheme = isCurrentlyDark ? ThemeMode.light : ThemeMode.dark;
      await preferences.setBool('darkMood', !isCurrentlyDark);

      emit(ThemeState(newTheme));
    });
  }
}
