import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:localization/localization.dart';

import 'src/core/data/utils/app_theme.dart';
import 'src/modules/app_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalJsonLocalization.delegate.directories = ['lib/i18n'];
  await Hive.initFlutter();
  runApp(ModularApp(module: AppModule(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Pokedex',
      theme: AppTheme.lightTheme,
      localizationsDelegates: _localizationsDelegates,
      supportedLocales: _supportedLocales,
      localeResolutionCallback: _localeResolutionCallback,
      routerConfig: Modular.routerConfig,
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
