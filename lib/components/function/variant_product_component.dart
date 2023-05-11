import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/product_model.dart';
import '../chip_of_variant_component.dart';

class VariantProductComponent {
  void showModal(context, Product product) {

    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {

        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(),
                  child: 
                  ChipOfVariantComponent(product: product),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
