import 'package:danitor/domain/usecases/detail_location_usecase.dart';
import 'package:flutter/material.dart';

import 'danitor_notifier.dart';

class GetInfoLocationNotifier extends ChangeNotifier {
  final DetailLocationUsecase usecase;

  GetInfoLocationNotifier({required this.usecase});

  List<String> _locationResult = [];
  List<String> get locationResult => _locationResult;

  RequestState _locationState = RequestState.init;
  RequestState get locationState => _locationState;

  String _message = '';
  String get message => _message;

  Future<void> getInfoLocation(int id) async {
    _locationState = RequestState.loading;
    notifyListeners();
    final result = await usecase.execute(id.toString());
    result.fold((failure) {
      _locationState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (detectionResult) {
      _locationState = RequestState.success;
      _locationResult = detectionResult.result.animals;
      notifyListeners();
    });
  }
}
