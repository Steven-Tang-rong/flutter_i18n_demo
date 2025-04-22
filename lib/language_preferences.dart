import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagePreferences {
  static const String _languageCodeKey = 'languageCode';

  // Save the selected language code
  static Future<void> setLanguageCode(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageCodeKey, languageCode);
  }

  // Get the saved language code
  static Future<String?> getLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageCodeKey);
  }

  // Get saved Locale or return null
  static Future<Locale?> getSavedLocale() async {
    final languageCode = await getLanguageCode();
    if (languageCode != null && languageCode.isNotEmpty) {
      return Locale(languageCode);
    }
    return null;
  }

  // Clear language preference
  static Future<void> clearLanguagePreference() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_languageCodeKey);
  }
}