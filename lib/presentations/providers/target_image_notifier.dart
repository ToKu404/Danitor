import 'dart:io';
import 'package:danitor/core/themes/color_const.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
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

  Future<void> cropImage() async {
    if (_image != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _image!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Pangkas Gambar',
              toolbarColor: kGreen,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              backgroundColor: kGreyDark,
              statusBarColor: kGreen,
              activeControlsWidgetColor: kGreen,
              lockAspectRatio: false),
        ],
      );
      if (croppedFile != null) {
        _image = File(croppedFile.path);
      }
      notifyListeners();
    }
  }
}
