import 'package:flutter/material.dart';

class CardComponent extends StatelessWidget {
  const CardComponent({
    super.key,
    required this.textInput,
    required this.thumbNail,
  });

  final String textInput;
  final String thumbNail;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Image.network(thumbNail),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(textInput),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "enter input",
                labelText: "input",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
