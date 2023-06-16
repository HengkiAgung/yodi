// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/user_address/user_address_bloc.dart';
import '../model/address_model.dart';
import '../model/product_model.dart';
import '../widget/payment/payment_widget.dart';
import '../widget/product/product_shipping_widget.dart';


class PaymentScreen extends StatefulWidget { 
  final num price;
  final Product product;
  final String itemNote;
  final List<String> selectedVariantProduct;
  final dynamic chosenShipper;
  final Address address;
  
  PaymentScreen({required this.price, required this.product, required this.itemNote, required this.selectedVariantProduct, required this.chosenShipper, required this.address, super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState(price: price, product: product, itemNote: itemNote, selectedVariantProduct: selectedVariantProduct, chosenShipper: chosenShipper, address: address);
}

class _PaymentScreenState extends State<PaymentScreen> {
  final num price;
  final Product product;
  final String itemNote;
  final List<String> selectedVariantProduct;
  final dynamic chosenShipper;
  final Address address;
  
  _PaymentScreenState({required this.price, required this.product, required this.itemNote, required this.selectedVariantProduct, required this.chosenShipper, required this.address});

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
                "Payment",
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
      body: PaymentWidget(price: price, product: product, itemNote: itemNote, selectedVariantProduct: selectedVariantProduct, chosenShipper: chosenShipper, address: address),
    );
  }
}