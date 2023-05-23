import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/user_address/user_address_bloc.dart';
import '../../model/product_model.dart';

class ProductShippingWidget extends StatefulWidget {
  final Product product;
  final String itemNote;
  final List<String> selectedVariantProduct;

  const ProductShippingWidget({required this.product, required this.itemNote, required this.selectedVariantProduct, super.key});

  @override
  // ignore: no_logic_in_create_state
  State<ProductShippingWidget> createState() => _ProductShippingWidgetState(product: product, itemNote: itemNote, selectedVariantProduct: selectedVariantProduct);
}

class _ProductShippingWidgetState extends State<ProductShippingWidget> {
  final Product product;
  final String itemNote;
  final List<String> selectedVariantProduct;
  
  _ProductShippingWidgetState({required this.product, required this.itemNote, required this.selectedVariantProduct});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Text("Alamat Pengiriman"),
          BlocBuilder<UserAddressBloc, UserAddressState>(
            builder: (context, state) {
              if (state is UserAddressLoading) {
                return const Text("Loading..");
              } else if (state is UserAddressLoadSuccess) {
                final userAddress = state.address;
    
                return Container(
                  height: 150,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(13),
                
                    // FIXME address masi terbatas 1 saja, belum bisa dipilih semau user
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      final address = userAddress[index];
                
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey), 
                          borderRadius: BorderRadius.circular(5), 
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(13),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                address.label,
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 51, 51, 51),
                                ),
                              ),
                              SizedBox(height: 5,),
                              Text('Kota: ${address.city}'),
                              SizedBox(height: 5,),
                              Text('Alamat Lengkap: ${address.address}'),
                              SizedBox(height: 5,),
                              // Text('Kode Pos: ${address.postalCode}'),
                            ],
                          ),
                        ),
                      );
                    }
                  ),
                );
              } else {
                return const Text('FATAL ERROR (FISH LIST)');
              }
            }
          ),
          // TODO ubah jadi listview builder karena setiap variant punya component sendiri
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Barang Yang DIbeli"),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.seller?.user.username ?? "",
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      product.seller?.city ?? "",
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 180,
                alignment: AlignmentDirectional.topStart,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: FadeInImage(
                            height: 80,
                            width: 80,
                            placeholder: const AssetImage("images/loading.gif"),
                            image: NetworkImage(
                                product.itemImage[0]),
                          ),
                        ),
                        Container(
                          alignment:
                              AlignmentDirectional.topStart,
                          height: 80,
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                // FIXME width static belum menyesuaikan screen
                                width: 230,
                                child: Text(
                                  product.title,
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                  ),
                                  overflow:
                                      TextOverflow.ellipsis,
                                ),
                              ),
                              Text("Variant: ",
                                style: GoogleFonts.poppins(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                "Rp ",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13.0),
                      child: Row(
                        children: [
                          Spacer(),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    "-",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    "1",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    "+",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Text("Pengiriman"),
          
        ],
      ),
      bottomSheet: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Color.fromARGB(68, 158, 158, 158), width: 1),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Total Harga"),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Rp totalPrice.toString()"),
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {

                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (BuildContext context) =>
                //       // CartShippingScreen(carts: globalCarts, cartId: cartId, selectedVariantProduct: selectedVariantProduct),
                //   ),
                // );
              },
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 40,
                  right: 40,
                ),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Bayar',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}