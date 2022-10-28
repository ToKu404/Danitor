import 'package:danitor/data/models/token_response.dart';
import 'package:dartz/dartz.dart';

import '../../core/common/failure.dart';
import '../repositories/danitor_repository.dart';

class LoginUsecase {
  final DanitorRepository repository;

  LoginUsecase({required this.repository});

  Future<Either<Failure, TokenData>> execute(
      String username, String password) async {
    return repository.login(username, password);
  }
}
