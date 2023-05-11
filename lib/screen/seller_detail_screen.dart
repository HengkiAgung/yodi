import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:yodi/components/app_bar_component.dart';

import '../widget/seller/seller_detail_widget.dart';

class SellerDetailScreen extends StatefulWidget {
  const SellerDetailScreen({super.key});

  @override
  State<SellerDetailScreen> createState() => _SellerDetailScreenState();
}

class _SellerDetailScreenState extends State<SellerDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(),
      body: SellerDetailWidget(),
    );
  }
}