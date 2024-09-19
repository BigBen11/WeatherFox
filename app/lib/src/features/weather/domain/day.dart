// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'condition.dart';

part 'day.freezed.dart';
part 'day.g.dart';

@freezed
class Day with _$Day {
  factory Day({
    required double maxtemp_c,
    required double maxtemp_f,
    required double mintemp_c,
    required double mintemp_f,
    required double avgtemp_c,
    required double avgtemp_f,
    required double maxwind_mph,
    required double maxwind_kph,
    required double totalprecip_mm,
    required double totalprecip_in,
    required double totalsnow_cm,
    required double avgvis_km,
    required double avgvis_miles,
    required double avghumidity,
    required bool daily_will_it_rain,
    required int daily_chance_of_rain,
    required bool daily_will_it_snow,
    required int daily_chance_of_snow,
    required Condition condition,
    required double uv,
  }) = _Day;

  factory Day.fromJson(Map<String, dynamic> json) => _$DayFromJson({
        ...json,
        'daily_will_it_rain': json['daily_will_it_rain'] == 1,
        'daily_will_it_snow': json['daily_will_it_snow'] == 1,
      });
}
