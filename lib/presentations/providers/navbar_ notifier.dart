import 'package:flutter/cupertino.dart';

class NavbarNotifier with ChangeNotifier {
  int _index = 0;
  bool isActive = false;

  int get index => _index;

  set setIndex(int index) {
    _index = index;
    notifyListeners();
  }
}
