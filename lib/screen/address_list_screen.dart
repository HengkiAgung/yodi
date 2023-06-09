import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yodi/widget/account/address_add_widget.dart';

import '../widget/account/address_list_widget.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  Widget chipOfWidget = const AddressListWidget();
  bool add = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Color.fromARGB(255, 226, 226, 226),
            height: 1,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            if (add) {
              add = false;
              setState(() => chipOfWidget = const AddressListWidget());
            } else {
              Navigator.pop(context);
            }
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Center(
              child: Text(
                "Daftar Alamat",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              add = true;
              setState(() => chipOfWidget = const AddressAddWidget());
            },
            child: add ? Spacer() :Padding(
              padding: const EdgeInsets.only(right: 13),
              child: Center(
                child: Text(
                  "Tambah Alamat",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.amber,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: chipOfWidget,
    );
  }
}
