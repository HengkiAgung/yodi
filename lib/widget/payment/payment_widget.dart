import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../../config.dart';
import '../../model/address_model.dart';
import '../../model/product_model.dart';
import '../../screen/main_screen.dart';
import '../../utils/auth.dart';

class PaymentWidget extends StatefulWidget {
  final num price;
  final Product product;
  final String itemNote;
  final List<String> selectedVariantProduct;
  final dynamic chosenShipper;
  final Address address;
  
  PaymentWidget({required this.price, required this.product, required this.itemNote, required this.selectedVariantProduct, required this.chosenShipper, required this.address, super.key});

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState(price: price, product: product, itemNote: itemNote, selectedVariantProduct: selectedVariantProduct, chosenShipper: chosenShipper, address: address);
}

enum PaymentMethods { cod, briva, gopay, dana }

class _PaymentWidgetState extends State<PaymentWidget> {
  final num price;
  final Product product;
  final String itemNote;
  final List<String> selectedVariantProduct;
  final dynamic chosenShipper;
  final Address address;
  PaymentMethods? _paymentMethod = PaymentMethods.cod;
  
  _PaymentWidgetState({required this.price, required this.product, required this.itemNote, required this.selectedVariantProduct, required this.chosenShipper, required this.address});


  Future paymentRequest() async {
    try {
      String? token = await Auth().getToken();
      String _baseUrl =  Config.apiUrl;

      List itemVariant = [];

      for (var element in selectedVariantProduct) {
        itemVariant.add({"id": element, "amount": 1});
      }

      final response = await http.post(Uri.parse('$_baseUrl/user/order'), headers: {
        'Authorization': 'Bearer $token',
      }, body: jsonEncode({
        "itemId": product.id,
        "itemNote": itemNote,
        "addressId": address.id,
        "shipperId": chosenShipper["id"],
        "itemVariant": itemVariant,
      }));

      if (jsonDecode(response.body)["status"] == "success") {
        
        Navigator.of(context).pop();
        Navigator.of(context).pop();

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
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 14, left: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
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
                                  '',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          Text(
                            "Barang Berhasil Dibeli!!",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
  
      }

    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              children: const [
                Text(
                  "Metode Pembayaran",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  "Lihat Semua",
                  style: TextStyle(
                    color: Colors.amber,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),

            // COD
            Row(
              children: [
                Icon(Icons.wallet),
                SizedBox(
                  width: 20,
                ),
                Text("Cash On Delivery"),
                Spacer(),
                Radio(
                  value: PaymentMethods.cod,
                  groupValue: _paymentMethod,
                  onChanged: (PaymentMethods? value) {
                    setState(() {
                      _paymentMethod = value;
                    });
                  },
                ),
              ],
            ),

            // BRIVA
            Row(
              children: [
                Icon(Icons.wallet),
                SizedBox(
                  width: 20,
                ),
                Text("BRIVA"),
                Spacer(),
                Radio(
                  value: PaymentMethods.briva,
                  groupValue: _paymentMethod,
                  onChanged: (PaymentMethods? value) {
                    setState(() {
                      _paymentMethod = value;
                    });
                  },
                ),
              ],
            ),

            // Dana
            Row(
              children: [
                Icon(Icons.wallet),
                SizedBox(
                  width: 20,
                ),
                Text("Dana"),
                Spacer(),
                Radio(
                  value: PaymentMethods.dana,
                  groupValue: _paymentMethod,
                  onChanged: (PaymentMethods? value) {
                    setState(() {
                      _paymentMethod = value;
                    });
                  },
                ),
              ],
            ),

            // GOpay
            Row(
              children: [
                Icon(Icons.wallet),
                SizedBox(
                  width: 20,
                ),
                Text("GoPay"),
                Spacer(),
                Radio(
                  value: PaymentMethods.gopay,
                  groupValue: _paymentMethod,
                  onChanged: (PaymentMethods? value) {
                    setState(() {
                      _paymentMethod = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),

            // Ringkasan Pembayaran
            Row(
              children: const [
                Text(
                  "Ringkasan Pembayaran",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),

            Row(
              children: [
                Text("Total Belanja"),
                Spacer(),
                Text("Rp ${price.toString()}"),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text("Biaya Layanan"),
                Spacer(),
                Text("Rp 1000"),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text("Biaya Aplikasi"),
                Spacer(),
                Text("Rp 2000"),
              ],
            )
          ],
        ),
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
                  Text("Rp ${(price+3000).toString()}"),
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                paymentRequest();
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
