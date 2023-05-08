import 'package:flutter/material.dart';

import '../screen/auth_screen.dart';
import 'auth.dart';

class Middleware {
  Future<bool> authenticated(BuildContext context) async {
    if( await Auth().getToken() == null){
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthScreen(),
        ),
      );

      return false;
    }
    return true;
  }
}