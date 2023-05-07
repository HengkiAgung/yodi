import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:yodi/components/function/error_notification_component.dart';
import 'package:yodi/config.dart';
import 'package:http/http.dart' as http;
import 'package:yodi/screen/main_screen.dart';

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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ),
        );
      } else {
        final errorMessage = json.decode(response.body)['message'];

        ErrorNotificationComponent().showModal(context, errorMessage);
      }
    } catch (error) {
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