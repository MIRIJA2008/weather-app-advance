import 'package:flutter/material.dart';
import '../models/forecast_model.dart';
import '../widgets/common/forecast_card.dart';

class ForecastScreen extends StatelessWidget {
  final List<ForecastModel> forecast;

  const ForecastScreen({Key? key, required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: forecast.length,
      itemBuilder: (context, index) {
        final day = forecast[index];
        return ForecastCard(forecast: day);
      },
    );
  }
}
