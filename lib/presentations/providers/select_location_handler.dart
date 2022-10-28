import 'package:flutter/material.dart';
import '../../domain/usecases/update_location_usecase.dart';

class SelectLocationHandler extends ChangeNotifier {
  final UpdateLocationUsecase updateLocationUsecase;
  SelectLocationHandler({required this.updateLocationUsecase});

  int _idLocation = -1;

  String _locationName = 'Destinasi Belum Diatur';
  String _urlLocation =
      'https://img.freepik.com/premium-vector/3d-top-view-map-with-destination-location-point-aerial-clean-top-view-day-time-city-map-with-street-river-blank-urban-imagination-map-gps-map-navigator-concept-vector-illustration_34645-1264.jpg?w=2000';

  int get idLocation => _idLocation;

  String get locationName => _locationName;

  String get urlLocation => _urlLocation;

  List<String> _locationResult = [];
  List<String> get locationResult => _locationResult;

  Future<void> initId(int id) async {
    _idLocation = id;
    if (id == -1) {
      _locationName = 'Destinasi Belum Diatur';
      _urlLocation =
          'https://img.freepik.com/premium-vector/3d-top-view-map-with-destination-location-point-aerial-clean-top-view-day-time-city-map-with-street-river-blank-urban-imagination-map-gps-map-navigator-concept-vector-illustration_34645-1264.jpg?w=2000';
    } else {
      _locationName = _destinationList[id];
      _urlLocation = _urlImage[id];
    }
    notifyListeners();
  }

  void setIdLocation(String id) async {
    await updateLocationUsecase.execute(idLocation);
    if (_destinationList.contains(id.toLowerCase().trim())) {
      _idLocation = _destinationList.indexOf(id.toLowerCase().trim());
      _locationName = _destinationList[_idLocation];
      _urlLocation = _urlImage[_idLocation];
    } else {
      _idLocation = -1;
      _locationName = 'Destinasi Belum Diatur';
      _urlLocation =
          'https://img.freepik.com/premium-vector/3d-top-view-map-with-destination-location-point-aerial-clean-top-view-day-time-city-map-with-street-river-blank-urban-imagination-map-gps-map-navigator-concept-vector-illustration_34645-1264.jpg?w=2000';
    }
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

  List<String> get destionationList => _destinationList;

  final List<String> _urlImage = [
    'https://a.cdn-hotels.com/gdcs/production143/d1112/c4fedab1-4041-4db5-9245-97439472cf2c.jpg',
    'https://www.indonesia.travel/content/dam/indtravelrevamp/en/destinations/revisi-2020/destinations-thumbnail/Raja-Ampat-Thumbnail.png',
    'https://asset.kompas.com/crops/ExYEkOxqYjotcrWWUviAEfKL48s=/0x0:0x0/750x500/data/photo/2021/08/09/6110f2ed7a474.jpg',
    'https://cntres-assets-ap-southeast-1-250226768838-cf675839782fd369.s3.amazonaws.com/imageResource/2021/06/24/1624553857684-40566380ed85760f77496a3434b9f4cf.jpeg',
    'https://www.indonesia.travel/content/dam/indtravelrevamp/en/trip-ideas/liburan-di-kepulauan-seribu-yuk-kunjungi-10-spot-wisata-di-kawasan-ini/6.jpg',
    'https://jdih.bitungkota.go.id/img/upload_destinasi_wisata/c044c92224ae8a3113c1c634face7ab9.jpg',
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
