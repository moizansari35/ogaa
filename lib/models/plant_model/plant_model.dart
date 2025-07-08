class PlantModel {
  String id;
  String name;
  String imageUrl;
  String soilType;
  List<String> weatherType; // List of weather conditions
  List<String>
      categoryType; // List of category types (e.g., indoor, outdoor, garden)
  String description;
  double minTemp;
  double maxTemp;

  PlantModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.soilType,
    required this.weatherType,
    required this.categoryType,
    required this.description,
    required this.minTemp,
    required this.maxTemp,
  });

  // Factory method to create a PlantModel instance from a JSON map
  factory PlantModel.fromJson(Map<String, dynamic> json) {
    return PlantModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'] ?? '',
      soilType: json['soilType'],
      weatherType: List<String>.from(json['weatherType'] ?? []),
      categoryType: List<String>.from(json['categoryType'] ?? []),
      description: json['description'],
      minTemp: json['minTemp'].toDouble(),
      maxTemp: json['maxTemp'].toDouble(),
    );
  }

  // Method to convert a PlantModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'soilType': soilType,
      'weatherType': weatherType,
      'categoryType': categoryType,
      'description': description,
      'minTemp': minTemp,
      'maxTemp': maxTemp,
    };
  }
}
