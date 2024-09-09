// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, sized_box_for_whitespace, avoid_print, avoid_unnecessary_containers, unused_field, unused_local_variable, use_build_context_synchronously, unused_element

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TestImageScreen extends StatefulWidget {
  const TestImageScreen({super.key});

  @override
  State<TestImageScreen> createState() => _TestImageScreenState();
}

class _TestImageScreenState extends State<TestImageScreen> {
  String? _base64Image;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      List<int> imageBytes = await imageFile.readAsBytes();
      setState(() {
        _base64Image = base64Encode(imageBytes);
        print(_base64Image);
      });
    } else {
      print("Nenhuma imagem selecionada");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Salvar e Exibir Imagem')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: pickImage,
            child: Text('Selecionar Imagem'),
          ),
          SizedBox(height: 20),
          _base64Image != null
              ? Image.memory(base64Decode(_base64Image!))
              : Text('Nenhuma imagem selecionada'),
        ],
      ),
    );
  }
}
