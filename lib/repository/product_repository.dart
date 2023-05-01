import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../model/product_model.dart';

class ProductRepository {
  static final String _baseUrl = Platform.isAndroid ? 'http://192.168.1.2:3000/api' : 'http://localhost:3000/api';

  Future getProducts() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/item?page=1&itemCount=12'));

      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body)["data"]['items'];
        print(it);
        List<Product> product = it.map((e) => Product.fromJson(e)).toList();

        return product;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getProductDetail(String idProduct) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/item/$idProduct'));

      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body)["data"]['item'];
        print(it);
        List<Product> product = it.map((e) => Product.fromJson(e)).toList();

        return product;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Future postData(String title, String description) async {
  //   try {
  //     final response = await http.post(Uri.parse('$_baseUrl/shirts'), body: {
  //       'title': title,
  //       'description': description,
  //     });

  //     if (response.statusCode == 201) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
}
