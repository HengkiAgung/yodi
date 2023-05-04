import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product/product_bloc.dart';
import '../widget/auth/login_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    super.initState();

    // context.read<ProductBloc>().add(GetProductDetail(idProduct: idProduct));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: const AppBarComponent(),
      body: LoginWidget(),
    );
  }
}