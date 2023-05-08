import 'product_variant_model.dart';

class CartVariant {
  late String id;
  late int amount;
  late ProductVariant itemVariant;

  CartVariant({
    required this.id,
    required this.amount,
    required this.itemVariant,
  });

  CartVariant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    itemVariant = ProductVariant.fromJson(json["itemVariant"]);
  }
}