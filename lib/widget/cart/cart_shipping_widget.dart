import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/user_address/user_address_bloc.dart';

class CartShippingWidget extends StatefulWidget {
  const CartShippingWidget({super.key});

  @override
  State<CartShippingWidget> createState() => _CartShippingWidgetState();
}

class _CartShippingWidgetState extends State<CartShippingWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserAddressBloc, UserAddressState>(
      builder: (context, state) {
        if (state is UserAddressLoading) {
          return const Text("Loading..");
        } else if (state is UserAddressLoadSuccess) {
          final userAddress = state.address;

          return ListView.builder(
            padding: const EdgeInsets.all(13),
            itemCount: userAddress.length,
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
          );
        } else {
          return const Text('FATAL ERROR (FISH LIST)');
        }
      }
    );
  }
}