import 'product_variant_model.dart';
import "seller_model.dart";

class Product {
  late String id;
  late String title;
  late String? description;
  late int? sold;
  late Map? count;
  late Seller? seller;
  late List<ProductVariant> itemVariant;
  late List<String> itemImage;

  Product({
    required this.id,
    required this.title,
    required this.seller,
    required this.description,
    required this.sold,
    required this.count,
    required this.itemImage,
    required this.itemVariant,
  });

  Product.fromJson(Map<String, dynamic> json) {
    itemImage = [];
    itemVariant = [];
    id = json['id'];
    title = json['title'];
    description = json['description'];
    sold = json['sold'];
    count = json['_count'];
    if (json['seller'] != null) {
      seller = Seller.fromJson(json['seller']);
    }

    for (var imageObject in json['itemImage']) {
      this.itemImage.add(imageObject["image"]);
    }

    if (json['itemVariant'] != null) {
      for (var variantObject in json['itemVariant']) {
        this.itemVariant.add(ProductVariant.fromJson(variantObject));
      }
    }
  }
}
