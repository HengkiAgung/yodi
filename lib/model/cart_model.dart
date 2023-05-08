import 'cart_variant_model.dart';
import 'product_model.dart';

class Cart {
  late String id;
  late Product product;
  late List<CartVariant> cartVariant;

  Cart({
    required this.id,
    required this.product,
    required this.cartVariant,
  });

  Cart.fromJson(Map<String, dynamic> json) {
    cartVariant = [];
    id = json['id'];
    product = Product.fromJson(json['item']);

    for (var variantObject in json['cartVariant']) {
      cartVariant.add(CartVariant.fromJson(variantObject));
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['product'] = product;
  //   data['cartVariant'] = cartVariant;

  //   return data;
  // }
}