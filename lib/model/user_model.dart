class User {
  late String? username;
  late String? email;
  late String? password;
  late String? image;

  User({
    required this.username,
    required this.email,
    required this.password,
    required this.image,
  });

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'] ?? "";
    email = json['email'] ?? "";
    password = json['password'] ?? "";
    image = json['image'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    data['image'] = image;

    return data;
  }
}