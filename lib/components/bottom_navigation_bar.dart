import 'dart:ffi';

import 'package:flutter/material.dart';

import '../pages/stream_builder_page.dart';
import '../pages/first_page.dart';
import '../pages/free_code_camp.dart';

class BottomNavComponent extends StatefulWidget {
  final int crntIndex;
  const BottomNavComponent(this.crntIndex, {super.key});

  @override
  State<BottomNavComponent> createState() => _BottomNavComponentState(crntIndex);
}

class _BottomNavComponentState extends State<BottomNavComponent> {
  _BottomNavComponentState(int crntIndex);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: "home",
            icon: Icon(
              Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            label: "setting",
            icon: Icon(Icons.settings),
          ),
          BottomNavigationBarItem(
            label: "CodeCamp",
            icon: Icon(Icons.account_circle),
          ),
        ],
        currentIndex: widget.crntIndex,
        onTap: (int index) {
          if (index != widget.crntIndex ) {
            Navigator.of(context).pop();
            if (index == 1) {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => StreamBuilderPage()),
              );
            } else if (index == 0) {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => FirstPage()),
              );
            } else if (index == 2) {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => FreeCodeCamp()),
              );
            }
          }
        },
      );
  }
}