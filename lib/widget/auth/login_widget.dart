import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.infinity,
      alignment: AlignmentDirectional.center,
      child: Column(
        children: const [
          Image(
            image: AssetImage("images/Yodi_LOGO.png"),
          ),
          Text("aslfjaklsdjfa"),
        ],
      ),
    );
  }
}
