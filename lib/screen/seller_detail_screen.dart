import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/product/product_bloc.dart';
import '../components/app_bar_component.dart';
import '../bloc/seller/seller_bloc.dart';
import '../widget/product/product_list_widget.dart';
import '../widget/seller/seller_detail_widget.dart';

class SellerDetailScreen extends StatefulWidget {
  String idSeller;

  SellerDetailScreen({required this.idSeller, super.key});

  @override
  State<SellerDetailScreen> createState() => _SellerDetailScreenState(idSeller: idSeller);
}

class _SellerDetailScreenState extends State<SellerDetailScreen> {
  String idSeller;
  _SellerDetailScreenState({required this.idSeller});

  @override
  void initState() {
    super.initState();

    context.read<ProductBloc>().add(GetProductBySeller(idSeller: idSeller));
    context.read<SellerBloc>().add(GetSellerDetail(idSeller: idSeller));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SellerDetailWidget(),
            Padding(
              padding: const EdgeInsets.only(left: 13.0, top: 20),
              child: Text(
                "Product Dari Seller",
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            ProductListWidget(isNotSeller: false,idSeller: idSeller),
          ],
        ),
      ),
    );
  }
}