import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../repository/user_repository.dart';

class AddressAddWidget extends StatefulWidget {
  const AddressAddWidget({super.key});

  @override
  State<AddressAddWidget> createState() => _AddressAddWidgetState();
}

class _AddressAddWidgetState extends State<AddressAddWidget> {
  final _labelController = TextEditingController(text: "Rumah");
  final _cityController = TextEditingController();
  final _addressController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(top: 20, left: 13, right: 13),
        children: <Widget>[
          SizedBox(
            height: 90,
            child: Column(
              children: [
                TextField(
                  controller: _labelController,
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Label Alamat',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 90,
            child: Column(
              children: [
                TextField(
                  controller: _cityController,
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Kota',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 90,
            child: Column(
              children: [
                TextField(
                  controller: _addressController,
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Alamat Lengkap',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 90,
            child: Column(
              children: [
                TextField(
                  controller: _noteController,
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Catatan untuk kurir (opsional)',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Color.fromARGB(68, 158, 158, 158), width: 1),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 13, right: 13, top: 10, bottom: 10),
          child: GestureDetector(
            onTap: () => UserRepository().addUserAddress(context, _labelController.text, _cityController.text, _addressController.text, _noteController.text),
            child: Container(
              padding: const EdgeInsets.only(
                top: 3,
                bottom: 3,
                left: 15,
                right: 15,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  'Simpan',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}