//import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
//import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:weather_fox/src/features/weather/domain/weather.dart';
import 'package:weather_icons/weather_icons.dart';
import 'location_data.dart';
//import 'package:get/get.dart';

const String apiKey = 'c4a9c5dde4msh0cf112419cace8ep107766jsne79434b9e29b';
const String apiHost = 'weatherapi-com.p.rapidapi.com';

final weatherProvider = FutureProvider<Weather>((ref) async {
  Position position;
  try {
    position = await determinePosition();
  } catch (e) {
    position = Position(
        longitude: 0,
        latitude: 0,
        timestamp: DateTime(1970),
        accuracy: 0,
        altitude: 0,
        altitudeAccuracy: 0,
        heading: 0,
        headingAccuracy: 0,
        speed: 0,
        speedAccuracy: 0);
  }

  double mylatitude = position.latitude;
  double mylongitude = position.longitude;

  String country = ref.read(countryProvider);

  String url =
      'https://weatherapi-com.p.rapidapi.com/forecast.json?q=$mylatitude,$mylongitude&days=3&lang=$country';
  final Map<String, String> headers = {
    'X-RapidAPI-Key': apiKey,
    'X-RapidAPI-Host': apiHost,
  };
  final response = await http.get(Uri.parse(url), headers: headers);

  if (response.statusCode == 200) {
    String decodedBody = utf8.decode(latin1.encode(response.body));
    return Weather.fromJson(jsonDecode(decodedBody));
  } else {
    throw Exception('Failed to load weather data');
  }
});

final countryProvider = StateProvider<String>((ref) => "de");

IconData getWeatherIcon(int code, int isDay) {
  switch (code) {
    case 1000:
      return isDay == 1
          ? WeatherIcons.day_sunny
          : WeatherIcons.night_clear; // sunny
    case 1003:
      return isDay == 1
          ? WeatherIcons.cloudy
          : WeatherIcons.night_partly_cloudy; // partly cloudy
    case 1006:
      return isDay == 1
          ? WeatherIcons.cloudy
          : WeatherIcons.night_cloudy; // cloudy
    case 1009:
      return isDay == 1
          ? WeatherIcons.day_sunny_overcast
          : WeatherIcons.day_sunny_overcast; //overcast
    case 1030:
      return isDay == 1 ? WeatherIcons.rain : WeatherIcons.rain; //mist
    case 1063:
      return isDay == 1 ? WeatherIcons.rain : WeatherIcons.rain; //patchy rain
    case 1066:
      return isDay == 1 ? WeatherIcons.snow : WeatherIcons.snow; //patchy snow
    case 1069:
      return isDay == 1
          ? WeatherIcons.sleet
          : WeatherIcons.sleet; //patchy sleet
    case 1072:
      return isDay == 1
          ? WeatherIcons.raindrops
          : WeatherIcons.raindrops; //patchy freezing drizzle
    case 1087:
      return isDay == 1
          ? WeatherIcons.day_thunderstorm
          : WeatherIcons.night_thunderstorm; //thundery outbreaks
    case 1114:
      return isDay == 1
          ? WeatherIcons.day_snow_wind
          : WeatherIcons.night_snow_wind; // Blowing snow
    case 1117:
      return isDay == 1
          ? WeatherIcons.day_snow_thunderstorm
          : WeatherIcons.night_snow_thunderstorm; // Blizzard
    case 1135:
      return isDay == 1 ? WeatherIcons.fog : WeatherIcons.night_fog; //Fog

    case 1147:
      return isDay == 1
          ? WeatherIcons.day_fog
          : WeatherIcons.night_fog; //Freezing fog
    case 1150:
      return isDay == 1
          ? WeatherIcons.raindrop
          : WeatherIcons.raindrop; //Patchy light drizzle
    case 1153:
      return isDay == 1
          ? WeatherIcons.sprinkle
          : WeatherIcons.raindrop; //light drizzle
    case 1168:
      return isDay == 1
          ? WeatherIcons.raindrop
          : WeatherIcons.raindrop; // freezing drizzle
    case 1171:
      return isDay == 1
          ? WeatherIcons.rain_wind
          : WeatherIcons.night_rain_wind; // heavy freezing drizzle
    case 1180:
      return isDay == 1
          ? WeatherIcons.rain
          : WeatherIcons.rain; //patchy light rain
    case 1183:
      return isDay == 1 ? WeatherIcons.rain : WeatherIcons.rain; // light rain
    case 1186:
      return isDay == 1
          ? WeatherIcons.rain
          : WeatherIcons.rain; // moderate rain at times
    case 1189:
      return isDay == 1
          ? WeatherIcons.rain
          : WeatherIcons.rain; // moderate rain
    case 1192:
      return isDay == 1
          ? WeatherIcons.raindrops
          : WeatherIcons.raindrops; // heavy rain at times

    case 1195:
      return isDay == 1
          ? WeatherIcons.raindrops
          : WeatherIcons.raindrops; // heavy rain
    case 1198:
      return isDay == 1
          ? WeatherIcons.rain
          : WeatherIcons.rain; // light freezing rain
    case 1201:
      return isDay == 1
          ? WeatherIcons.rain
          : WeatherIcons.rain; // moderate or heavy freezing rain
    case 1204:
      return isDay == 1
          ? WeatherIcons.sleet
          : WeatherIcons.night_sleet; // light sleet
    case 1207:
      return isDay == 1
          ? WeatherIcons.day_sleet_storm
          : WeatherIcons.night_sleet_storm; // moderate or heavy sleet
    case 1210:
      return isDay == 1
          ? WeatherIcons.snow
          : WeatherIcons.night_snow; // patchy light snow
    case 1213:
      return isDay == 1
          ? WeatherIcons.snow
          : WeatherIcons.night_snow; // light snow
    case 1216:
      return isDay == 1
          ? WeatherIcons.snow
          : WeatherIcons.night_snow; // patchy moderate snow
    case 1219:
      return isDay == 1
          ? WeatherIcons.snow
          : WeatherIcons.night_snow; // moderate snow
    case 1222:
      return isDay == 1
          ? WeatherIcons.snow
          : WeatherIcons.night_snow; // patchy heavy snow

    case 1225:
      return isDay == 1
          ? WeatherIcons.day_snow_thunderstorm
          : WeatherIcons.night_snow; // heavy snow
    case 1237:
      return isDay == 1
          ? WeatherIcons.rain_mix
          : WeatherIcons.night_rain_mix; // ice pellets
    case 1240:
      return isDay == 1
          ? WeatherIcons.rain
          : WeatherIcons.night_rain_wind; // light rain shower
    case 1243:
      return isDay == 1
          ? WeatherIcons.day_rain_wind
          : WeatherIcons.night_rain_wind; // moderate or heavy rain shower
    case 1246:
      return isDay == 1
          ? WeatherIcons.rain
          : WeatherIcons.rain; // torrential rain shower
    case 1249:
      return isDay == 1
          ? WeatherIcons.rain
          : WeatherIcons.rain; // light sleet showers
    case 1252:
      return isDay == 1
          ? WeatherIcons.rain
          : WeatherIcons.rain; // moderate or heavy sleet showers
    case 1255:
      return isDay == 1
          ? WeatherIcons.day_snow
          : WeatherIcons.night_snow; // light snow showers
    case 1258:
      return isDay == 1
          ? WeatherIcons.snow
          : WeatherIcons.snow; // moderate or heavy snow showers
    case 1261:
      return isDay == 1
          ? WeatherIcons.day_rain_mix
          : WeatherIcons.night_rain_mix; // light showers of ice pellets

    case 1264:
      return isDay == 1
          ? WeatherIcons.day_rain_mix
          : WeatherIcons
              .night_alt_rain_mix; //moderate or heavy showers of ice pellets
    case 1273:
      return isDay == 1
          ? WeatherIcons.day_thunderstorm
          : WeatherIcons
              .night_thunderstorm; // patchy light rain in area with thunder
    case 1276:
      return isDay == 1
          ? WeatherIcons.thunderstorm
          : WeatherIcons
              .thunderstorm; // moderate or heavy rain in area with thunder
    case 1279:
      return isDay == 1
          ? WeatherIcons.day_snow_thunderstorm
          : WeatherIcons
              .night_snow_thunderstorm; // patchy light snow in area with thunder
    case 1282:
      return isDay == 1
          ? WeatherIcons.day_snow_thunderstorm
          : WeatherIcons
              .night_alt_snow_thunderstorm; // moderate or heavy snow in area with thunder

    default:
      return Icons.error;
  }
}

