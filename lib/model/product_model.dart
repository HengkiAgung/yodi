import "seller_model.dart";

class Product {
  late String id;
  late String title;
  late Seller seller;
  late int price;
  late String description;
  late String image;
  late int stock;

  Product({
    required this.id,
    required this.title,
    required this.seller,
    required this.price,
    required this.description,
    required this.image,
    required this.stock,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    seller = Seller.fromJson(json['seller']);
    price = json['price'];
    description = json['description'];
    image = json['image'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['seller'] = seller;
    data['price'] = price;
    data['description'] = description;
    data['image'] = image;
    data['stock'] = stock;
    return data;
  }
}
