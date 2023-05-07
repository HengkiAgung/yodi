import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yodi/model/product_variant_model.dart';

import '../config.dart';
import '../utils/auth.dart';

class CartRepository {
  static final String _baseUrl =
      Platform.isAndroid ? Config.apiUrl : 'http://localhost:3000/api';

  Future<bool> addProductToCart(String productId, List<String> productVariantsId) async {
    try {
      String? token = await Auth().getToken();

      List<Map<String, dynamic>> listOfVariant = [];
      for (var variantId in productVariantsId) {
        listOfVariant.add({
          "id": variantId,
          "amount": 1
        });
      }

      final response = await http.post(
        Uri.parse('http://192.168.1.2:3000/api/user/cart'),
        headers: {
          'Authorization': 'Bearer ${token}',
        },
        body: jsonEncode({
          'itemId': productId,
          'itemVariant': listOfVariant,
        }),
      );

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
