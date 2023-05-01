import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/product/product_bloc.dart';
import '../components/app_bar_component.dart';
import '../widget/product_detail_widget.dart';
import '../widget/variant_widget.dart';
import 'home_screen.dart';

class DetailProductScreen extends StatefulWidget {
  final String idProduct;
  const DetailProductScreen({required this.idProduct, super.key});

  @override
  State<DetailProductScreen> createState() =>
      _DetailProductScreenState(idProduct: idProduct);
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  final String idProduct;
  bool isVariantOpened = false;

  _DetailProductScreenState({required this.idProduct});

  @override
  void initState() {
    super.initState();

    context.read<ProductBloc>().add(GetProductDetail(idProduct: idProduct));
  }

  void varianMethod(bool click, int index) {
    setState(() {
      print("diklik");
      if (isVariantOpened) {
        if (index == 0) {
          // tambah ke keranjang
        } else {
          // langsung beli
        }

      }
      isVariantOpened = click;
    });
  }

  Widget _bottomBavBar() {
    return Container(
      height: 70,
      color: Colors.white,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              varianMethod(true, 0);
            },
            child: Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: const Icon(
                Icons.shopping_cart,
                size: 30,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: InkWell(
              onTap: () {
                varianMethod(true, 1);
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'Beli Sekarang',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stackVariant() {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        // backgound opacity black on stack
        Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Color.fromARGB(136, 0, 0, 0),
          ),
        ),
        
        // main content variant
        Container(
          padding: const EdgeInsets.only(right: 14, left: 14),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Text('');
              } else if (state is ProductLoadSuccess) {
                final product = state.product[0];

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {varianMethod(false, 0);},
                              child: const Icon(
                                Icons.close,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Varian baju',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Rp. ${product.price},00",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Wrap(
                        spacing: 8.0, // gap between adjacent chips
                        runSpacing: 4.0, // gap between lines
                        children: const [
                          Chip(
                            label: Text('Hamilton'),
                          ),
                          Chip(
                            label: Text('Lafayette'),
                          ),
                          Chip(
                            label: Text('MulliganMulliganMulliganMullig'),
                          ),
                          Chip(
                            label: Text('Laurens'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                );
              } else {
                return const Text('FATAL ERROR (FISH LIST)');
              };
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(
        backScreen: HomeScreen(),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: const [
                SingleChildScrollView(
                  child: ProductDetailWidget(),
                ),
              ],
            ),
          ),
          isVariantOpened ? _stackVariant() : const SizedBox(),
        ]
      ),
      bottomNavigationBar: _bottomBavBar(),
    );
  }
}
