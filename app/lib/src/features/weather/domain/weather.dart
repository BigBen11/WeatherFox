import 'package:freezed_annotation/freezed_annotation.dart';
import 'location.dart';
import 'current.dart';
import 'forecast.dart';

part 'weather.freezed.dart';
part 'weather.g.dart';

@freezed
class Weather with _$Weather {
  factory Weather({
    required Location location,
    required Current current,
    required Forecast forecast,
  }) = _Weather;

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
}
