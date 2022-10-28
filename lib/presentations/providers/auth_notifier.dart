import 'package:danitor/domain/usecases/is_login_usecase.dart';
import 'package:danitor/domain/usecases/logout_usecase.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'danitor_notifier.dart';

class AuthNotifier extends ChangeNotifier {
  final IsLoginUsecase isLoginUsecase;
  final LogoutUsecase logoutUsecase;

  AuthNotifier({required this.isLoginUsecase, required this.logoutUsecase});

  bool _isAnonymous = false;
  bool _isLogin = false;

  bool get isAnonymous => _isAnonymous;
  bool get isLogin => _isLogin;

  RequestState _state = RequestState.init;
  RequestState get authState => _state;

  String _message = '';
  String get message => _message;

  Future<void> logout() async {
    await logoutUsecase.execute();
    notifyListeners();
  }

  void setAnonymous(bool status) {
    _isAnonymous = status;
    notifyListeners();
  }

  Future<void> checkLoginStatus() async {
    _state = RequestState.loading;
    notifyListeners();
    final result = await isLoginUsecase.execute();
    result.fold((failure) {
      _state = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (dataResult) {
      _state = RequestState.success;
      _isLogin = dataResult;
      notifyListeners();
    });
  }
}
