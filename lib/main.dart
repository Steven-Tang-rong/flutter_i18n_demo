import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_i18n_demo/l10n/l10n.dart';
import 'package:flutter_i18n_demo/language_preferences.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   Locale? _locale;

  // void setLocale(Locale locale) {
  //   if (!AppLocalizations.supportedLocales.contains(locale)) return;

  //   setState(() {
  //     _locale = locale;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _loadSavedLanguage();
  }
  
  // Load saved language preference when app starts
  Future<void> _loadSavedLanguage() async {
    final savedLocale = await LanguagePreferences.getSavedLocale();
    if (savedLocale != null) {
      setState(() {
        _locale = savedLocale;
      });
    }
  }

  // Set locale and save preference
  void setLocale(Locale locale) async {
    setState(() => _locale = locale);
    await LanguagePreferences.setLanguageCode(locale.languageCode);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter I18n Demo',
      locale: _locale,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.language,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: const [
        Locale('en'),
        Locale('zh'),
        Locale('ja'),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(setLocale: setLocale),
    );
  }
}


