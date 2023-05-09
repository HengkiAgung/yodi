import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../utils/auth.dart';

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final _usernameController = TextEditingController();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    return Container(
      height: double.maxFinite,
      width: double.infinity,
      alignment: AlignmentDirectional.center,
      child: ListView(
        children: [
          const Image(
            image: AssetImage("images/Yodi_LOGO.png"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30),
            child: TextField(
              controller: _usernameController,
              obscureText: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30),
            child: TextField(
              controller: _emailController,
              obscureText: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 30.0, right: 30.0, top: 15, bottom: 20),
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 100),
            child: TextButton(
              onPressed: () {
                Auth().register(
                    context, _usernameController.text, _emailController.text, _passwordController.text);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: const EdgeInsets.symmetric(
                  vertical: 14.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 0.5,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}