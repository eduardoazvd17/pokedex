import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';

void main() {
  LocalJsonLocalization.delegate.directories = ['lib/i18n'];
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: _localizationsDelegates,
      supportedLocales: _supportedLocales,
      localeResolutionCallback: _localeResolutionCallback,
      home: const Scaffold(),
    );
  }

  Iterable<LocalizationsDelegate<dynamic>> get _localizationsDelegates => [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        LocalJsonLocalization.delegate,
      ];

  Iterable<Locale> get _supportedLocales => const [
        Locale('pt', 'BR'),
        Locale('es', 'ES'),
        Locale('en', 'US'),
      ];

  Locale? Function(Locale?, Iterable<Locale>) get _localeResolutionCallback =>
      (locale, supportedLocales) {
        if (supportedLocales.contains(locale)) {
          return locale;
        } else if (locale?.languageCode == 'pt') {
          return const Locale('pt', 'BR');
        } else if (locale?.languageCode == 'es') {
          return const Locale('es', 'ES');
        } else {
          return const Locale('en', 'US');
        }
      };
}
