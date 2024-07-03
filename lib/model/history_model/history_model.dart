class HistoryModel {
  int? id;
  String? name;
  String? image;
  int? totalCalories;
  int? totalCarb;
  int? totalFat;
  int? totalProtine;
  int? totalMass;

  HistoryModel({
    this.id,
    this.name,
    this.image,
    this.totalCalories,
    this.totalCarb,
    this.totalFat,
    this.totalProtine,
    this.totalMass,
  });

  // Factory constructor to create a HistoryModel from JSON
  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      totalCalories: json['total_calories'],
      totalCarb: json['total_carb'],
      totalFat: json['total_fat'],
      totalProtine: json['total_protine'],
      totalMass: json['total_mass'],
    );
  }

  // Method to convert a HistoryModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'total_calories': totalCalories,
      'total_carb': totalCarb,
      'total_fat': totalFat,
      'total_protine': totalProtine,
      'total_mass': totalMass,
    };
  }
}
