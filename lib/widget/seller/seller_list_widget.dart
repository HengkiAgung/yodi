import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yodi/screen/seller_detail_screen.dart';

import '../../bloc/seller/seller_bloc.dart';
import '../../model/product_model.dart';
import '../../screen/product_detail_screen.dart';

class SellerListWidget extends StatefulWidget {
  const SellerListWidget({super.key});

  @override
  State<SellerListWidget> createState() => _SellerListWidgetState();
}

class _SellerListWidgetState extends State<SellerListWidget> {

  void initState() {
    super.initState();
    context.read<SellerBloc>().add(GetSellerList());
  }
  
  List<Widget> productOfSeller(List<Product> products){
    List<Widget> listProductSeller = [];
    for (var product in products) {
      listProductSeller.add(
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        DetailProductScreen(idProduct: product.id),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: FadeInImage(
                      width: 100,
                      height: 100,
                      placeholder: AssetImage("images/loading.gif"),
                      image: NetworkImage(product.itemImage[0]),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Rp ${product.itemVariant[0].price}",
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return listProductSeller;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerBloc, SellerState>(
      builder: (context, state) {
        if (state is SellerLoading) {
          return const Text("Loading..");
        } else if (state is SellerLoadSuccess) {
          final sellers = state.seller;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: sellers.length,
            itemBuilder: (BuildContext context, int index) {
              final seller = sellers[index];

              return Padding(
                padding: const EdgeInsets.only(top: 6, bottom: 6),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(220, 219, 219, 219),
                        blurRadius: 2,
                        offset: Offset(0, 0), // Shadow position
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            seller.user.image != "" ?
                            CircleAvatar(
                              backgroundImage: NetworkImage(seller.user.image ?? "")
                            )
                            :
                            const CircleAvatar(
                              backgroundImage: AssetImage("images/profile_placeholder.jpg"),
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
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const SellerDetailScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 8,
                                  left: 7,
                                  right: 7,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color.fromARGB(255, 0, 150, 5)),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'Detail Seller',
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 150, 5),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: productOfSeller(seller.product ?? []),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Text('FATAL ERROR (FISH LIST)');
        }
      },
    );
  }
}