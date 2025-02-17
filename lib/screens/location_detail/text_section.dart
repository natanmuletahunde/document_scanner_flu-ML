import 'package:flutter/material.dart';
class TextSection extends StatelessWidget {
  const TextSection({super.key});

  @override
  Widget build(BuildContext context) {
    return   Container(
            decoration: BoxDecoration(
              color: Colors.red
            ),
            child: Text('hi'),  
          );
  }
}