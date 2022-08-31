import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';

import '../../data/models/detection.dart';

class DetectionHelperNotifier extends ChangeNotifier {
  Image? _detectionImage;
  bool _isStartDetect = false;
  List<ObjectDetected> _listObject = [];

  List<ObjectDetected> get listObject => _listObject;

  Image? get detectionImage => _detectionImage;

  bool get isStartDetect => _isStartDetect;

  Future<void> convertFileToImage(File imageFile) async {
    List<int> imageBase64 = imageFile.readAsBytesSync();
    String imageAsString = base64Encode(imageBase64);
    Uint8List uint8list = base64.decode(imageAsString);
    _detectionImage = Image.memory(uint8list);
    notifyListeners();
  }

  void startDetect(BuildContext context) async {
    _isStartDetect = true;
    await _detectJson(context);
    notifyListeners();
  }

  Future<void> _detectJson(BuildContext context) async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/data.json");
    Data test = Data.fromJson(jsonDecode(data));
    _listObject = test.objectDetected;
    notifyListeners();
  }
}
