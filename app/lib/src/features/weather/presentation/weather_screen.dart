import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weather_fox/src/features/weather/data/weather_data.dart';
import 'package:weather_fox/src/features/weather/domain/hour.dart';
import 'package:weather_fox/src/features/weather/domain/weather.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:intl/intl.dart';
import 'package:weather_fox/src/features/weather/data/warning_logic.dart';
import 'package:weather_fox/src/features/calendar/data/events_data.dart';

import 'dart:developer';

final dayProvider = StateProvider<int>((ref) => 0);

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(countryProvider.notifier).state =
        Localizations.localeOf(context).countryCode ?? 'de';
    final weather = ref.watch(weatherProvider);

    return SafeArea(child: LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxHeight < constraints.maxWidth) {
          return const Text('Horizontal');
        } else {
          return _VerticalLayout(
            weather: weather,
          );
        }
      },
    ));
  }
}

class _VerticalLayout extends ConsumerWidget {
  final AsyncValue<Weather> weather;

  const _VerticalLayout({required this.weather});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              weather.when(
                error: (err, stack) => Text('Error: $err'),
                loading: () => const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: CircularProgressIndicator(),
                ),
                data: (weather) => _AsynchAutocomplete(weather: weather),
              ),
              weather.when(
                error: (err, stack) => Text('Error: $err'),
                loading: () => const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: CircularProgressIndicator(),
                ),
                data: (weather) => _Temperature(weather: weather),
              ),
              weather.when(
                error: (err, stack) => Text('Error: $err'),
                loading: () => const CircularProgressIndicator(),
                data: (weather) => _StatusInfo(weather: weather),
              ),
              weather.when(
                error: (err, stack) => Text('Error: $err'),
                loading: () => const CircularProgressIndicator(),
                data: (weather) => _HorizontalHourView(weather: weather),
              ),
              weather.when(
                error: (err, stack) => Text('Error: $err'),
                loading: () => const CircularProgressIndicator(),
                data: (weather) => _DayNotifications(weather: weather),
              ),
              weather.when(
                error: (err, stack) => Text('Error: $err'),
                loading: () => const CircularProgressIndicator(),
                data: (weather) => _DetailedParameters(weather: weather),
              ),
              IconButton.filled(
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                  icon: const Icon(Icons.settings))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: () {
          Navigator.pushNamed(context, '/calendar');
        },
        tooltip: AppLocalizations.of(context)!.calendar,
        child: Icon(
          Icons.calendar_month,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }
}

class _Temperature extends ConsumerWidget {
  const _Temperature({required this.weather});
  final Weather weather;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final day = ref.watch(dayProvider);
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 4),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20.0),
        ),
        height: MediaQuery.of(context).size.height / 2.3,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            _MainTemperature(weather: weather),
            if (day != 2) _NextDayPreview(weather: weather),
          ],
        ),
      ),
    );
  }
}

class _MainTemperature extends ConsumerWidget {
  const _MainTemperature({
    //super.key,
    required this.weather,
  });

  final Weather weather;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final day = ref.watch(dayProvider);
    if (day == 0) {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double fontSize = constraints.maxHeight / 4;
          double fontSizeDesc = constraints.maxHeight / 10;
          return Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: Icon(
                    getWeatherIcon(
                      weather.current.condition.code,
                      weather.current.is_day,
                    ),
                    size: constraints.maxHeight / 3,
                  ),
                ),
                Text(
                  '${weather.current.temp_c}°C',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    letterSpacing: -5,
                  ),
                ),
                Text(
                  weather.current.condition.text,
                  style: TextStyle(
                    fontSize: fontSizeDesc,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal,
                    letterSpacing: -1.0,
                  ),
                ),
                Text(AppLocalizations.of(context)!.date(
                    DateTime.parse(weather.forecast.forecastday[day].date)))
              ],
            ),
          );
        },
      );
    } else {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double fontSize = constraints.maxHeight / 4;
          double fontSizeDesc = constraints.maxHeight / 10;
          return Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: Icon(
                    getWeatherIcon(
                      weather.forecast.forecastday[day].day.condition.code,
                      1,
                    ),
                    size: constraints.maxHeight / 3,
                  ),
                ),
                Text(
                  '${weather.forecast.forecastday[day].day.avgtemp_c}°C',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    letterSpacing: -5,
                  ),
                ),
                Text(
                  weather.forecast.forecastday[day].day.condition.text,
                  style: TextStyle(
                    fontSize: fontSizeDesc,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal,
                    letterSpacing: -1.0,
                  ),
                ),
                Text(AppLocalizations.of(context)!.date(
                    DateTime.parse(weather.forecast.forecastday[day].date)))
              ],
            ),
          );
        },
      );
    }
  }
}

