import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yodi/screen/cart_screen.dart';

import '../bloc/product/product_bloc.dart';
import '../screen/account_screen.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  const AppBarComponent({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(57);

  static bool canPop(BuildContext context) {
    final NavigatorState? navigator = Navigator.maybeOf(context);
    return navigator != null && navigator.canPop();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(0, 255, 252, 81),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: Container(
          color: const Color.fromARGB(123, 226, 226, 226),
          height: 1,
        ),
      ),
      leading: canPop(context)
          ? IconButton(
              onPressed: () {
                context.read<ProductBloc>().add(GetProductList());

                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            )
          : const SizedBox(width: 10),
      elevation: 0,
      actions: [
        canPop(context)
            ? const SizedBox(width: 10)
            : Container(
                width: 200,
                padding: const EdgeInsets.all(10),
                child: Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color.fromARGB(255, 216, 216, 216)),
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search,
                        color: Color.fromARGB(255, 97, 97, 97),
                        size: 18,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Search on YoDi",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: const Color.fromARGB(255, 97, 97, 97),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        const Spacer(),
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) =>
                  const CartScreen(),
              ),
            );
          },
          icon: const Icon(
            Icons.shopping_cart,
            color: Color.fromARGB(255, 97, 97, 97),
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) =>
                  const AccountScreen(),
              ),
            );
          },
          icon: const Icon(
            Icons.account_circle,
            color: Color.fromARGB(255, 97, 97, 97),
          ),
        ),
      ],
    );
  }
}
