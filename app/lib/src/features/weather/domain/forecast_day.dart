// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'day.dart';
import 'astro.dart';
import 'hour.dart';

part 'forecast_day.freezed.dart';
part 'forecast_day.g.dart';

@freezed
class ForecastDay with _$ForecastDay {
  factory ForecastDay({
    required String date,
    required int date_epoch,
    required Day day,
    required Astro astro,
    required List<Hour> hour,
  }) = _ForecastDay;

  factory ForecastDay.fromJson(Map<String, dynamic> json) =>
      _$ForecastDayFromJson(json);
}
