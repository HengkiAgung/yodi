import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yodi/screen/product_shipping_screen.dart';
import 'package:yodi/utils/middleware.dart';

import '../../bloc/cart/cart_bloc.dart';
import '../../bloc/product/product_bloc.dart';
import '../../components/function/error_notification_component.dart';
import '../../components/function/variant_product_component.dart';
import '../../repository/cart_repository.dart';
import '../../screen/cart_screen.dart';
import '../../utils/auth.dart';

class BottomBuyNavbarComponent extends StatefulWidget {
  List<String> variantSelected;
  bool isOpened;
  BottomBuyNavbarComponent({required this.variantSelected, required this.isOpened, super.key});

  @override
  // ignore: no_logic_in_create_state
  State<BottomBuyNavbarComponent> createState() =>
      _BottomBuyNavbarComponentState(variantSelected: variantSelected, isOpened: isOpened);
}

class _BottomBuyNavbarComponentState extends State<BottomBuyNavbarComponent> {
  List<String> variantSelected = [];
  bool isOpened;

  _BottomBuyNavbarComponentState({required this.variantSelected, required this.isOpened});

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
                  if (variantSelected.isNotEmpty) {
                    // ignore: unrelated_type_equality_checks, use_build_context_synchronously
                    if (await Middleware().authenticated(context) == true) {
                      if (await CartRepository().addProductToCart( await Auth().getToken() ?? "", product.id, variantSelected ?? []) == true) {
                          Navigator.pop(context);
                          // ignore: use_build_context_synchronously
                          context.read<CartBloc>().add(GetCartList());

                          // ignore: use_build_context_synchronously
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                const CartListScreen(),
                            ),
                          );
                      } else if (!isOpened) {
                        // ignore: use_build_context_synchronously
                        ErrorNotificationComponent().showModal(context, "Pesanan gagal ditambahkan");
                      }
                    }
                  } else if(!isOpened) {
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
                  onTap: () async {
                    if (variantSelected.isNotEmpty) {
                      // ignore: unrelated_type_equality_checks, use_build_context_synchronously
                      if (await Middleware().authenticated(context) == true)  {
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);

                        // ignore: use_build_context_synchronously
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                              ProductShippingScreen(product: product, itemNote: "", selectedVariantProduct: variantSelected ?? []),
                          ),
                        );
                      }
                    } else if(!isOpened) {
                      VariantProductComponent().showModal(context, product);
                    }
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
