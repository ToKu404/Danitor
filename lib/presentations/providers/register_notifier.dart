import 'package:flutter/material.dart';

import '../../domain/usecases/register_usecase.dart';
import 'danitor_notifier.dart';

class RegisterNotifier extends ChangeNotifier {
  final RegisterUsecase registerUsecase;
  RegisterNotifier({required this.registerUsecase});

  bool _isRegisterSuccess = false;
  bool get isRegister => _isRegisterSuccess;

  RequestState _detectionState = RequestState.init;
  RequestState get resultState => _detectionState;

  String _message = '';
  String get message => _message;

  Future<void> register(String username, String password, String name) async {
    _detectionState = RequestState.loading;
    notifyListeners();
    final result = await registerUsecase.execute(username, password, name);
    result.fold((failure) {
      _detectionState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (detectionResult) {
      _detectionState = RequestState.success;
      _isRegisterSuccess = detectionResult;
      notifyListeners();
    });
  }
}
