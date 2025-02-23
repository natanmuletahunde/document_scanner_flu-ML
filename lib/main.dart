import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

void main() {
  runApp(ImageFilterApp());
}

class ImageFilterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image Filter App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ImageFilterScreen(),
    );
  }
}

class ImageFilterScreen extends StatefulWidget {
  @override
  _ImageFilterScreenState createState() => _ImageFilterScreenState();
}

class _ImageFilterScreenState extends State<ImageFilterScreen> {
  File? _image;
  Uint8List? _filteredImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _filteredImage = null; // Reset filtered image when new image is selected
      });
    }
  }

  Future<void> _applyFilter(String filterType) async {
    if (_image == null) return;

    final imageBytes = await _image!.readAsBytes();
    img.Image originalImage = img.decodeImage(imageBytes)!;

    img.Image filteredImage;
    switch (filterType) {
      case 'grayscale':
        filteredImage = img.grayscale(originalImage);
        break;
      case 'sepia':
        filteredImage = img.sepia(originalImage);
        break;
      case 'invert':
        filteredImage = img.invert(originalImage);
        break;
      case 'brightness':
        filteredImage = img.adjustColor(originalImage, gamma: 1.2); // Increase brightness
        break;
      default:
        return;
    }

    setState(() {
      _filteredImage = Uint8List.fromList(img.encodePng(filteredImage));
    });
  }

  Future<void> _saveImage() async {
    if (_filteredImage == null) return;

    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/filtered_image.png';
    File file = File(filePath);
    await file.writeAsBytes(_filteredImage!);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Image saved to: $filePath')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Image Filter App")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _image == null
              ? Text("No image selected", style: TextStyle(fontSize: 18))
              : (_filteredImage != null
                  ? Image.memory(_filteredImage!, height: 300)
                  : Image.file(_image!, height: 300)),
          SizedBox(height: 20),
          Wrap(
            spacing: 10,
            children: [
              ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  child: Text("Pick from Gallery")),
              ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.camera),
                  child: Text("Take a Photo")),
            ],
          ),
          SizedBox(height: 20),
          Wrap(
            spacing: 10,
            children: [
              ElevatedButton(
                  onPressed: () => _applyFilter('grayscale'),
                  child: Text("Grayscale")),
              ElevatedButton(
                  onPressed: () => _applyFilter('sepia'),
                  child: Text("Sepia")),
              ElevatedButton(
                  onPressed: () => _applyFilter('invert'),
                  child: Text("Invert")),
              ElevatedButton(
                  onPressed: () => _applyFilter('brightness'),
                  child: Text("Brightness")),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(onPressed: _saveImage, child: Text("Save Image")),
        ],
      ),
    );
  }
}
