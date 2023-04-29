import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../components/bottom_navigation_bar.dart';
import '../components/drawer_component.dart';
import '../components/card_component.dart';

class FreeCodeCamp extends StatefulWidget {
  const FreeCodeCamp({super.key});

  @override
  State<FreeCodeCamp> createState() => _FreeCodeCampState();
}

class _FreeCodeCampState extends State<FreeCodeCamp> {
  Future fetchData() async {
    var respond = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(respond.body);

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Null"),
      ),
      drawer: const DrawerComponent(),
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Center(
                child: Text("Nothing Got Fecthed"),
              );
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              return snapshot.hasError
                  ? const Center(
                      child: Text("Error Found"),
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: CardComponent(
                                textInput: snapshot.data[index]["title"],
                                thumbNail: snapshot.data[index]["thumbnailUrl"],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: snapshot.data.length,
                    );
            default:
              return const Center(
                child: Text("Default return"),
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        child: const Icon(Icons.refresh),
      ),
      bottomNavigationBar: const BottomNavComponent(2),
    );
  }
}
