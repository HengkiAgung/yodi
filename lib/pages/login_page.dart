import 'package:flutter/material.dart';
import 'package:yodi/pages/first_page.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utils/constans.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // authentication(String email, String password) async{
  //   var respond =  await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
      
  //   var data = jsonDecode(respond.body); 
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "images/bg-login.jpg",
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.7),
            colorBlendMode: BlendMode.darken,
          ),
          Center(
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _usernameController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (s) {},
                              decoration: const InputDecoration(
                                hintText: "Enter email",
                                labelText: "Email",
                              ),
                            ),
                            TextFormField(
                              controller: _passwordController,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              validator: (s) {},
                              decoration: const InputDecoration(
                                hintText: "Enter Password",
                                labelText: "Passrowd",
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Constants.prefs.setBool("loggedIn", true);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FirstPage(),
                                  ),
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.amber),
                              ),
                              child: const Text("Sign In"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
