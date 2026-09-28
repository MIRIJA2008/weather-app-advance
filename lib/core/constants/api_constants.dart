class ApiConstants {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';

  // ⭐ REMPLACEZ PAR VOTRE CLÉ API ⭐
  static const String apiKey = '8fb145904add163ecac6c5166c2e5d17';

  // Endpoints
  static const String currentWeather = '$baseUrl/weather';
  static const String forecast = '$baseUrl/forecast';

  // Paramètres
  static const String units = 'metric';
  static const String lang = 'fr';
}
