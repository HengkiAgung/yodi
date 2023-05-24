import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../config.dart';

class ShipperRepository {
  static final String _baseUrl =  Platform.isAndroid  ? Config.apiUrl : 'http://localhost:3000/api';

  Future getShipperData() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/shipper'));

      if (response.statusCode == 200) {
        var shipper = jsonDecode(response.body)["data"];

        shipper = shipper["shippers"].map((e) {
          return e;
        }).toList();
        
        return shipper;
      }

    } catch (e) {
      print(e.toString());
    }
  }
}