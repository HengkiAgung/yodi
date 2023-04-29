import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/product_model.dart';

class ProductRepository {
  final _baseUrl = 'https://643bb66d44779455735f0f27.mockapi.io/';

  Future getProductData() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/shirts'));

      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<Product> product = it.map((e) => Product.fromJson(e)).toList();
        return product;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future postData(String title, String description) async {
    try {
      final response = await http.post(Uri.parse('$_baseUrl/shirts'), body: {
        'title': title,
        'description': description,
      });

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
