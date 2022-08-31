import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TargetImageNotifier extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();

  File? _image;


  File? get image => _image;


  Future<void> onImageButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
      );
      _image = File(pickedFile!.path);
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
