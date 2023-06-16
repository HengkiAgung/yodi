import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yodi/model/address_model.dart';
import 'package:yodi/repository/shipper_repository.dart';

import '../../bloc/user_address/user_address_bloc.dart';
import '../../model/product_model.dart';
import '../../screen/payment_screen.dart';

class ProductShippingWidget extends StatefulWidget {
  final Product product;
  final String itemNote;
  final List<String> selectedVariantProduct;

  const ProductShippingWidget(
      {required this.product,
      required this.itemNote,
      required this.selectedVariantProduct,
      super.key});

  @override
  // ignore: no_logic_in_create_state
  State<ProductShippingWidget> createState() => _ProductShippingWidgetState(
      product: product,
      itemNote: itemNote,
      selectedVariantProduct: selectedVariantProduct);
}

class _ProductShippingWidgetState extends State<ProductShippingWidget> {
  final Product product;
  final String itemNote;
  final List<String> selectedVariantProduct;
  dynamic chosenShipper;
  num totalPrice = 0;

  Future<List> shipperdData() async {
    var respond = await ShipperRepository().getShipperData();

    return respond;
  }

  void shipperWidget() async {
    var shippers = await shipperdData();

    // ignore: use_build_context_synchronously
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 14, left: 14, top: 20, bottom: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Pilih Pengiriman',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 80*shippers.length.toDouble(),
                  padding: const EdgeInsets.only(right: 14, left: 14),
                  child: ListView.builder(
                    itemCount: shippers.length,
                    itemBuilder: (BuildContext context, int index) {
                      var shipper = shippers[index];

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (chosenShipper != shipper) {
                              totalPrice -= chosenShipper != null ? chosenShipper['price'] : 0;
                              totalPrice += shipper['price'];
                              chosenShipper = shipper;
                            }
                          });

                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 1.5, color: Colors.grey),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${shipper['name']} (Rp ${shipper['price']})",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${shipper['city']}",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }

  _ProductShippingWidgetState(
      {required this.product,
      required this.itemNote,
      required this.selectedVariantProduct});
  @override
  Widget build(BuildContext context) {
    if (totalPrice == 0) {
      for (var variantProduct in product.itemVariant) {
        if (selectedVariantProduct.contains(variantProduct.id)) {
          totalPrice += variantProduct.price;
        }
      }
    }

    Address address = new Address(id: "id", label: "label", city: "city", address: "address", note: "note");

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18.0, top: 8),
            child: Text("Alamat Pengiriman"),
          ),
          BlocBuilder<UserAddressBloc, UserAddressState>(
              builder: (context, state) {
            if (state is UserAddressLoading) {
              return const Text("Loading..");
            } else if (state is UserAddressLoadSuccess) {
              final userAddress = state.address;

              return Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                height: 150,
                child: ListView.builder(
                    padding: const EdgeInsets.all(13),
                    // FIXME address masi terbatas 1 saja, belum bisa dipilih semau user
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      address = userAddress[index];

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
                              SizedBox(
                                height: 5,
                              ),
                              Text('Kota: ${address.city}'),
                              SizedBox(
                                height: 5,
                              ),
                              Text('Alamat Lengkap: ${address.address}'),
                              SizedBox(
                                height: 5,
                              ),
                              // Text('Kode Pos: ${address.postalCode}'),
                            ],
                          ),
                        ),
                      );
                    }),
              );
            } else {
              return const Text('FATAL ERROR (FISH LIST)');
            }
          }),


          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Barang Yang DIbeli"),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.seller?.user.username ?? "",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
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
                  height: 180 * selectedVariantProduct.length.toDouble(),
                  child: ListView.builder(
                      itemCount: selectedVariantProduct.length,
                      itemBuilder: (BuildContext context, int index) {
                        for (var variantProduct in product.itemVariant) {
                          if (variantProduct.id ==
                              selectedVariantProduct[index]) {

                            return Container(
                              height: 150,
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
                                          placeholder: const AssetImage(
                                              "images/loading.gif"),
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
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text(
                                              "Variant: ${variantProduct.label}",
                                              style: GoogleFonts.poppins(
                                                color: Colors.grey,
                                                fontSize: 13,
                                              ),
                                            ),
                                            Text(
                                              "Rp ${variantProduct.price}",
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 13.0),
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
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
                            );
                          }
                        }
                      }),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => shipperWidget(),
            child: Container(
              margin: EdgeInsets.all(18),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black45),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.local_shipping),
                  SizedBox(
                    width: 20,
                  ),
                  chosenShipper == null ? Text("Pilih Pengiriman") : Text("${chosenShipper['name']} (Rp ${chosenShipper['price']})"),
                ],
              ),
            ),
          ),
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
                  Text("Rp ${totalPrice.toString()}"),
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                      PaymentScreen(price: totalPrice, product: product, itemNote: itemNote, selectedVariantProduct: selectedVariantProduct, chosenShipper: chosenShipper, address: address),
                  ),
                );
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
