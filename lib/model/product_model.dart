class Product {
  String? name;
  String? size;
  int? sellerId;
  String? price;
  String? deskripsi;
  String? id;

  Product({
    required this.name,
    required this.size,
    required this.sellerId,
    required this.price,
    required this.deskripsi,
    required this.id,
  });

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    size = json['size'];
    sellerId = json['seller_id'];
    price = json['price'];
    deskripsi = json['deskripsi'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['size'] = size;
    data['seller_id'] = sellerId;
    data['price'] = price;
    data['deskripsi'] = deskripsi;
    data['id'] = id;
    return data;
  }
}
