import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/weathermodel.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String url = "https://api.openweathermap.org/data/3.0/weather";
  String? apiKey;

  WeatherService({required this.apiKey});

  Future<Weather> getWeather(String cityName) async {
    final response = await http
        .get(Uri.parse('$url?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to fetch weather data');
    }
  }

  Future<String> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      // Handle the case where the user has permanently denied location permission.
      // You might want to show a dialog or guide the user to settings.
      return "Permission Denied Forever";
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> places =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city = places.isNotEmpty ? places[0].locality : null;

    return city ?? "";
  }
}
