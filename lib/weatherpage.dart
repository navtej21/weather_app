import 'package:flutter/material.dart';
import 'package:weather_app/weathermodel.dart';
import 'package:weather_app/weatherservice.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService =
      WeatherService(apiKey: "ba3803fa5af2ebb128b33d752a07963a");

  Weather? _weather;

  Future<void> _fetchWeather() async {
    String cityname = await _weatherService.getCurrentLocation();

    try {
      final weather = await _weatherService.getWeather(cityname);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.city ?? "Loading city"),
            Text('${_weather?.temp}°C'),
          ],
        ),
      ),
    );
  }
}
