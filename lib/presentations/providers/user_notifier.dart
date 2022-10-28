import 'package:danitor/data/models/histories.dart';
import 'package:danitor/domain/entities/user_entity.dart';
import 'package:danitor/domain/usecases/get_history_usecase.dart';
import 'package:danitor/domain/usecases/get_user_data_usecase.dart';
import 'package:danitor/presentations/providers/danitor_notifier.dart';
import 'package:flutter/material.dart';

class UserNotifier extends ChangeNotifier {
  final GetUserDataUsecase getUserDataUsecase;
  final GetHistoryUsecase getHistoryUsecase;

  UserNotifier(
      {required this.getUserDataUsecase, required this.getHistoryUsecase});

  UserEntity? _userEntity;
  UserEntity? get userEntity => _userEntity;

  List<History> _histories = [];
  List<History> get histories => _histories;

  RequestState _state = RequestState.init;
  RequestState get userState => _state;

  RequestState _historiesState = RequestState.init;
  RequestState get historiesState => _historiesState;

  String _message = '';
  String get message => _message;

  Future<void> getUserData() async {
    _state = RequestState.loading;
    notifyListeners();
    final result = await getUserDataUsecase.execute();
    result.fold((failure) {
      _state = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (detectionResult) {
      _state = RequestState.success;
      _userEntity = detectionResult;
      notifyListeners();
    });
  }

  Future<void> getHistory() async {
    _state = RequestState.loading;
    notifyListeners();
    final result = await getHistoryUsecase.execute();
    result.fold((failure) {
      _state = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (detectionResult) {
      _state = RequestState.success;
      _histories = detectionResult;
      notifyListeners();
    });
  }
}
