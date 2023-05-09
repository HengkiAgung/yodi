import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yodi/widget/auth/register_widget.dart';

import '../bloc/product/product_bloc.dart';
import '../widget/auth/login_widget.dart';

class AuthScreen extends StatefulWidget {
  final int indexWidget;
  const AuthScreen({this.indexWidget = 0, super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState(indexWidget: indexWidget);
}

class _AuthScreenState extends State<AuthScreen> {
  final int indexWidget;
  final List<Widget> authWidget = [LoginWidget(), RegisterWidget()];

  _AuthScreenState({required this.indexWidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Color.fromARGB(255, 226, 226, 226),
            height: 1,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Center(
              child: Text(
                indexWidget == 1 ? "Sign Up" : "Sign In",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              indexWidget == 1
                  ? Navigator.pop(context)
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuthScreen(indexWidget: 1),
                      ),
                    );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 13),
              child: Center(
                child: Text(
                  indexWidget == 1 ? "Login" : "Sign Up",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.amber,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: authWidget[indexWidget],
    );
  }
}
