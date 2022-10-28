import 'package:danitor/domain/usecases/login_usecase.dart';
import 'package:flutter/material.dart';

import 'danitor_notifier.dart';

class LoginNotifier extends ChangeNotifier {
  final LoginUsecase loginUsecase;
  LoginNotifier({required this.loginUsecase});

  String? _userToken;
  String? get userToken => _userToken;

  RequestState _detectionState = RequestState.init;
  RequestState get detectionState => _detectionState;

  String _message = '';
  String get message => _message;

  Future<void> login(String username, String password) async {
    _detectionState = RequestState.loading;
    notifyListeners();
    final result = await loginUsecase.execute(username, password);
    result.fold((failure) {
      _detectionState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (detectionResult) {
      _detectionState = RequestState.success;
      _userToken = detectionResult.token;
      notifyListeners();
    });
  }
}
