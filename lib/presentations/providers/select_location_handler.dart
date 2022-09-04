import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectLocationHandler extends ChangeNotifier {

  int _idLocation = -1;

  String _locationName = 'Destinasi Belum Diatur';

  int get idLocation => _idLocation;

  String get locationName => _locationName;

  List<String> _locationResult = [];
  List<String> get locationResult => _locationResult;

  Future<void> initId(int id) async {
    _idLocation = id;
    if (id == -1) {
      _locationName = 'Destinasi Belum Diatur';
    } else {
      _locationName = _destinationList[id];
    }
    notifyListeners();
  }

  void setIdLocation(String id) async {
    if (_destinationList.contains(id.toLowerCase().trim())) {
      _idLocation = _destinationList.indexOf(id.toLowerCase().trim());
      _locationName = _destinationList[_idLocation];
    } else {
      _idLocation = -1;
      _locationName = 'Destinasi Belum Diatur';
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('init', _idLocation);
    notifyListeners();
  }

  final List<String> _destinationList = [
    'bali',
    'raja ampat',
    'flores',
    'lombok',
    'kepulauan seribu',
    'bitung'
  ];

  void clearDestionation() {
    _locationResult.clear();
    notifyListeners();
  }

  void changePrefixLocation(String pref) {
    _locationResult = _destinationList
        .where((element) => element.startsWith(pref.toLowerCase()))
        .toList();
    if (locationResult.isEmpty) {
      _locationResult.add('Destinasi Belum Tersedia');
    }
    notifyListeners();
  }
}
