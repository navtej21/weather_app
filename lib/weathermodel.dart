class Weather {
  String? city;
  double? temp;
  String? condition;

  Weather({this.city, this.condition, this.temp});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['name'],
      condition: json['weather'][0]['main'],
      temp: json['main']['temp'].toDouble(),
    );
  }
}
