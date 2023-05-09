import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../config.dart';
import '../model/seller_model.dart';

class SellerRepository {
  static final String _baseUrl =  Platform.isAndroid  ? Config.apiUrl : 'http://localhost:3000/api';
  
  Future getSellers() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/seller/item?sellerPage=1&sellerItemCount=10&itemItemCount=3'));
      // print("!");
      print(jsonDecode(response.body)["data"]['sellers']);
      // print("!");
      Iterable it = jsonDecode(response.body)["data"]['sellers'];
      List<Seller> seller = it.map((e) {
        return Seller.fromJson(e);
      }).toList();

      return seller;
  
    } catch (e) {
      print(e.toString());
    }
  }
}