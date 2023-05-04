class User {
  late String username;
  late String? email;
  late String? password;
  late String? image;
  late String? phoneNumber;
  late String? status;

  User({
    required this.username,
    required this.email,
    required this.password,
    required this.image,
    required this.phoneNumber,
    required this.status,
  });

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'] ?? "";
    email = json['email'] ?? "";
    password = json['password'] ?? "";
    image = json['image'] ?? "";
    phoneNumber = json['phoneNumber'] ?? "";
    status = json['status'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    data['image'] = image;
    data['phoneNumber'] = phoneNumber;
    data['image'] = image;

    return data;
  }
}