import "package:yodi/model/product_model.dart";

import "user_model.dart";

class Seller {
  late String? id;
  late User user;
  late String city;
  late String? address;
  late List<Product>? product;

  Seller({
    required this.user,
    required this.id,
    required this.city,
    required this.address,
  });

  Seller.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = User.fromJson(json['user']);
    city = json['city'];
    address = json['address'];

    Iterable? jsonProduct = json['item'];
    product = jsonProduct?.map((e) {
      return Product.fromJson(e);
    }).toList();
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['user'] = user;
  //   data['city'] = city;
  //   data['address'] = address;
  //   return data;
  // }
}
