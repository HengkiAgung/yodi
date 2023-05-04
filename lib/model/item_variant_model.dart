class ItemVariant {
  late String? label;
  late int price;
  late int? stock;

  ItemVariant({
    required this.label,
    required this.price,
    required this.stock,
  });

  ItemVariant.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    price = json['price'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['price'] = price;
    data['stock'] = stock;
    return data;
  }
}
