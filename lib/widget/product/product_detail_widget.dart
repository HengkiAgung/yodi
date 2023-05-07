import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../bloc/product/product_bloc.dart';

class ProductDetailWidget extends StatefulWidget {
  const ProductDetailWidget({super.key});

  @override
  State<ProductDetailWidget> createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget> {
  @override
  Widget build(BuildContext context) {
    // return Text("adfasdfsa");
    return WillPopScope(
      onWillPop: () async {
        context.read<ProductBloc>().add(GetProductList());

        // Navigator.pop(context);
        return true;
      },
      child: Column(
        children: [
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Text('');
              } else if (state is ProductLoadSuccess) {
                final product = state.product[0];

                return Column(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(height: 400.0),
                      items: product.itemImage.map((image) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: double.infinity,
                              child: Image.network(
                                image,
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(top: 40, right: 14, left: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rp. ${product.itemVariant[0].price},00",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            child: Text(
                              product.title,
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 25, // Image radius
                                backgroundImage: NetworkImage(product
                                        .seller.user.image ??
                                    'https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg'),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.seller.user.username,
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.clip,
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      product.seller.city,
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Text(
                            product.description ?? "",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const Text('FATAL ERROR (FISH LIST)');
              }
            },
          ),
        ],
      ),
    );
  }
}
