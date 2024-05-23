import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expence_tracker/themes/dark_mode.dart';
import 'package:flutter/material.dart';

import '../repository/preference_repository.dart';
import '../themes/light_mode.dart';

part 'app_appearance_state.dart';

class AppAppearanceCubit extends Cubit<AppAppearanceState> {

  AppAppearanceCubit(ThemeData themeData, Locale locale)
      : super(AppAppearanceState(themeData, locale));




  // Load the selected theme from SharedPreferences
  static Locale loadSelectedLang(String locale) {
    return Locale(locale);
  }

  static String languageName(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'ml':
        return 'Malayalam';
      default:
        return 'English';
    }
  }

  Locale selectedLocale() {
    return state.locale;
  }

  // change theme
  void changeTheme() {
    emit(AppAppearanceState(
        state.themeData.brightness == Brightness.dark ? lightMode : darkMode,
        state.locale));
  }

  bool isDarkTheme() {
    return state.themeData.brightness == Brightness.dark;
  }

  // Load the selected theme from SharedPreferences
  static ThemeData loadSelectedTheme(String themeName) {
    if (themeName == 'dark') {
      return darkMode;
    } else {
      return lightMode;
    }
  }

  static AppAppearanceState loadAppearance(PreferencesRepository preferencesRepository) {
    final selectedTheme = loadSelectedTheme(preferencesRepository.getSelectedTheme());
    final selectedLang = loadSelectedLang(preferencesRepository.getSelectedLanguage());
    return AppAppearanceState(selectedTheme, selectedLang);
  }




}
