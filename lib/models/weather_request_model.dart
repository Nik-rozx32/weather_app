class WeatherRequest {
  final String city;

  WeatherRequest({required this.city});

  Map<String, dynamic> toJson() => {
        'city': city,
      };
}
