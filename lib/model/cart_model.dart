import 'product_model.dart';
import 'product_variant_model.dart';

class Cart {
  late Product product;
  late List<ProductVariant> cartVariant;

  Cart({
    required this.product,
    required this.cartVariant,
  });

  Cart.fromJson(Map<String, dynamic> json) {
    cartVariant = [];
    product = Product.fromJson(json['item']);

    for (var variantObject in json['cartVariant']) {
      this.cartVariant.add(ProductVariant.fromJson(variantObject));
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['product'] = product;
  //   data['cartVariant'] = cartVariant;

  //   return data;
  // }
}