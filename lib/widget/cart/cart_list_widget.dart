import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletons/skeletons.dart';
import 'package:yodi/model/cart_variant_model.dart';

import '../../bloc/cart/cart_bloc.dart';
import '../../model/cart_model.dart';
import '../../screen/cart_shipping_screen.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  List<String> selectedVariantProduct = [];
  List<String> cartId = [];
  List<Cart> globalCarts = [];
  int totalPrice = 0;

  void selectProduct(int product, bool isAdding) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Text("loading");
          } else if (state is CartLoadSuccess) {
            final carts = state.carts;
            globalCarts = carts;

            return ListView.builder(
              itemCount: carts.length,
              itemBuilder: (BuildContext context, int index) {
                final cart = carts[index];
                int cartVariantLenght = cart.cartVariant.length;

                // ANCHOR cart per seller
                return Container(
                  height: 50 + cartVariantLenght * 180,
                  width: double.infinity,
                  color: Colors.white,
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            value: cartId.contains(cart.id) ? true : false,
                            onChanged: (bool? value) {
                              setState(() {
                                value == true
                                    ? cartId.add(cart.id)
                                    : cartId.removeWhere((item) => item == cart.id);

                                for (var element in cart.cartVariant) {
                                  if (value == true && !selectedVariantProduct.contains(element.id)) {
                                    selectedVariantProduct.add(element.id);
                                    totalPrice += element.itemVariant.price * element.amount;
                                  } else if (value == false && selectedVariantProduct.contains(element.id)) {
                                    selectedVariantProduct.removeWhere((item) => item == element.id);
                                    totalPrice = totalPrice - (element.itemVariant.price * element.amount);
                                  }
                                }
                              });
                            },
                          ),
                          Row(
                            children: [
                              cart.product.seller?.user.image != ""
                                  ? CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          cart.product.seller?.user.image ??
                                              ""))
                                  : const CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "images/profile_placeholder.jpg"),
                                    ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cart.product.seller?.user.username ?? "",
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      cart.product.seller?.city ?? "",
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: cartVariantLenght * 180,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cartVariantLenght,
                            itemBuilder: (BuildContext context, int index) {
                              final cartVariant = cart.cartVariant[index];

                              // ANCHOR cart per variant
                              return Container(
                                height: 180,
                                alignment: AlignmentDirectional.topStart,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          checkColor: Colors.white,
                                          value: selectedVariantProduct
                                                  .contains(cartVariant.id)
                                              ? true
                                              : false,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              if (value == true) {
                                                selectedVariantProduct.add(cartVariant.id);


                                                cartId.add(cart.id);
                                                for (var element in cart.cartVariant) {
                                                  if (!selectedVariantProduct.contains(element.id)) {
                                                    cartId.removeWhere((item) => item == cart.id);
                                                  }
                                                }

                                                totalPrice += cartVariant.itemVariant.price * cartVariant.amount;
                                              } else {
                                                selectedVariantProduct.removeWhere((item) => item == cartVariant.id);
                                                cartId.removeWhere((item) => item == cart.id);
                                                
                                                totalPrice -= cartVariant.itemVariant.price * cartVariant.amount;
                                              }
                                            });
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: FadeInImage(
                                            height: 80,
                                            width: 80,
                                            placeholder: const AssetImage("images/loading.gif"),
                                            image: NetworkImage(
                                                cart.product.itemImage[0]),
                                          ),
                                        ),
                                        Container(
                                          alignment:
                                              AlignmentDirectional.topStart,
                                          height: 80,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                // FIXME width static belum menyesuaikan screen
                                                width: 230,
                                                child: Text(
                                                  cart.product.title,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 15,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Text("Variant: ${cartVariant.itemVariant.label}",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.grey,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              Text(
                                                "Rp ${cartVariant.itemVariant.price.toString()}",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 13.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                              top: 8,
                                              bottom: 8,
                                              left: 7,
                                              right: 7,
                                            ),
                                            margin: const EdgeInsets.only(left: 40),
                                            child: Text(
                                              'Detail Product',
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Color.fromARGB(255, 231, 173, 0),
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Icon(Icons.delete_outline_rounded, color: Colors.grey[600], size: 25,),
                                          SizedBox(width: 10,),
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey),
                                              borderRadius: BorderRadius.all(Radius.circular(10))
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: Text(
                                                    "-",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: Text(
                                                    cartVariant.amount.toString(),
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: Text(
                                                    "+",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.amber,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Text("Ada error");
          }
        },
      ),
      bottomSheet: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Color.fromARGB(68, 158, 158, 158), width: 1),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Total Harga"),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Rp ${totalPrice.toString()}"),
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                      CartShippingScreen(carts: globalCarts, cartId: cartId, selectedVariantProduct: selectedVariantProduct),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 40,
                  right: 40,
                ),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Beli (${selectedVariantProduct.length})',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
