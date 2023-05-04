import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../model/user_model.dart';

class UserRepository {
  static final String _baseUrl =  Platform.isAndroid  ? 'http://192.168.1.3:3000/api' : 'http://localhost:3000/api';

  Future getUserData(String idUser) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/item/$idUser'));

      if (response.statusCode == 200) {
        // print(jsonDecode(response.body)["data"]['item']);
        List<User> user = [User.fromJson(jsonDecode(response.body)["data"])];

        return user;
      }

    } catch (e) {
      print(e.toString());
    }
  }
}