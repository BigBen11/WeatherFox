// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'autocomplete_object.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AutocompleteObject _$AutocompleteObjectFromJson(Map<String, dynamic> json) {
  return _AutocompleteObject.fromJson(json);
}

/// @nodoc
mixin _$AutocompleteObject {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get region => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get lon => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AutocompleteObjectCopyWith<AutocompleteObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AutocompleteObjectCopyWith<$Res> {
  factory $AutocompleteObjectCopyWith(
          AutocompleteObject value, $Res Function(AutocompleteObject) then) =
      _$AutocompleteObjectCopyWithImpl<$Res, AutocompleteObject>;
  @useResult
  $Res call(
      {int id,
      String name,
      String region,
      String country,
      double lat,
      double lon,
      String url});
}

/// @nodoc
class _$AutocompleteObjectCopyWithImpl<$Res, $Val extends AutocompleteObject>
    implements $AutocompleteObjectCopyWith<$Res> {
  _$AutocompleteObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? region = null,
    Object? country = null,
    Object? lat = null,
    Object? lon = null,
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      region: null == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lon: null == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AutocompleteObjectImplCopyWith<$Res>
    implements $AutocompleteObjectCopyWith<$Res> {
  factory _$$AutocompleteObjectImplCopyWith(_$AutocompleteObjectImpl value,
          $Res Function(_$AutocompleteObjectImpl) then) =
      __$$AutocompleteObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String region,
      String country,
      double lat,
      double lon,
      String url});
}

/// @nodoc
class __$$AutocompleteObjectImplCopyWithImpl<$Res>
    extends _$AutocompleteObjectCopyWithImpl<$Res, _$AutocompleteObjectImpl>
    implements _$$AutocompleteObjectImplCopyWith<$Res> {
  __$$AutocompleteObjectImplCopyWithImpl(_$AutocompleteObjectImpl _value,
      $Res Function(_$AutocompleteObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? region = null,
    Object? country = null,
    Object? lat = null,
    Object? lon = null,
    Object? url = null,
  }) {
    return _then(_$AutocompleteObjectImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      region: null == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lon: null == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AutocompleteObjectImpl implements _AutocompleteObject {
  _$AutocompleteObjectImpl(
      {required this.id,
      required this.name,
      required this.region,
      required this.country,
      required this.lat,
      required this.lon,
      required this.url});

  factory _$AutocompleteObjectImpl.fromJson(Map<String, dynamic> json) =>
      _$$AutocompleteObjectImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String region;
  @override
  final String country;
  @override
  final double lat;
  @override
  final double lon;
  @override
  final String url;

  @override
  String toString() {
    return 'AutocompleteObject(id: $id, name: $name, region: $region, country: $country, lat: $lat, lon: $lon, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AutocompleteObjectImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lon, lon) || other.lon == lon) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, region, country, lat, lon, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AutocompleteObjectImplCopyWith<_$AutocompleteObjectImpl> get copyWith =>
      __$$AutocompleteObjectImplCopyWithImpl<_$AutocompleteObjectImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AutocompleteObjectImplToJson(
      this,
    );
  }
}

abstract class _AutocompleteObject implements AutocompleteObject {
  factory _AutocompleteObject(
      {required final int id,
      required final String name,
      required final String region,
      required final String country,
      required final double lat,
      required final double lon,
      required final String url}) = _$AutocompleteObjectImpl;

  factory _AutocompleteObject.fromJson(Map<String, dynamic> json) =
      _$AutocompleteObjectImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get region;
  @override
  String get country;
  @override
  double get lat;
  @override
  double get lon;
  @override
  String get url;
  @override
  @JsonKey(ignore: true)
  _$$AutocompleteObjectImplCopyWith<_$AutocompleteObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
