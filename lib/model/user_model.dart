class User {
  late String username;
  late String? email;
  late String? image;
  late String? phoneNumber;
  late String? status;

  User({
    required this.username,
    required this.email,
    required this.image,
    required this.phoneNumber,
    required this.status,
  });

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'] ?? "";
    email = json['email'] ?? "";
    image = json['image'] ?? "";
    phoneNumber = json['phoneNumber'] ?? "";
    status = json['status'] ?? "";
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['username'] = username;
  //   data['email'] = email;
  //   data['image'] = image;
  //   data['phoneNumber'] = phoneNumber;
  //   data['image'] = image;

  //   return data;
  // }
}