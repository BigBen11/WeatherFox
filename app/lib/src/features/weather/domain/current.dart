// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'condition.dart';

part 'current.freezed.dart';
part 'current.g.dart';

@freezed
class Current with _$Current {
  factory Current({
    required int last_updated_epoch,
    required String last_updated,
    required double temp_c,
    required double temp_f,
    required int is_day,
    required Condition condition,
    required double wind_mph,
    required double wind_kph,
    required int wind_degree,
    required String wind_dir,
    required double pressure_mb,
    required double pressure_in,
    required double precip_mm,
    required double precip_in,
    required int humidity,
    required int cloud,
    required double feelslike_c,
    required double feelslike_f,
    required double vis_km,
    required double vis_miles,
    required double uv,
    required double gust_mph,
    required double gust_kph,
  }) = _Current;

  factory Current.fromJson(Map<String, dynamic> json) =>
      _$CurrentFromJson(json);
}
