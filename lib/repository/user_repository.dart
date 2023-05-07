import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../config.dart';
import '../utils/auth.dart';
import '../model/user_model.dart';

class UserRepository {
  static final String _baseUrl =  Platform.isAndroid  ? Config.apiUrl : 'http://localhost:3000/api';

  Future getUserData() async {
    try {
      String? token = await Auth().getToken();

      final response = await http.get(Uri.parse('$_baseUrl/user/me'), headers: {
        'Authorization': 'Bearer ${token}',
      });

      if (response.statusCode == 200) {
        
        List<User> user = [User.fromJson(jsonDecode(response.body)["data"])];

        return user;
      }

    } catch (e) {
      print(e.toString());
    }
  }
}