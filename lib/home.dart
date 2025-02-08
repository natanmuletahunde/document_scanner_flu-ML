import 'dart:io';  
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart'; 
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String result = "";
  File? image;
  ImagePicker imagePicker = ImagePicker(); 

  pickImageFromGallery() async {
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);  
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
        perfomrImageLabeling();
      });
    }
  }

   pickImageFromCamera() async {
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);  
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
        perfomrImageLabeling();
      });
    }
  }
    perfomrImageLabeling() async {
    final inputImage = InputImage.fromFile(image!);
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    result = '';
    setState(() {
      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          result += line.text + '\n';
        }
        result += "\n\n";
      }
    });

    textRecognizer.close();
  }

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
  body: Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/back.jpg'),
        fit: BoxFit.cover,
      ),
    ),
  ),
);

  }
}
