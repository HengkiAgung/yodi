import 'package:flutter/material.dart';
import 'package:yodi/components/app_bar_component.dart';

import '../widget/history/history_transaction_widget.dart';
import '../widget/seller/seller_list_widget.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  final int index;
  const MainScreen({required this.index, super.key});

  @override
  State<MainScreen> createState() => _MainScreenState(bottomNavIndex: index);
}

class _MainScreenState extends State<MainScreen> {
  int bottomNavIndex = 0;

  _MainScreenState({required this.bottomNavIndex});

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
      bottomNavIndex = index;      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(),
      body: _listWidget[bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavBarTapped,
      ),
    );
  }
}
