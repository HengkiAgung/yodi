import "user_model.dart";

class Seller {
  late User user;
  late String city;
  late String? address;

  Seller({
    required this.user,
    required this.city,
    required this.address,
  });

  Seller.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['user']);
    city = json['city'];
    address = json['address'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['user'] = user;
  //   data['city'] = city;
  //   data['address'] = address;
  //   return data;
  // }
}
