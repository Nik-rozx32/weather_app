import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/weather_model.dart';
import 'models/weather_request_model.dart';

class WeatherService {
  static const String apiKey = '639421511b51538928b5042e91c9c003';
  static const String baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  Future<Weather> fetchWeather(WeatherRequest request) async {
    final response = await http.get(
        Uri.parse('$baseUrl?q=${request.city}&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Weather.fromJson(data);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
