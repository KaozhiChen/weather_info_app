import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const WeatherInfoApp());
}

class WeatherInfoApp extends StatelessWidget {
  const WeatherInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Weather Info App',
      home: WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _cityController = TextEditingController();

  String cityName = '';
  String temperature = '';
  String weatherCondition = '';

  List<Map<String, String>> forcastList = [];

  void _fetchWeather() {
    setState(() {
      cityName = _cityController.text;
      temperature = '${15 + Random().nextInt(16)}°C';
      List<String> conditions = ['Sunny', 'Cloudy', 'Rainy'];
      weatherCondition = conditions[Random().nextInt(conditions.length)];
    });
  }

  void _getForecast() {
    setState(() {
      cityName = _cityController.text;
      forcastList = List.generate(7, (index) {
        String day = 'Day ${index + 1}';
        String temp = '${15 + Random().nextInt(16)}°C';
        List<String> conditions = ['Sunny', 'Cloudy', 'Rainy'];
        String condition = conditions[Random().nextInt(conditions.length)];
        return {'day': day, 'temp': temp, 'condition': condition};
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'Enter a city name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _fetchWeather,
              child: const Text('Fetch Weather'),
            ),
            ElevatedButton(
              onPressed: _getForecast,
              child: const Text('Get 7-Day Forecast'),
            ),
            const SizedBox(height: 12),
            Text('City: $cityName'),
            Text('Temperature: $temperature'),
            Text('Condition: $weatherCondition'),
            const SizedBox(height: 12),
            forcastList.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('7-day forecast:'),
                      ...forcastList.map((item) {
                        return Column(
                          children: [
                            Text(
                                '${item['day']}: ${item['temp']} (${item['condition']})'),
                            const SizedBox(height: 5),
                          ],
                        );
                      }),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
