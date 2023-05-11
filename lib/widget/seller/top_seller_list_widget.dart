import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/seller/seller_bloc.dart';
import '../../model/seller_model.dart';

class TopSellerListWidget extends StatefulWidget {
  const TopSellerListWidget({super.key});

  @override
  State<TopSellerListWidget> createState() => _TopSellerListWidgetState();
}

class _TopSellerListWidgetState extends State<TopSellerListWidget> {
  List<Widget> listOfTopSeller(List<Seller> sellers){
    List<Widget> widgetSeller = [];

    for (var seller in sellers) {
      print(seller.user.image);
      widgetSeller.add(Padding(
        padding: const EdgeInsets.all(8.0),

        // event listener when clicked
        child: GestureDetector(
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (BuildContext context) =>
            //         DetailProductScreen(idProduct: product.id),
            //   ),
            // );
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
                    width: 100,
                    child: seller.user.image != "" ? FadeInImage(
                      placeholder: const AssetImage("images/loading.gif"),
                      image: NetworkImage(seller.user.image!),
                    ) : const FadeInImage(
                      placeholder: AssetImage("images/loading.gif"),
                      image: AssetImage("images/profile_placeholder.jpg"),
                    ),
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
                          seller.user.username,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          seller.city,
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
      ));
    }
    return widgetSeller;
  } 
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerBloc, SellerState>(
      builder: (context, state) {
        if (state is SellerLoading) {
          return const Text("");
        } else if (state is SellerLoadSuccess) {
          final sellers = state.seller;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child:Row(
              children: listOfTopSeller(sellers),
            ),
          );
        } else {
          return const Text('FATAL ERROR (FISH LIST)');
        }
      },
    );
  }
}