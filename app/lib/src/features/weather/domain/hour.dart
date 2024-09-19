// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'condition.dart';

part 'hour.freezed.dart';
part 'hour.g.dart';

@freezed
class Hour with _$Hour {
  factory Hour({
    required int time_epoch,
    required String time,
    required double temp_c,
    required double temp_f,
    required bool is_day,
    required Condition condition,
    required double wind_mph,
    required double wind_kph,
    required int wind_degree,
    required String wind_dir,
    required double pressure_mb,
    required double pressure_in,
    required double precip_mm,
    required double precip_in,
    required double snow_cm,
    required int humidity,
    required int cloud,
    required double feelslike_c,
    required double feelslike_f,
    required double windchill_c,
    required double windchill_f,
    required double heatindex_c,
    required double heatindex_f,
    required double dewpoint_c,
    required double dewpoint_f,
    required bool will_it_rain,
    required int chance_of_rain,
    required bool will_it_snow,
    required int chance_of_snow,
    required double vis_km,
    required double vis_miles,
    required double gust_mph,
    required double gust_kph,
    required double uv,
  }) = _Hour;

  factory Hour.fromJson(Map<String, dynamic> json) => _$HourFromJson({
        ...json,
        'is_day': json['is_day'] == 1,
        'will_it_rain': json['will_it_rain'] == 1,
        'will_it_snow': json['will_it_snow'] == 1,
      });
}
