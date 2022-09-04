import 'package:flutter/material.dart';

class DetectionResultHelper extends ChangeNotifier {
  DetectionResultHelper() {
    _resultIndex = 0;
  }

  int _resultIndex = 0;

  int get resultIndex => _resultIndex;

  void changeResultIndex(int index) {
    _resultIndex = index;
    notifyListeners();
  }
}
