import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';
import 'package:pokedex/features/home_page/data/bindings/home_page_binding.dart';
import 'package:pokedex/features/home_page/presentation/pages/home_page.dart';
import 'package:get/get.dart';

import 'core/data/utils/custom_app_themes.dart';

void main() {
  LocalJsonLocalization.delegate.directories = ['lib/i18n'];
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pokedex',
      theme: CustomAppThemes.lightTheme,
      localizationsDelegates: _localizationsDelegates,
      supportedLocales: _supportedLocales,
      localeResolutionCallback: _localeResolutionCallback,
      getPages: [
        GetPage(
          name: '/',
          page: () => const HomePage(),
          binding: HomePageBinding(),
        ),
      ],
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
