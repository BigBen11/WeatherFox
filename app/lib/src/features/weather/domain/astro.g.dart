// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'astro.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AstroImpl _$$AstroImplFromJson(Map<String, dynamic> json) => _$AstroImpl(
      sunrise: json['sunrise'] as String,
      sunset: json['sunset'] as String,
      moonrise: json['moonrise'] as String,
      moonset: json['moonset'] as String,
      moon_phase: json['moon_phase'] as String,
      moon_illumination: json['moon_illumination'] as int,
      is_moon_up: json['is_moon_up'] as int,
      is_sun_up: json['is_sun_up'] as int,
    );

Map<String, dynamic> _$$AstroImplToJson(_$AstroImpl instance) =>
    <String, dynamic>{
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
      'moonrise': instance.moonrise,
      'moonset': instance.moonset,
      'moon_phase': instance.moon_phase,
      'moon_illumination': instance.moon_illumination,
      'is_moon_up': instance.is_moon_up,
      'is_sun_up': instance.is_sun_up,
    };
