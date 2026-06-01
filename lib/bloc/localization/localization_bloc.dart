import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'localization_event.dart';
import 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  final SharedPreferences prefs;

  LocalizationBloc(this.prefs)
    : super(LocalizationState(locale: const Locale("en"))) {

      
    on<LoadLocalEvent>((event, emit) {
      final savedLocaleCode = prefs.getString("app_locale") ?? "en";

      emit(LocalizationState(locale: Locale(savedLocaleCode)));
    });

    on<ChangeLocaleEvent>((event, emit) async {
      final isCurrentlyEnglish = state.locale.languageCode == "en";

      final newLocaleCode = isCurrentlyEnglish ? "fa" : "en";

      await prefs.setString("app_locale", newLocaleCode);

      emit(LocalizationState(locale: Locale(newLocaleCode)));
    });
  }
}
