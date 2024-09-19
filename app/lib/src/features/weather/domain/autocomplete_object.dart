import 'package:freezed_annotation/freezed_annotation.dart';

part 'autocomplete_object.freezed.dart';
part 'autocomplete_object.g.dart';

@freezed
class AutocompleteObject with _$AutocompleteObject {
  factory AutocompleteObject({
    required int id,
    required String name,
    required String region,
    required String country,
    required double lat,
    required double lon,
    required String url,
  }) = _AutocompleteObject;

  factory AutocompleteObject.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteObjectFromJson(json);
}
