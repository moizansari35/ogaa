class WeatherModel {
  final int temperature;
  // final String city;

  WeatherModel({
    required this.temperature,
    //required this.city,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperature:
          (json['current_observation']['condition']['temperature'] ?? 0)
              .toDouble()
              .round(), // Convert to double and round to int
      //city: json['location']['city'] ?? 'Unknown',
    );
  }
}
