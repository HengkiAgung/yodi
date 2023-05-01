import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DetailProductScreen extends StatefulWidget {
  final String idProduct;
  const DetailProductScreen({required this.idProduct, super.key});

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Product")),
      body: Container(
        child: Text("data"),
      ),
    );
  }
}