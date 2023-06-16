import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/product/bottom_buy_navbar_component.dart';
import '../bloc/product/product_bloc.dart';
import '../repository/product_repository.dart';
import '../components/app_bar_component.dart';
import '../widget/product/product_detail_widget.dart';
import 'home_screen.dart';

class DetailProductScreen extends StatefulWidget {
  final String idProduct;
  final String idSeller;
  final bool isNotSeller;

  const DetailProductScreen({required this.idProduct, this.isNotSeller = true, this.idSeller = "", super.key});

  @override
  State<DetailProductScreen> createState() =>
      _DetailProductScreenState(idProduct: idProduct, isNotSeller: isNotSeller);
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  final String idProduct;
  final bool isNotSeller;
  final String idSeller;
  bool isVariantOpened = false;

  _DetailProductScreenState({required this.idProduct, this.idSeller = "", required this.isNotSeller,});

  @override
  void initState() {
    super.initState();

    context.read<ProductBloc>().add(GetProductDetail(idProduct: idProduct));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(isNotSeller: isNotSeller, idSeller: idSeller),
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: const [
              SingleChildScrollView(
                child: ProductDetailWidget(),
              ),
            ],
          ),
        ),
      ]),
      bottomNavigationBar: BottomBuyNavbarComponent(variantSelected: [], isOpened: false,),
    );
  }
}