class _NextDayPreview extends ConsumerWidget {
  const _NextDayPreview({
    //super.key,
    required this.weather,
  });
  final Weather weather;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int day = ref.watch(dayProvider);
    return Positioned(
      width: 120,
      height: 120,
      bottom: 0,
      right: 0,
      child: Container(
        color: Theme.of(context).colorScheme.onSecondaryContainer,
        child: TextButton(
          onPressed: () {
            
            if (day < 3) {
              log('tomorrow clicked');
              day++;
              ref.read(dayProvider.notifier).state = day;
            }
          },
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '${AppLocalizations.of(context)!.tomorrow}: ${AppLocalizations.of(context)!.date(DateTime.parse(weather.forecast.forecastday[day + 1].date))}',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Icon(
                      getWeatherIcon(
                        weather
                            .forecast.forecastday[day + 1].day.condition.code,
                        1,
                      ),
                      color: Theme.of(context).colorScheme.onSecondary,
                      size: constraints.maxHeight / 3,
                    ),
                  ),
                  Text(
                    '${weather.forecast.forecastday[day + 1].day.maxtemp_c}/${weather.forecast.forecastday[day + 1].day.mintemp_c}',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _HorizontalHourView extends ConsumerWidget {
  const _HorizontalHourView({
    //super.key,
    required this.weather,
  });
  final Weather weather;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final day = ref.watch(dayProvider);
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weather.forecast.forecastday[day].hour.length,
        itemBuilder: (context, i) =>
            _HourItem(hour: weather.forecast.forecastday[day].hour[i]),
      ),
    );
  }
}

class _HourItem extends ConsumerWidget {
  const _HourItem({
    //super.key,
    required this.hour,
  });
  final Hour hour;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime dateTime = DateTime.parse(hour.time);
    String time =
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";

