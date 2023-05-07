import 'package:flutter/material.dart';
import 'package:yodi/components/app_bar_component.dart';

import '../model/seller_model.dart';
import '../widget/cart/cart_widget.dart';
import '../widget/history/history_transaction_widget.dart';
import '../widget/seller/seller_list_widget.dart';
import '../widget/drawer_widget.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _bottomNavIndex = 0;

  final List<Widget> _listWidget = [
    const HomeScreen(),
    const SellerListWidget(),
    const HistoryTransactionWidget(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(
    icon: Icon(Icons.handshake_outlined), label: 'Seller'),
    const BottomNavigationBarItem(
    icon: Icon(Icons.notes_rounded), label: 'Transaction'),
  ];

  void _onBottomNavBarTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(),
      body: _listWidget[_bottomNavIndex],
      drawer: const DrawerWidget(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavBarTapped,
      ),
    );
  }
}
