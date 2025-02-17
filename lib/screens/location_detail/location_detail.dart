import 'package:flutter/material.dart';
import 'package:free_code_camp_flu/screens/location_detail/text_section.dart';
class LocationDetail extends StatelessWidget {
  const LocationDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Hello'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        TextSection(Colors.red),
        TextSection(Colors.green),
        TextSection(Colors.blue),
        ],
      ),
    );
  }
}