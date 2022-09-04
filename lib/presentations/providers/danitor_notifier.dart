import 'package:danitor/domain/entities/detection.dart';
import 'package:danitor/domain/usecases/detection_usecase.dart';
import 'package:flutter/foundation.dart';

enum RequestState { init, loading, error, success }

class DanitorNotifier extends ChangeNotifier {
  final DetectionUsecase detectionUsecase;
  DanitorNotifier({required this.detectionUsecase});

  late Detection _detection;
  Detection get detecetion => _detection;

  RequestState _detectionState = RequestState.init;
  RequestState get detectionState => _detectionState;

  String _message = '';
  String get message => _message;

  Future<void> startDetection(String image) async {
    _detectionState = RequestState.loading;
    notifyListeners();
    final result = await detectionUsecase.execute(image);
    result.fold((failure) {
      _detectionState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (detectionResult) {
      _detectionState = RequestState.success;
      _detection = detectionResult;
      notifyListeners();
    });
  }
}