/*
class WeatherAPI {
  final String apiKey = 'c4a9c5dde4msh0cf112419cace8ep107766jsne79434b9e29b';
  final String apiHost = 'weatherapi-com.p.rapidapi.com';

  late Future<String> weather;

  Future<void> aktuelleWetterdaten() async {
    Position position;
    try {
      position = await determinePosition();
    } catch (e) {
      position = Position(
          longitude: 0,
          latitude: 0,
          timestamp: DateTime(1970),
          accuracy: 0,
          altitude: 0,
          altitudeAccuracy: 0,
          heading: 0,
          headingAccuracy: 0,
          speed: 0,
          speedAccuracy: 0);
    }

    double mylatitude = position.latitude;
    double mylongitude = position.longitude;

    String url =
        'https://weatherapi-com.p.rapidapi.com/forecast.json?q=$mylatitude,${mylongitude}&days=3';
    final Map<String, String> headers = {
      'X-RapidAPI-Key': apiKey,
      'X-RapidAPI-Host': apiHost,
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw ('Failed to load weather data');
    }
  }
}
*/

/*
import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class Weltzeit {
  String location;
  late String time;
  String flag;
  String url;
  late bool isDaytime;

  Weltzeit({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);

      String utcdatetime = data['utc_datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      DateTime dtime = DateTime.parse(utcdatetime);
      dtime = dtime.add(Duration(hours: int.parse(offset)));

      time = DateFormat.jm().format(dtime);
      isDaytime = dtime.hour > 6 && dtime.hour < 20 ? true : false;
    } catch (e) {
      print('Fehler: $e');
      time = 'Zeit nicht grfunden';
    }
  }
}

*/
