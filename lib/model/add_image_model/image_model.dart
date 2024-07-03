class ImageModel {
  String? message;
  Data? data;

  ImageModel({this.message, this.data});

  ImageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? totalCalories;
  int? totalCarb;
  int? totalFat;
  int? totalProtine;
  int? totalMass;
  String? image;
  int? userId;
  int? id;

  Data(
      {this.totalCalories,
        this.totalCarb,
        this.totalFat,
        this.totalProtine,
        this.totalMass,
        this.image,
        this.userId,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    totalCalories = json['total_calories'];
    totalCarb = json['total_carb'];
    totalFat = json['total_fat'];
    totalProtine = json['total_protine'];
    totalMass = json['total_mass'];
    image = json['image'];
    userId = json['user_id'];
    id = json['id'];
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
    data['id'] = this.id;
    return data;
  }
}