    int isDay = hour.is_day ? 1 : 0;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                time,
                style: TextStyle(
                    fontSize: constraints.maxHeight / 6,
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Icon(
                  getWeatherIcon(
                    hour.condition.code,
                    isDay,
                  ),
                  size: constraints.maxHeight / 3,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  hour.temp_c.toString(),
                  style: TextStyle(
                      fontSize: constraints.maxHeight / 7,
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _AsynchAutocomplete extends ConsumerStatefulWidget {
  const _AsynchAutocomplete({
    //super.key,
    required this.weather,
  });
  final Weather weather;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __AsynchAutocompleteState();
}

class __AsynchAutocompleteState extends ConsumerState<_AsynchAutocomplete> {
  List<String> locations = [
    "Frankfurt",
    "Berlin",
    "Hamburg",
    "München",
    "Köln",
    "Stuttgart",
    "Düsseldorf",
    "Dortmund",
    "Essen",
    "Leipzig",
    "Bremen",
    "Dresden",
    "Hannover",
    "Nürnberg",
    "Duisburg",
    "Bochum",
    "Wuppertal",
    "Bielefeld",
    "Bonn",
    "Münster",
    "Paris",
    "London",
    "Rom",
    "Madrid",
    "Barcelona",
    "Amsterdam",
    "Prag",
    "Wien",
    "Dublin",
    "Brüssel",
    "Lissabon",
    "Warschau",
    "Budapest",
    "Kopenhagen",
    "Athen",
    "Stockholm",
    "Oslo",
    "Helsinki",
    "Istanbul",
    "Moskau",
    "Tokio"
  ];
  @override
  Widget build(BuildContext context) {
    int day = ref.watch(dayProvider);
    return Row(
      children: [
        if (day != 0)
          IconButton(
            onPressed: () {
              log('today clicked');
              day--;
              ref.read(dayProvider.notifier).state = day;
            },
            icon: const Icon(Icons.arrow_back),
          ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
            child: Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable.empty();
                }
                return locations.where((String option) {
                  return option.contains(textEditingValue.text);
                });
              },
              initialValue: TextEditingValue(
                  text:
                      "${widget.weather.location.name} - ${widget.weather.location.region}"),
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusInfo extends ConsumerWidget {
  const _StatusInfo({required this.weather});
  final Weather weather;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateFormat format = DateFormat("yyyy-MM-dd H:m");
    DateTime zeit = format.parse(weather.location.localtime);
    return Center(
      child: Column(
        children: <Widget>[
          Text(AppLocalizations.of(context)!.lastUpdate(zeit, zeit))
        ],
      ),
    );
  }
}

class _DetailedParameters extends ConsumerWidget {
  const _DetailedParameters({
    //super.key,
    required this.weather,
  });
  final Weather weather;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final day = ref.watch(dayProvider);
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 15,
      children: <Widget>[
        if (true)
          _DetailCard(
              attribut: AppLocalizations.of(context)!.mintemp("°C"),
              detailIcon: WeatherIcons.thermometer,
              detailData:
                  weather.forecast.forecastday[day].day.mintemp_c.toString()),
        if (true)
          _DetailCard(
              attribut: AppLocalizations.of(context)!.maxtemp("°C"),
              detailIcon: WeatherIcons.thermometer,
              detailData:
                  weather.forecast.forecastday[day].day.maxtemp_c.toString()),
        if (true)
          _DetailCard(
              attribut: AppLocalizations.of(context)!.avgtemp("°C"),
              detailIcon: WeatherIcons.thermometer,
              detailData:
                  weather.forecast.forecastday[day].day.avgtemp_c.toString()),
        if (true)
          _DetailCard(
              attribut: AppLocalizations.of(context)!.maxwind("km/h"),
              detailIcon: WeatherIcons.wind,
              detailData:
                  weather.forecast.forecastday[day].day.maxwind_kph.toString()),
        if (true)
          _DetailCard(
              attribut: AppLocalizations.of(context)!.percip("mm"),
              detailIcon: WeatherIcons.raindrops,
              detailData: weather.forecast.forecastday[day].day.totalprecip_mm
                  .toString()),
        if (true)
          _DetailCard(
              attribut: AppLocalizations.of(context)!.snow("mm"),
              detailIcon: WeatherIcons.snowflake_cold,
              detailData: weather.forecast.forecastday[day].day.totalsnow_cm
                  .toString()),
        if (true)
          _DetailCard(
              attribut: AppLocalizations.of(context)!.visibility("km"),
              detailIcon: Icons.remove_red_eye,
              detailData:
                  weather.forecast.forecastday[day].day.avgvis_km.toString()),
        if (true)
          _DetailCard(
              attribut: AppLocalizations.of(context)!.humidity,
              detailIcon: WeatherIcons.fog,
              detailData:
                  weather.forecast.forecastday[day].day.avghumidity.toString()),
        if (true)
          _DetailCard(
              attribut: AppLocalizations.of(context)!.uv,
              detailIcon: WeatherIcons.day_sunny,
              detailData: weather.forecast.forecastday[day].day.uv.toString()),
        if (true)
          _DetailCard(
              attribut: AppLocalizations.of(context)!.sunrise,
              detailIcon: WeatherIcons.day_sunny,
              detailData: AppLocalizations.of(context)!.time(stringToDate(
                  weather.forecast.forecastday[day].astro.sunrise))),
        if (true)
          _DetailCard(
              attribut: AppLocalizations.of(context)!.sunset,
              detailIcon: WeatherIcons.sunset,
              detailData: AppLocalizations.of(context)!.time(stringToDate(
                  weather.forecast.forecastday[day].astro.sunset))),
        if (true)
          _DetailCard(
              attribut: AppLocalizations.of(context)!.moonrise,
              detailIcon: WeatherIcons.moon_full,
              detailData: AppLocalizations.of(context)!.time(stringToDate(
                  weather.forecast.forecastday[day].astro.moonrise))),
        if (true)
          _DetailCard(
              attribut: AppLocalizations.of(context)!.moonset,
              detailIcon: WeatherIcons.moon_new,
              detailData: AppLocalizations.of(context)!.time(stringToDate(
                  weather.forecast.forecastday[day].astro.moonset))),
      ],
    );
  }
}

DateTime stringToDate(String str) {
  final format = DateFormat.jm();
  return format.parse(str);
}

class _DetailCard extends ConsumerWidget {
  const _DetailCard(
      { //super.key,
      required this.attribut,
      required this.detailIcon,
      required this.detailData});
  final String attribut;
  final IconData detailIcon;
  final String detailData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: SizedBox(
            child: Column(
              children: <Widget>[
                Text(
                  '$attribut:',
                  style: TextStyle(fontSize: constraints.maxHeight / 15),
                ),
                Center(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                        child: Icon(
                          detailIcon,
                          size: constraints.maxHeight / 3,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          detailData,
                          style:
                              TextStyle(fontSize: constraints.maxHeight / 10),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DayNotifications extends ConsumerWidget {
  const _DayNotifications({
    //super.key,
    required this.weather,
  });
  final Weather weather;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Padding(
          padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
          child: Container(
            height: 380,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Warnings(weather: weather),
          ));
    });
  }
}

Future<List<String>> fetchMessage(
    Weather weather, int day, BuildContext context) async {
  return getTodayMessage(weather, day, context);
}

Future<DateTime?> fetchWayTo(DateTime today) async {
  return await getStartTimeOfFirstEvent(today);
}

Future<DateTime?> fetchWayBack(DateTime today) async {
  return await getEndTimeOfLastEvent(today);
}

class Warnings extends ConsumerWidget {
  const Warnings({super.key, required this.weather});
  final Weather weather;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final day = ref.watch(dayProvider);
    bool isWarning = areThereWarnings(weather, day);

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return FutureBuilder<List<String>>(
        future: fetchMessage(weather, day, context),
        builder: (BuildContext context, AsyncSnapshot<List<String>> message) {
          if (message.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            List<String> result = message.data!;
            return Column(
              children: [
                Row(
                  children: <Widget>[
                    if (isWarning == true)
                      Icon(
                        Icons.warning,
                        size: constraints.maxWidth / 4,
                      ),
                    Column(
                        children: result.asMap().entries.map((entry) {
                      int idx = entry.key;
                      String val = entry.value;

                      if (idx < 2 && val != "") {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Text(val,
                              style: const TextStyle(
                                fontSize: 30,
                              )),
                        );
                      } else if (idx == 2) {
                        return Text(val, style: const TextStyle(fontSize: 18));
                      } else {
                        return Text(val, style: const TextStyle(fontSize: 15));
                      }
                    }).toList()),
                    if (isWarning == false)
                      Icon(
                        Icons.check,
                        size: constraints.maxHeight / 4,
                      ),
                  ],
                ),
                if (result.length > 3)
                  Row(
                    children: [
                      FutureBuilder<Card>(
                        future: _wayToCard(context, constraints, day),
                        builder: (BuildContext context,
                            AsyncSnapshot<Card> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return snapshot.data ?? Container(); // your Card
                            }
                          }
                        },
                      ),
                      FutureBuilder<Card>(
                        future: _wayBackCard(context, constraints, day),
                        builder: (BuildContext context,
                            AsyncSnapshot<Card> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return snapshot.data ?? Container(); // your Card
                            }
                          }
                        },
                      ),
                    ],
                  )
              ],
            );
          }
        },
      );
    });
  }

