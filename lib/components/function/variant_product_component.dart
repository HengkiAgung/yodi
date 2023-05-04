import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/product_model.dart';
import '../../widget/product/bottom_buy_navbar_component.dart';

class VariantProductComponent {
  List<Widget> generateVariant(productVariants){
    List<Widget> widgets = [];

    for (var variant in productVariants) {
      widgets.add(Chip(label: Text(variant.label)));
    }

    return widgets;
  }

  void showModal(context, Product product) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        List<int> variantSelected = [];

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
                  padding: const EdgeInsets.only(right: 14, left: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Varian baju',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Rp. ${product.itemVariant[0].price},00",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Wrap(
                        spacing: 8.0, // gap between adjacent chips
                        runSpacing: 4.0, // gap between lines
                        children: generateVariant(product.itemVariant),
                        // [
                        //   Chip(
                        //     label: Text('Hamilton'),
                        //   ),
                        //   Chip(
                        //     label: Text('Lafayette'),
                        //   ),
                        //   Chip(
                        //     label: Text('MulliganMulliganMulliganMullig'),
                        //   ),
                        //   Chip(
                        //     label: Text('Laurens'),
                        //   ),
                        // ],
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
                BottomBuyNavbarComponent(),
              ],
            ),
          ),
        );
      },
    );
  }
}