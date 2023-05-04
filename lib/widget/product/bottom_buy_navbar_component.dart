import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product/product_bloc.dart';
import '../../model/product_model.dart';
import '../../components/function/variant_product_component.dart';

class BottomBuyNavbarComponent extends StatefulWidget {
  const BottomBuyNavbarComponent({super.key});

  @override
  // ignore: no_logic_in_create_state
  State<BottomBuyNavbarComponent> createState() => _BottomBuyNavbarComponentState();
}

class _BottomBuyNavbarComponentState extends State<BottomBuyNavbarComponent> {
  final List<int>? itemVariantId;

  _BottomBuyNavbarComponentState({this.itemVariantId});

  void variantMethod(int idItem, List<int> idVariant, String method) {
    print(idItem);
    print(idVariant);
  }

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
                onTap: () {
                  if (itemVariantId != null) {
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
                    VariantProductComponent().showModal(context, product);
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
