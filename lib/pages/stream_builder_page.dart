import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../components/bottom_navigation_bar.dart';
import '../components/drawer_component.dart';

class StreamBuilderPage extends StatefulWidget {
  StreamBuilderPage({super.key});

  @override
  State<StreamBuilderPage> createState() => _StreamBuilderPageState();
}

class _StreamBuilderPageState extends State<StreamBuilderPage> {
  Stream<List<String>> getStream() {
    var data = Stream<List<String>>.fromIterable(
        [List<String>.generate(20, (index) => "Item $index")]);
    
    return data;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Null"),
      ),
      drawer: const DrawerComponent(),
      body: StreamBuilder(
        stream: getStream(),
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
                        return ListTile(
                          title: Text(snapshot.data![index]),
                        );
                      },
                      itemCount: snapshot.data?.length,
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
      bottomNavigationBar: const BottomNavComponent(1),
    );
  }
}
