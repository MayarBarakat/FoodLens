class GoalsModel {
  String? message;
  Data? data;

  GoalsModel({this.message, this.data});

  GoalsModel.fromJson(Map<String, dynamic> json) {
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
  int? subCalories;
  int? subCarb;
  int? subFat;
  int? subProtine;
  int? remainingCalories;

  Data(
      {this.subCalories,
        this.subCarb,
        this.subFat,
        this.subProtine,
        this.remainingCalories});

  Data.fromJson(Map<String, dynamic> json) {
    subCalories = json['sub_calories'];
    subCarb = json['sub_carb'];
    subFat = json['sub_fat'];
    subProtine = json['sub_protine'];
    remainingCalories = json['remaining_calories'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_calories'] = this.subCalories;
    data['sub_carb'] = this.subCarb;
    data['sub_fat'] = this.subFat;
    data['sub_protine'] = this.subProtine;
    data['remaining_calories'] = this.remainingCalories;
    return data;
  }
}
