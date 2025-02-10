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
      performImageLabeling();
    }
  }

  Future<void> pickImageFromCamera() async {
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);  
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
      performImageLabeling();
    }
  }

  Future<void> performImageLabeling() async {
    if (image == null) return;

    final inputImage = InputImage.fromFile(image!);
    final textRecognizer = TextRecognizer();
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

    textRecognizer.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/back.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 280,
              width: 250,
              margin: const EdgeInsets.only(top: 50),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/note.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView(
                child:Padding(padding: EdgeInsets.all(12),
                 child: Text(
                  result,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              child: image != null
                  ? Image.file(
                      image!,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : const Icon(
                      Icons.camera_alt,
                      size: 80,
                      color: Colors.grey,
                    ),
            ),

            const SizedBox(height: 20),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: pickImageFromGallery,
                  icon: const Icon(Icons.image),
                  label: const Text("Gallery"),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: pickImageFromCamera,
                  icon: const Icon(Icons.camera),
                  label: const Text("Camera"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
