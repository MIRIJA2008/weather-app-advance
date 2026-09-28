import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherModel {
  final String cityName;
  final double temperature;
  final String description;
  final String icon;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.icon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'] ?? 'Inconnu',
      temperature: (json['main']['temp'] as num).toDouble(),
      description: json['weather'][0]['description'] ?? '',
      icon: json['weather'][0]['icon'] ?? '01d',
    );
  }
}

class ForecastModel {
  final DateTime date;
  final double tempMax;
  final String description;
  final String icon;

  ForecastModel({
    required this.date,
    required this.tempMax,
    required this.description,
    required this.icon,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      tempMax: (json['main']['temp_max'] as num).toDouble(),
      description: json['weather'][0]['description'] ?? '',
      icon: json['weather'][0]['icon'] ?? '01d',
    );
  }
}

class WeatherService {
  static const String apiKey = 'votre_cle_api_ici';
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<WeatherModel> getCurrentWeather(double lat, double lon) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric&lang=fr',
      ),
    );

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erreur de chargement');
    }
  }

  Future<List<ForecastModel>> getWeatherForecast(double lat, double lon) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric&lang=fr',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<ForecastModel> forecasts = [];

      if (data['list'] != null) {
        for (int i = 0; i < data['list'].length && i < 40; i += 8) {
          forecasts.add(ForecastModel.fromJson(data['list'][i]));
        }
      }

      return forecasts.take(5).toList();
    } else {
      throw Exception('Erreur de prévisions');
    }
  }
}
