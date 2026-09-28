import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../widgets/common/weather_card.dart';

class CurrentWeatherScreen extends StatelessWidget {
  final WeatherModel weather;

  const CurrentWeatherScreen({Key? key, required this.weather})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Ville et pays
          Text(
            '${weather.cityName}, ${weather.country}',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            _formatDate(weather.date),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 32),

          // Température actuelle
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${weather.temperature.round()}°',
                style: const TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  'C',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w300,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            weather.description.toUpperCase(),
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(letterSpacing: 1.5),
          ),
          const SizedBox(height: 8),
          Text(
            'Ressenti ${weather.feelsLike.round()}°',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 32),

          // Icône météo
          Image.network(
            'http://openweathermap.org/img/wn/${weather.icon}@4x.png',
            width: 150,
            height: 150,
          ),
          const SizedBox(height: 32),

          // Cartes d'informations
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.5,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: [
              WeatherCard(
                icon: Icons.water_drop,
                title: 'Humidité',
                value: '${weather.humidity}%',
                color: Colors.blue,
              ),
              WeatherCard(
                icon: Icons.air,
                title: 'Vent',
                value: '${weather.windSpeed.round()} km/h',
                color: Colors.green,
              ),
              WeatherCard(
                icon: Icons.speed,
                title: 'Pression',
                value: '${weather.pressure} hPa',
                color: Colors.orange,
              ),
              WeatherCard(
                icon: Icons.location_on,
                title: 'Coordonnées',
                value:
                    '${weather.lat.toStringAsFixed(2)}, ${weather.lon.toStringAsFixed(2)}',
                color: Colors.purple,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final days = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
    final months = [
      'Jan',
      'Fév',
      'Mar',
      'Avr',
      'Mai',
      'Juin',
      'Juil',
      'Août',
      'Sep',
      'Oct',
      'Nov',
      'Déc',
    ];

    return '${days[date.weekday - 1]} ${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
