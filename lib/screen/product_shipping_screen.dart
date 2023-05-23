// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/user_address/user_address_bloc.dart';
import '../model/product_model.dart';
import '../widget/product/product_shipping_widget.dart';


class ProductShippingScreen extends StatefulWidget { 
  final Product product;
  final String itemNote;
  final List<String> selectedVariantProduct;

  const ProductShippingScreen({required this.product, required this.itemNote, required this.selectedVariantProduct, super.key});

  @override
  State<ProductShippingScreen> createState() => _ProductShippingScreenState(product: product, itemNote: itemNote, selectedVariantProduct: selectedVariantProduct);
}

class _ProductShippingScreenState extends State<ProductShippingScreen> {
  final Product product;
  final String itemNote;
  final List<String> selectedVariantProduct;

  _ProductShippingScreenState({required this.product, required this.itemNote, required this.selectedVariantProduct});


  @override
  Widget build(BuildContext context) {
    context.read<UserAddressBloc>().add(GetAllAddressData());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: const Color.fromARGB(255, 226, 226, 226),
            height: 1,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Center(
              child: Text(
                "Shipping",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const Spacer()
        ],
      ),
      body: ProductShippingWidget(product: product, itemNote: itemNote, selectedVariantProduct: selectedVariantProduct),
    );
  }
}