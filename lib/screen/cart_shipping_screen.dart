// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/user_address/user_address_bloc.dart';
import '../model/cart_model.dart';
import '../widget/cart/cart_shipping_widget.dart';

class CartShippingScreen extends StatefulWidget { 
  final List<Cart> carts;
  final List<String> cartId;
  final List<String> selectedVariantProduct;

  const CartShippingScreen({required this.carts, required this.cartId, required this.selectedVariantProduct, super.key});

  @override
  State<CartShippingScreen> createState() => _CartShippingScreenState(carts: carts, cartId: cartId, selectedVariantProduct: selectedVariantProduct);
}

class _CartShippingScreenState extends State<CartShippingScreen> {
  final List<Cart> carts;
  final List<String> cartId;
  final List<String> selectedVariantProduct;

  _CartShippingScreenState({required this.carts, required this.cartId, required this.selectedVariantProduct});
  
  getSelectedVariantObject(){
    for (var cart in carts) {
      if (cartId.contains(cart.id)) {
        int index = 0;
        for (var cartVariant in cart.cartVariant) {
          if (!selectedVariantProduct.contains(cartVariant.id)) {
            cart.cartVariant.removeAt(index);
          }
          index++;
        }
      } else {
        carts.removeWhere((item) => item.id == cart.id);
      }
    }
    
    print(carts);
  }

  @override
  Widget build(BuildContext context) {
    context.read<UserAddressBloc>().add(GetAllAddressData());
    getSelectedVariantObject();
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
      body: const CartShippingWidget(),
    );
  }
}