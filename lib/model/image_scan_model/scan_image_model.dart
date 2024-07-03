class ScanImageModel {
  int? totalCalories;
  int? totalCarb;
  int? totalFat;
  int? totalProtine;
  int? totalMass;
  String? image;
  int? userId;

  ScanImageModel(
      {this.totalCalories,
        this.totalCarb,
        this.totalFat,
        this.totalProtine,
        this.totalMass,
        this.image,
        this.userId});

  ScanImageModel.fromJson(Map<String, dynamic> json) {
    totalCalories = json['total_calories'];
    totalCarb = json['total_carb'];
    totalFat = json['total_fat'];
    totalProtine = json['total_protine'];
    totalMass = json['total_mass'];
    image = json['image'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_calories'] = this.totalCalories;
    data['total_carb'] = this.totalCarb;
    data['total_fat'] = this.totalFat;
    data['total_protine'] = this.totalProtine;
    data['total_mass'] = this.totalMass;
    data['image'] = this.image;
    data['user_id'] = this.userId;
    return data;
  }
}
