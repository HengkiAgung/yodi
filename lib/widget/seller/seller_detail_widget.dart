import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/product/product_bloc.dart';
import '../../bloc/seller/seller_bloc.dart';

class SellerDetailWidget extends StatelessWidget {
  const SellerDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<ProductBloc>().add(GetProductList());
        context.read<SellerBloc>().add(GetSellerList());

        return true;
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 13, bottom: 13, top: 20),
        child: Column(
          children: [
            BlocBuilder<SellerBloc, SellerState>(builder: (context, state) {
              if (state is SellerLoading) {
                return const Text('Loading...');
              } else if (state is SellerLoadSuccess) {
                final seller = state.seller[0];
          
                return Row(
                  children: [
                    seller.user.image != ""
                        ? CircleAvatar(
                            radius: 25, // Image radius
                            backgroundImage: NetworkImage(seller.user.image ?? ""))
                        : const CircleAvatar(
                            radius: 25, // Image radius
                            backgroundImage:
                                AssetImage("images/profile_placeholder.jpg"),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            seller.user.username,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            seller.city,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                  ],
                );
              } else {
                return const Text('');
              }
            })
          ],
        ),
      ),
    );
  }
}
