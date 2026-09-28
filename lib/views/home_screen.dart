import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../providers/theme_provider.dart';
import '../core/services/location_service.dart';
import 'current_weather_screen.dart';
import 'forecast_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<void> _initFuture;
  final LocationService _locationService = LocationService();

  @override
  void initState() {
    super.initState();
    _initFuture = _initializeApp();
  }

  Future<void> _initializeApp() async {
    final weatherProvider = Provider.of<WeatherProvider>(
      context,
      listen: false,
    );

    try {
      final position = await _locationService.getCurrentLocation();
      await weatherProvider.fetchWeather(position.latitude, position.longitude);
    } catch (e) {
      // Fallback: Paris
      await weatherProvider.fetchWeatherByCity('Paris');
    }
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return FutureBuilder(
      future: _initFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 20),
                  const Text('Chargement de votre météo...'),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Météo Avancée'),
            actions: [
              IconButton(
                icon: Icon(
                  themeProvider.themeMode == ThemeMode.dark
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
                onPressed: () {
                  themeProvider.toggleTheme();
                },
              ),
            ],
          ),
          body:
              weatherProvider.currentWeather == null
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error, color: Colors.red, size: 64),
                        const SizedBox(height: 16),
                        const Text('Impossible de charger les données'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => _initializeApp(),
                          child: const Text('Réessayer'),
                        ),
                      ],
                    ),
                  )
                  : DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        TabBar(
                          tabs: const [
                            Tab(text: 'Actuel'),
                            Tab(text: 'Prévisions'),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              CurrentWeatherScreen(
                                weather: weatherProvider.currentWeather!,
                              ),
                              ForecastScreen(
                                forecast: weatherProvider.forecast,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _initializeApp(),
            child: const Icon(Icons.refresh),
          ),
        );
      },
    );
  }
}
