class ProductVariant {
  late String? label;
  late String? id;
  late int price;
  late int? stock;

  ProductVariant({
    required this.label,
    required this.id,
    required this.price,
    required this.stock,
  });

  ProductVariant.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    id = json['id'];
    price = json['price'];
    stock = json['stock'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['label'] = label;
  //   data['id'] = id;
  //   data['price'] = price;
  //   data['stock'] = stock;
  //   return data;
  // }
}
