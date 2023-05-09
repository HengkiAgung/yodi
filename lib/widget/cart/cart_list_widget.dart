import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletons/skeletons.dart';
import 'package:yodi/model/cart_variant_model.dart';

import '../../bloc/cart/cart_bloc.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  List<String> selectedVariantProduct = [];

  void selectProduct(int product, bool isAdding){
    
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const Text("loading");
        } else if (state is CartLoadSuccess) {
          final carts = state.carts;

          return ListView.builder(
            itemCount: carts.length,
            itemBuilder: (BuildContext context, int index) {
              final cart = carts[index];
              int cartVariantLenght = cart.cartVariant.length;
              
              // ANCHOR cart per seller
              return Container(
                height: 50+cartVariantLenght*200,
                width: double.infinity,
                color: Colors.white,
                child: ListView(              
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            // fillColor: MaterialStateProperty.resolveWith(getColor),
                            value: true,
                            onChanged: (bool? value) {
                              setState(() {
                                if (value == true) {
                                  // selectedVariantProduct.add();
                                } else {
                                  
                                }
                              });
                            },
                          ),
                          Text(
                            cart.product.seller?.user.username ?? "",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                
                        ],
                      ),
                      SizedBox(
                        height: cartVariantLenght*200,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cartVariantLenght,
                          itemBuilder: (BuildContext context, int index) {
                            bool? isChecked = false;
                            print(isChecked);
                            final cartVariant = cart.cartVariant[index];

                            // ANCHOR cart per variant
                            return Container(
                              height: 200,
                              alignment: AlignmentDirectional.topStart,
                              child: Row(
                                children: [
                                  Checkbox(
                                    checkColor: Colors.black,
                                    value: isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        print(value);
                                        // delete item from list
                                        // selectedProduct.removeWhere((item) => item == '001'); 
        
                                        // adding item into list
                                        if (value == true) {
                                          // selectedProduct.add("1");
                                        } 
                                        isChecked = value;
                                      });
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: FadeInImage(
                                      height: 80,
                                      width: 80,
                                      placeholder: AssetImage("images/loading.gif"),
                                      image: NetworkImage(cart.product.itemImage[0]),
                                    ),
                                  ),
                                  Container(
                                    alignment: AlignmentDirectional.topStart,
                                    height: 80,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          // FIXME width static belum menyesuaikan screen
                                          width: 230,
                                          child: Text(
                                            cart.product.title,
                                            style: GoogleFonts.poppins(
                                              fontSize: 18,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          cartVariant.itemVariant.label ?? "<undefined>",
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
                            );
                          }
                        ),
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
    );
  }
}