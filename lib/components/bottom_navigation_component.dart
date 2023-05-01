import 'dart:ffi';

import 'package:flutter/material.dart';

import '../screen/home_screen.dart';
import '../screen/cart_screen.dart';

class BottomNavigationComponent extends StatefulWidget {
  final int crntIndex;
  const BottomNavigationComponent(this.crntIndex, {super.key});

  @override
  State<BottomNavigationComponent> createState() => _BottomNavComponentState(crntIndex);
}

class _BottomNavComponentState extends State<BottomNavigationComponent> {
  _BottomNavComponentState(int crntIndex);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(
              Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            label: "Cart",
            icon: Icon(Icons.shopping_cart_outlined),
          ),
        ],
        currentIndex: widget.crntIndex,
        onTap: (int index) {
          if (index != widget.crntIndex ) {
            Navigator.of(context).pop();
            if (index == 0) {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => const HomeScreen()),
              );
            } else if (index == 1) {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => const CartScreen()),
              );
            }
          }
        },
      );
  }
}