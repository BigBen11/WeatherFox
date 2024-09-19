import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DarkModeController extends StateNotifier<bool> {
  DarkModeController(SharedPreferences prefs)
      : super(prefs.getBool('darkMode') ?? false);

  void toggle(SharedPreferences prefs) {
    state = !state;
    prefs.setBool('darkMode', state);
  }
}

class CelsiusFahrenheitController extends StateNotifier<bool> {
  CelsiusFahrenheitController(SharedPreferences prefs)
      : super(prefs.getBool('celsiusFahrenheit') ?? true);

  void toggle(SharedPreferences prefs) {
    state = !state;
    prefs.setBool('celsiusFahrenheit', state);
  }
}

class SpeedUnitController extends StateNotifier<bool> {
  SpeedUnitController(SharedPreferences prefs)
      : super(prefs.getBool('speedUnit') ?? true);

  void toggle(SharedPreferences prefs) {
    state = !state;
    prefs.setBool('speedUnit', state);
  }
}

class HumidityController extends StateNotifier<bool> {
  HumidityController(SharedPreferences prefs)
      : super(prefs.getBool('humidity') ?? true);

  void toggle(SharedPreferences prefs) {
    state = !state;
    prefs.setBool('humidity', state);
  }
}

class WindSpeedController extends StateNotifier<bool> {
  WindSpeedController(SharedPreferences prefs)
      : super(prefs.getBool('windSpeed') ?? true);

  void toggle(SharedPreferences prefs) {
    state = !state;
    prefs.setBool('windSpeed', state);
  }
}

class PrecipitationController extends StateNotifier<bool> {
  PrecipitationController(SharedPreferences prefs)
      : super(prefs.getBool('precipitation') ?? true);

  void toggle(SharedPreferences prefs) {
    state = !state;
    prefs.setBool('precipitation', state);
  }
}

class UvIndexController extends StateNotifier<bool> {
  UvIndexController(SharedPreferences prefs)
      : super(prefs.getBool('uvIndex') ?? true);

  void toggle(SharedPreferences prefs) {
    state = !state;
    prefs.setBool('uvIndex', state);
  }
}

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Sollte von der Hauptfunktion überschrieben werden');
});

final darkModeProvider = StateNotifierProvider<DarkModeController, bool>((ref) {
  return DarkModeController(ref.watch(sharedPreferencesProvider));
});

final celsiusFahrenheitProvider =
    StateNotifierProvider<CelsiusFahrenheitController, bool>(
  (ref) => CelsiusFahrenheitController(ref.watch(sharedPreferencesProvider)),
);

final speedUnitProvider = StateNotifierProvider<SpeedUnitController, bool>(
  (ref) => SpeedUnitController(ref.watch(sharedPreferencesProvider)),
);

final humidityProvider = StateNotifierProvider<HumidityController, bool>(
  (ref) => HumidityController(ref.watch(sharedPreferencesProvider)),
);

final windSpeedProvider = StateNotifierProvider<WindSpeedController, bool>(
  (ref) => WindSpeedController(ref.watch(sharedPreferencesProvider)),
);

final precipitationProvider =
    StateNotifierProvider<PrecipitationController, bool>(
  (ref) => PrecipitationController(ref.watch(sharedPreferencesProvider)),
);

final uvIndexProvider = StateNotifierProvider<UvIndexController, bool>(
  (ref) => UvIndexController(ref.watch(sharedPreferencesProvider)),
);

class SettingsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: ListView(
        children: <Widget>[
          Consumer(
            builder: (context, ref, child) {
              final darkMode = ref.watch(darkModeProvider.notifier);
              return SwitchListTile(
                title: Text('Dark Mode'),
                value: darkMode.state,
                onChanged: (bool value) {
                  ref
                      .read(darkModeProvider.notifier)
                      .toggle(ref.read(sharedPreferencesProvider));
                },
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text('Einheiten'),
          ),
          Consumer(
            builder: (context, ref, child) {
              final celsiusFahrenheit =
                  ref.watch(celsiusFahrenheitProvider.notifier);
              return SwitchListTile(
                title: Text('Celsius/Fahrenheit'),
                value: celsiusFahrenheit.state,
                onChanged: (bool value) {
                  ref
                      .read(celsiusFahrenheitProvider.notifier)
                      .toggle(ref.read(sharedPreferencesProvider));
                },
              );
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              final speedUnit = ref.watch(speedUnitProvider.notifier);
              return SwitchListTile(
                title: Text('km/h/Mp/h'),
                value: speedUnit.state,
                onChanged: (bool value) {
                  ref
                      .read(speedUnitProvider.notifier)
                      .toggle(ref.read(sharedPreferencesProvider));
                },
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text('Metriken'),
          ),
          Consumer(
            builder: (context, ref, child) {
              final humidity = ref.watch(humidityProvider.notifier);
              return SwitchListTile(
                title: Text('Luftfeuchtigkeit'),
                value: humidity.state,
                onChanged: (bool value) {
                  ref
                      .read(humidityProvider.notifier)
                      .toggle(ref.read(sharedPreferencesProvider));
                },
              );
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              final windSpeed = ref.watch(windSpeedProvider.notifier);
              return SwitchListTile(
                title: Text('Windgeschwindigkeit'),
                value: windSpeed.state,
                onChanged: (bool value) {
                  ref
                      .read(windSpeedProvider.notifier)
                      .toggle(ref.read(sharedPreferencesProvider));
                },
              );
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              final precipitation = ref.watch(precipitationProvider.notifier);
              return SwitchListTile(
                title: Text('Niederschlag'),
                value: precipitation.state,
                onChanged: (bool value) {
                  ref
                      .read(precipitationProvider.notifier)
                      .toggle(ref.read(sharedPreferencesProvider));
                },
              );
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              final uvIndex = ref.watch(uvIndexProvider.notifier);
              return SwitchListTile(
                title: Text('UV-Index'),
                value: uvIndex.state,
                onChanged: (bool value) {
                  ref
                      .read(uvIndexProvider.notifier)
                      .toggle(ref.read(sharedPreferencesProvider));
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
