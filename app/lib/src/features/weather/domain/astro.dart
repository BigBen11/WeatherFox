// ignore_for_file: non_constant_identifier_names

//import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'astro.freezed.dart';
part 'astro.g.dart';

@freezed
class Astro with _$Astro {
  factory Astro({
    required String sunrise,
    required String sunset,
    required String moonrise,
    required String moonset,
    required String moon_phase,
    required int moon_illumination,
    required int is_moon_up,
    required int is_sun_up,
  }) = _Astro;

  factory Astro.fromJson(Map<String, dynamic> json) => _$AstroFromJson(json);
}
