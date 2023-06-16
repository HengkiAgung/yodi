import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../components/function/error_notification_component.dart';
import '../config.dart';
import '../screen/main_screen.dart';
import '../screen/auth_screen.dart';

class Auth {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  
  void login(BuildContext context, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("${Config.apiUrl}/login"),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final token = jsonDecode(response.body)['data']['token'];

        persistToken(token);

        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        
      } else {
        final errorMessage = json.decode(response.body)['message'];

        ErrorNotificationComponent().showModal(context, errorMessage);
      }
    } catch (error) {
      print(error.toString());
    }
  
  }

  void register(BuildContext context, String username, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("${Config.apiUrl}/register"),
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (jsonDecode(response.body)['data']?['token'] != null) {
        final token = jsonDecode(response.body)['data']['token'];

        persistToken(token);

        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        final errorMessage = json.decode(response.body)['message'];

        ErrorNotificationComponent().showModal(context, errorMessage);
      }
    } catch (error) {
      print("token");
      print(error.toString());
    }
  
  }

  Future<String?> getToken() async {
    var value = await storage.read(key: 'token');

    return value;
  }

  Future<void> persistToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async {
    await storage.delete(key: 'token');
    await storage.deleteAll();
    
    var value = await storage.read(key: 'token');
  }
}