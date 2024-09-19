import 'package:flutter/material.dart';
//import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weather_fox/src/features/weather/domain/weather.dart';
import 'package:weather_fox/src/features/calendar/data/events_data.dart';
import 'package:calendar_view/calendar_view.dart';

bool areThereWarnings(Weather weather, int day) {
  if (weather.forecast.forecastday[day].day.daily_will_it_rain) {
    return true;
  }
  if (weather.forecast.forecastday[day].day.daily_will_it_snow) {
    return true;
  }
  return false;
}

Future<List<String>> getTodayMessage(
    Weather weather, int day, BuildContext context) async {
  List<String> message = [];
  if (areThereWarnings(weather, day)) {
    if (weather.forecast.forecastday[day].day.daily_will_it_rain) {
      message.add(AppLocalizations.of(context)!.rain_warning);
    }
    if (weather.forecast.forecastday[day].day.daily_will_it_snow) {
      message.add(AppLocalizations.of(context)!.snow_warning);
    }
  }
  for (int i = message.length; i < 2; i++) {
    //list 2 lang machen
    message.add("");
  }
  Future<List<CalendarEventData<Object?>>> events =
      getEventofDay(DateTime.parse(weather.forecast.forecastday[day].date));
  List<CalendarEventData<Object?>> result = await events;

  if (result.isEmpty) {
    // 3 wichtig
    // ignore: use_build_context_synchronously
    message.add(AppLocalizations.of(context)!.today_noplans);
    return message;
  } else {
    String allEvents = "";
    // ignore: use_build_context_synchronously
    message.add(AppLocalizations.of(context)!.todays_plans);
    for (int i = 0; i < result.length; i++) {
      allEvents += "- ${result[i].title}\n";
    }
    message.add(allEvents); // 4+ klein
  }

  return message;
}

List<Widget> checkWeatherCondition(
    {required DateTime time,
    required Weather weather,
    required int day,
    required String way,
    required BuildContext context,
    required BoxConstraints constraints}) {
  IconData? resultIcon;
  List<Widget> result = [];
  String message = "";
  if (weather.forecast.forecastday[day].hour[time.hour].will_it_rain) {
    message += "- ${AppLocalizations.of(context)!.rain_check(way)}\n";
    resultIcon = Icons.warning;
  }
  if (weather.forecast.forecastday[day].hour[time.hour].will_it_snow) {
    message += "- ${AppLocalizations.of(context)!.snow_check(way)}\n";
    resultIcon = Icons.warning;
  }
  if (weather.forecast.forecastday[day].hour[time.hour].wind_kph > 39) {
    message += "- ${AppLocalizations.of(context)!.wind_check(way)}\n";
    resultIcon = Icons.warning;
  }
  if (weather.forecast.forecastday[day].hour[time.hour].feelslike_c < -8) {
    message += "- ${AppLocalizations.of(context)!.cold_check(way)}\n";
    resultIcon = Icons.warning;
  }
  if (weather.forecast.forecastday[day].hour[time.hour].feelslike_c > 30) {
    message += "- ${AppLocalizations.of(context)!.heat_check(way)}\n";
    resultIcon = Icons.warning;
  }
  resultIcon ??= Icons.check;

  result.add(Icon(resultIcon));
  result.add(Text(message));
  return result;
}