  Future<Card> _wayToCard(
      BuildContext context, BoxConstraints constraints, int day) async {
    DateTime? timeoffirst = await fetchWayTo(
        DateTime.parse(weather.forecast.forecastday[day].date));
    return Card(
      // ignore: use_build_context_synchronously
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: SizedBox(
        height: constraints.maxHeight / 2.9,
        width: constraints.maxWidth / 2.2,
        child: Column(
          children: <Widget>[
            // ignore: use_build_context_synchronously
            Text("${AppLocalizations.of(context)!.way_to}:"),
            if (timeoffirst != null)
              // ignore: use_build_context_synchronously
              ...checkWeatherCondition(
                  constraints: constraints,
                  weather: weather,
                  day: day,
                  time: timeoffirst,
                  // ignore: use_build_context_synchronously
                  way: AppLocalizations.of(context)!.way_to,
                  context: context),
          ],
        ),
      ),
    );
  }

  Future<Card> _wayBackCard(
      BuildContext context, BoxConstraints constraints, int day) async {
    DateTime? timeoflast = await fetchWayTo(
        DateTime.parse(weather.forecast.forecastday[day].date));
    return Card(
      // ignore: use_build_context_synchronously
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: SizedBox(
        height: constraints.maxHeight / 2.5,
        width: constraints.maxWidth / 2.2,
        child: Column(
          children: <Widget>[
            // ignore: use_build_context_synchronously
            Text("${AppLocalizations.of(context)!.way_back}:"),
            if (timeoflast != null)
              // ignore: use_build_context_synchronously
              ...checkWeatherCondition(
                  constraints: constraints,
                  weather: weather,
                  day: day,
                  time: timeoflast,
                  // ignore: use_build_context_synchronously
                  way: AppLocalizations.of(context)!.way_back,
                  context: context),
          ],
        ),
      ),
    );
  }
}
