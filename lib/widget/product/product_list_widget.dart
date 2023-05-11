import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../bloc/product/product_bloc.dart';
import '../../components/skeleton_product_list_component.dart';
import '../../screen/product_detail_screen.dart';

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const SkeletonProductListComponent();
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
                      // height: 100,
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
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                            child: Container(
                              height: 190,
                              width: double.infinity,
                              child: FadeInImage(
                                placeholder:
                                    const AssetImage("images/loading.gif"),
                                image: NetworkImage(product.itemImage[0]),
                              ),
                            ),
                          ),

                          // content of product card
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    product.title,
                                    style: const TextStyle(fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Rp. ${product.itemVariant[0].price}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
