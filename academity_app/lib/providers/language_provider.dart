import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final languageProvider = StateNotifierProvider<LanguageProvider, Locale>((ref) {
  return LanguageProvider();
});

class LanguageProvider extends StateNotifier<Locale> {
  LanguageProvider() : super(const Locale('en'));

  void switchLanguage(String languageCode) {
      debugPrint("Switching language to $languageCode");

    state = Locale(languageCode);
  }
}
