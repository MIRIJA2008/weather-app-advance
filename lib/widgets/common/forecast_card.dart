import 'package:flutter/material.dart';
import '../../models/forecast_model.dart';

class ForecastCard extends StatelessWidget {
  final ForecastModel forecast;

  const ForecastCard({Key? key, required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Jour
            Expanded(
              flex: 2,
              child: Text(
                _getDayOfWeek(forecast.date),
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),

            // Icône météo
            Expanded(
              flex: 1,
              child: Image.network(
                'http://openweathermap.org/img/wn/${forecast.icon}.png',
                width: 40,
                height: 40,
              ),
            ),

            // Températures
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${forecast.tempMax.round()}°',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${forecast.tempMin.round()}°',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),

            // Description
            Expanded(
              flex: 3,
              child: Text(
                forecast.description,
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDayOfWeek(DateTime date) {
    final days = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
    if (date.weekday == DateTime.now().weekday) {
      return 'Aujourd\'hui';
    } else if (date.weekday ==
        DateTime.now().add(const Duration(days: 1)).weekday) {
      return 'Demain';
    }
    return days[date.weekday - 1];
  }
}
