class SignUpModel {
  String? status;
  String? message;
  User? user;
  String? accessToken;
  String? tokenType;

  SignUpModel(
      {this.status, this.message, this.user, this.accessToken, this.tokenType});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    accessToken = json['access_token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    return data;
  }
}

class User {
  String? email;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? height;
  String? weight;
  String? age;
  String? gender;
  String? address;
  Null? neededCalories;
  String? updatedAt;
  String? createdAt;
  int? id;

  User(
      {this.email,
        this.firstName,
        this.lastName,
        this.phoneNumber,
        this.height,
        this.weight,
        this.age,
        this.gender,
        this.address,
        this.neededCalories,
        this.updatedAt,
        this.createdAt,
        this.id});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    height = json['height'];
    weight = json['weight'];
    age = json['age'];
    gender = json['gender'];
    address = json['address'];
    neededCalories = json['needed_calories'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone_number'] = this.phoneNumber;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['needed_calories'] = this.neededCalories;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
