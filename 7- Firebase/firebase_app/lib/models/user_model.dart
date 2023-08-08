class UserModel {
  String? id;
  String? name;
  String? surname;
  String? userName;
  bool? status;
  String? email;
  String? phone;
  String? gender;
  String? city;
  String? country;
  String? userImageUrl;
  UserModel({
    required this.id,
    required this.name,
    required this.userName,
    required this.surname,
    required this.email,
    this.status,
    this.phone,
    this.gender,
    this.city,
    this.country,
    this.userImageUrl,
  });

  void setOnlineStatus(bool isOnline) {
    status = isOnline;
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'surname': surname,
      'userName': userName,
      'status': status,
      'email': email,
      'phone': phone,
      'gender': gender,
      'city': city,
      'country': country,
      'userImageUrl': userImageUrl,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] != null ? json['id'] as String : null,
      name: json['name'] != null ? json['name'] as String : null,
      surname: json['surname'] != null ? json['surname'] as String : null,
      userName: json['userName'] != null ? json['userName'] as String : null,
      status: json['status'] != null ? json['status'] as bool : null,
      email: json['email'] != null ? json['email'] as String : null,
      phone: json['phone'] != null ? json['phone'] as String : null,
      gender: json['gender'] != null ? json['gender'] as String : null,
      city: json['city'] != null ? json['city'] as String : null,
      country: json['country'] != null ? json['country'] as String : null,
      userImageUrl:
          json['userImageUrl'] != null ? json['userImageUrl'] as String : null,
    );
  }
}
