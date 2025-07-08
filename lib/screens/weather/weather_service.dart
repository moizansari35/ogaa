import 'dart:convert';

import 'package:http/http.dart' as http;

import 'weather_model.dart';

class WeatherService {
  static const _baseUrl = 'https://yahoo-weather5.p.rapidapi.com/weather';
  static const _apiKey = 'c8fa8c7d60mshbca9484b14be24dp14402cjsn9a805e0616c6';

  Future<WeatherModel> getWeather(String location) async {
    final url = Uri.parse('$_baseUrl?location=$location&format=json&u=c');
    final response = await http.get(
      url,
      headers: {
        'X-RapidAPI-Key': _apiKey,
        'X-RapidAPI-Host': 'yahoo-weather5.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return WeatherModel.fromJson(data);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
