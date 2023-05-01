import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product/product_bloc.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final Widget backScreen;
  const AppBarComponent({required this.backScreen, super.key});

  @override
  Size get preferredSize => const Size.fromHeight(57);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(0, 255, 252, 81),
      leading: IconButton(
        onPressed: () {
          context.read<ProductBloc>().add(GetProductList());

          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {
            
          },
          icon: const Icon(
            Icons.shopping_cart,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}