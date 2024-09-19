import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weather_fox/src/features/weather/presentation/weather_screen.dart';
import 'package:weather_fox/src/features/calendar/presentation/calendarscreen.dart';
import 'package:weather_fox/src/features/weather/presentation/settings_screen.dart';

import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

//part 'main.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeStr = await rootBundle.loadString('assets/appainter_theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  runApp(
    ProviderScope(
      child: WeatherFox(theme: theme),
    ),
  );
}

class WeatherFox extends ConsumerWidget {
  final ThemeData theme;

  const WeatherFox({super.key, required this.theme});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //int initDay = 0;
    //final config = ref.watch(weatherProvider);
    //final router = ref.watch(goRouterProvider);
    return MaterialApp(
      //routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: theme,
      initialRoute: '/weather',
      routes: {
        '/weather': (context) => const WeatherScreen(),
        '/settings': (context) => SettingsScreen(),
        '/calendar': (context) => const CalendarScreen(),
      },
    );
  }
}
