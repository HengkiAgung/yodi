import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/bloc/seller_bloc.dart';
import '../widget/seller/top_seller_list_widget.dart';
import '../bloc/product/product_bloc.dart';
import '../bloc/user/user_bloc.dart';
import '../widget/product/product_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetProductList());
    context.read<SellerBloc>().add(GetSellerList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Top Seller",
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const TopSellerListWidget(),
            Text(
              "Product Dari Seller",
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const ProductListWidget(),
          ],
        ),
      ),
    );
  }
}
