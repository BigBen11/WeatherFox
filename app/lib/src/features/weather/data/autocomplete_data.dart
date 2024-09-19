import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:weather_fox/src/features/weather/domain/autocomplete_object.dart';
import 'dart:convert';

final autocompleteProvider =
    FutureProvider.family<List<AutocompleteObject>, String>((ref, input) async {
  final url =
      Uri.parse('https://weatherapi-com.p.rapidapi.com/search.json?q=$input');
  final response = await http.get(url, headers: {
    'X-RapidAPI-Key': 'c4a9c5dde4msh0cf112419cace8ep107766jsne79434b9e29b',
    'X-RapidAPI-Host': 'weatherapi-com.p.rapidapi.com'
  });

  if (response.statusCode == 200) {
    List<dynamic> list = json.decode(response.body);
    return list.map((item) => AutocompleteObject.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load weather data');
  }
});
