import 'package:danitor/domain/entities/animal_detail.dart';
import 'package:danitor/domain/usecases/detail_animal_usecase.dart';
import 'package:danitor/presentations/providers/danitor_notifier.dart';
import 'package:flutter/material.dart';

class DetailProviderNotifier extends ChangeNotifier {
  final DetailAnimalUsecase detailAnimalUsecase;
  DetailProviderNotifier({required this.detailAnimalUsecase});

  late List<AnimalDetail> _detailAnimals;
  List<AnimalDetail> get listAnimalDetail => _detailAnimals;

  RequestState _detectionState = RequestState.init;
  RequestState get detectionState => _detectionState;

  String _message = '';
  String get message => _message;

  Future<void> getDetails(String idx) async {
    _detectionState = RequestState.loading;
    notifyListeners();
    final result = await detailAnimalUsecase.execute(idx);
    result.fold((failure) {
      _detectionState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (detectionResult) {
      _detectionState = RequestState.success;
      _detailAnimals = detectionResult.results;
      notifyListeners();
    });
  }
}
