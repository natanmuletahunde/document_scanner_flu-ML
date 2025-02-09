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
  final ImagePicker imagePicker = ImagePicker(); 

  Future<void> pickImageFromGallery() async {
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);  
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
      await performImageLabeling();
    }
  }

  Future<void> pickImageFromCamera() async {
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);  
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
      await performImageLabeling();
    }
  }

  Future<void> performImageLabeling() async {
    if (image == null) return;

    final inputImage = InputImage.fromFile(image!);
    final textRecognizer = TextRecognizer();
    
    try {
      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

      setState(() {
        result = '';
        for (TextBlock block in recognizedText.blocks) {
          for (TextLine line in block.lines) {
            result += line.text + '\n';
          }
          result += "\n\n";
        }
      });
    } catch (e) {
      setState(() {
        result = "Error recognizing text: $e";
      });
    } finally {
      textRecognizer.close();
    }
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
        child: Column(
          children: [
            Container(
              height: 280,
              width: 250,
              margin: EdgeInsets.only(top: 70),
              padding: EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Text(
                  result,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/note.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Image.asset(
                'assets/pin.png',
                height: 240,
                width: 240,
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  pickImageFromGallery();
                },
                onLongPress: () {
                  pickImageFromCamera();
                },
                child: Container(
                  margin: EdgeInsets.only(top: 25),
                  child: image != null
                      ? Image.file(
                          image!,
                          width: 140,
                          height: 192,
                          fit: BoxFit.fill,
                        )
                      : Container(
                          width: 240,
                          height: 200,
                          child: Icon(
                            Icons.camera_enhance_sharp,
                            size: 100,
                            color: Colors.grey,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
