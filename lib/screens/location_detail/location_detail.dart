import 'package:flutter/material.dart';
class LocationDetail extends StatelessWidget {
  const LocationDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Hello'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.red
            ),
            child: Text('hi'),  
          ),
           Container(
            decoration: BoxDecoration(
              color: Colors.green
            ),
            child: Text('ki'),  
          ),
           Container(
            decoration: BoxDecoration(
              color: Colors.blue
            ),
            child: Text('ml'),  
          ),
        ],
      ),
    );
  }
}