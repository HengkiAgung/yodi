import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';

import '../bloc/product/product_bloc.dart';
import '../screen/detail_product_screen.dart';

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Text('load (FISH LIST)');
        } else if (state is ProductLoadSuccess) {
          final products = state.product;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.4),
              ),
              itemCount: products.length,
              itemBuilder: ((context, index) {
                final product = products[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),

                  // event listener when clicked
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              DetailProductScreen(idProduct: product.id),
                        ),
                      );
                    },
                    child: Container(
                      height: 1000,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 212, 212, 212),
                            blurRadius: 4,
                            offset: Offset(-2, 2), // Shadow position
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // thumbnail of product card
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(8),
                            ),
                            child: Image.network(
                              product.image,
                              fit: BoxFit.cover,
                            ),
                          ),

                          // content of product card
                          Padding(
                              padding: const EdgeInsets.all(10),
                              child: Wrap(
                                direction: Axis.vertical,
                                spacing: 5, // <-- Spacing between children
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      product.title,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Rp. ${product.price}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        } else {
          return const Text('FATAL ERROR (FISH LIST)');
        }
      },
    );
  }
}
