import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/product_variant/product_variant_bloc.dart';
import '../model/product_model.dart';
import '../model/product_variant_model.dart';
import '../widget/product/bottom_buy_navbar_component.dart';

class ChipOfVariantComponent extends StatefulWidget {
  final Product product;

  const ChipOfVariantComponent({required this.product, super.key});

  @override
  State<ChipOfVariantComponent> createState() => _ChipOfVariantComponentState(product: product, chipOfItemVariant: product.itemVariant);
}

class _ChipOfVariantComponentState extends State<ChipOfVariantComponent> {
  List<String> variantSelected = [];
  final List<ProductVariant> chipOfItemVariant;
  final Product product;
  int price = 0;

  _ChipOfVariantComponentState({required this.product, required this.chipOfItemVariant});

  List<Widget> generateVariant(List<ProductVariant> productVariants) {
    List<Widget> widgets = [];

    for (var variant in productVariants) {
      widgets.add(
          InputChip(
            label: Text(
              variant.label!,
              style: TextStyle(
                color:
                    variantSelected.contains(variant.label) ? Colors.amber : Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            shape: const StadiumBorder(
              side: BorderSide(
                width: 1,
                color: Colors.amber,
              ),
            ),
            selected: variantSelected.contains(variant.id) ? true : false,
            selectedColor: Color.fromARGB(50, 255, 191, 0),
            onSelected: (bool selected) {

              setState(() {
                if (selected) {
                  variantSelected.add(variant.id!);
                  price += variant.price;
                } else {
                  variantSelected.removeWhere( (item) => item == variant.id );
                  price -= variant.price;
                }
              });
            },
          ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 14, left: 14, top: 20, bottom: 20),
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
        Padding(
          padding: const EdgeInsets.only(right: 14, left: 14),
          child: Column(
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
                "Rp. ${price},00",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14, bottom: 20),
              child: Wrap(
                spacing: 8.0, // gap between adjacent chips
                runSpacing: 4.0, // gap between lines
                children: generateVariant(chipOfItemVariant),
              ),
            ),
            BottomBuyNavbarComponent(variantSelected: variantSelected),
          ],
        ),
      ],
    );
                  
  }
}