import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yodi/model/product_variant_model.dart';
import 'package:yodi/utils/middleware.dart';

import '../../bloc/product/product_bloc.dart';
import '../../components/function/error_notification_component.dart';
import '../../model/product_model.dart';
import '../../components/function/variant_product_component.dart';
import '../../repository/cart_repository.dart';
import '../../utils/auth.dart';

class BottomBuyNavbarComponent extends StatefulWidget {
  List<String>? variantSelected;
  BottomBuyNavbarComponent({this.variantSelected, super.key});

  @override
  // ignore: no_logic_in_create_state
  State<BottomBuyNavbarComponent> createState() => _BottomBuyNavbarComponentState(variantSelected: variantSelected);
}

class _BottomBuyNavbarComponentState extends State<BottomBuyNavbarComponent> {
  final List<String>? variantSelected;

  _BottomBuyNavbarComponentState({this.variantSelected});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      if (state is ProductLoading) {
        return const Text('');
      } else if (state is ProductLoadSuccess) {
        final product = state.product[0];

        return Container(
          height: 70,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 212, 212, 212),
                blurRadius: 4,
                offset: Offset(-2, 2), // Shadow position
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () async {
                  print(variantSelected);
                  if (variantSelected != null) {
                    // ignore: unrelated_type_equality_checks
                    if (await Middleware().authenticated(context) == true) {
                      await CartRepository().addProductToCart(await Auth().getToken() ?? "", product.id, variantSelected ?? []) == true ? Navigator.pop(context) : ErrorNotificationComponent().showModal(context, "Pesanan gagal ditambahkan");
                    }
                  } else {
                    VariantProductComponent().showModal(context, product);
                  }
                },
                child: Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: const Icon(
                    Icons.shopping_cart,
                    size: 30,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      'Beli Sekarang',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        return const Text('FATAL ERROR (FISH LIST)');
      }
    });
  }
}
