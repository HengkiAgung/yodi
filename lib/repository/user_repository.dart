import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:yodi/bloc/user_address/user_address_bloc.dart';

import '../components/function/error_notification_component.dart';
import '../config.dart';
import '../utils/auth.dart';
import '../model/user_model.dart';
import '../model/address_model.dart';

class UserRepository {
  static final String _baseUrl =  Platform.isAndroid  ? Config.apiUrl : 'http://localhost:3000/api';

  Future getUserData(String token) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/user/me'), headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        
        List<User> user = [User.fromJson(jsonDecode(response.body)["data"])];

        return user;
      }

    } catch (e) {
      print(e.toString());
    }
  }

  Future getAllUserAddress(String token) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/user/me/address'), headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {        
        Iterable it = jsonDecode(response.body)["data"]['address'];
        print(token);
        List<Address> address = it.map((e) {
          return Address.fromJson(e);
        }).toList();

        return address;
      }

    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addUserAddress(BuildContext context, String label, String city, String address, String postalCode, String? note) async {
    print("asdfad");
    try {
      String? token = await Auth().getToken();

      final response = await http.post(
        Uri.parse('$_baseUrl/user/me/address'),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'label': label,
          'city': city,
          'address': address,
          'postalCode': postalCode,
          'note': note ?? "",
        }),
      );

      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        context.read<UserAddressBloc>().add(GetAllAddressData());

        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } else {
        final errorMessage = json.decode(response.body)['message'];

        // ignore: use_build_context_synchronously
        ErrorNotificationComponent().showModal(context, errorMessage);
      }

    } catch (e) {
      print(e.toString());
    }
  }
}