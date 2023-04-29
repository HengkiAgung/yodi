import 'dart:ffi';

import 'package:flutter/material.dart';

import '../components/bottom_navigation_bar.dart';
import '../components/drawer_component.dart';

class FirstPage extends StatefulWidget {
  FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String buttonName = "Click";
  bool showImage = false;
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Null"),
      ),
      drawer: const DrawerComponent(), 
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              !showImage
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.amber,
                          ),
                          onPressed: () {
                            setState(() {
                              buttonName = "Clicked";
                            });
                          },
                          child: Text(buttonName),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              buttonName = "Clicked";
                            });
                          },
                          child: Text("$buttonName 2"),
                        ),
                      ],
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          isClicked = !isClicked;
                        });
                      },
                      child: isClicked
                          ? Image.asset('images/logo.jpg')
                          : Image.network(
                              "https://media.sproutsocial.com/uploads/2017/02/10x-featured-social-media-image-size.png",
                            ),
                    ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 255, 255, 255),
                  backgroundColor: Color.fromARGB(255, 2, 103, 19),
                ),
                onPressed: () {
                  setState(() {
                    showImage = !showImage;
                  });
                },
                child: const Text("Image"),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavComponent(0),
    );
  }
}
