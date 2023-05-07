import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_variant/product_variant_bloc.dart';
import '../model/product_variant_model.dart';
import '../widget/product/bottom_buy_navbar_component.dart';

class ChipOfVariantComponent extends StatefulWidget {
  final List<ProductVariant> itemVariant;

  const ChipOfVariantComponent({required this.itemVariant, super.key});

  @override
  State<ChipOfVariantComponent> createState() => _ChipOfVariantComponentState(chipOfItemVariant: itemVariant);
}

class _ChipOfVariantComponentState extends State<ChipOfVariantComponent> {
  List<String> variantSelected = [];
  final List chipOfItemVariant;

  _ChipOfVariantComponentState({required this.chipOfItemVariant});

  List<Widget> generateVariant(List productVariants) {
    List<Widget> widgets = [];

    for (var variant in productVariants) {
      widgets.add(
          InputChip(
            label: Text(
              variant.label,
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
                  variantSelected.add(variant.id);
                } else {
                  variantSelected.removeWhere( (item) => item == variant.id );
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
          padding: const EdgeInsets.only(left: 14, right: 14, bottom: 20),
          child: Wrap(
            spacing: 8.0, // gap between adjacent chips
            runSpacing: 4.0, // gap between lines
            children: generateVariant(chipOfItemVariant),
          ),
        ),
        BottomBuyNavbarComponent(variantSelected: variantSelected),
      ],
    );
  }
}