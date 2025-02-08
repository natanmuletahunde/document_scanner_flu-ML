import 'dart:io';  
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; 
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String result = "";
  File? image;
  final ImagePicker imagePicker = ImagePicker(); 

  pickImageFromGallery() async {
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);  
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

   pickImageFromCamera() async {
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);  
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
