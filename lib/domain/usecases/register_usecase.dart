import 'package:danitor/data/models/token_response.dart';
import 'package:dartz/dartz.dart';

import '../../core/common/failure.dart';
import '../repositories/danitor_repository.dart';

class RegisterUsecase {
  final DanitorRepository repository;

  RegisterUsecase({required this.repository});

  Future<Either<Failure, bool>> execute(
      String username, String password, String name) async {
    return repository.register(username, name, password);
  }
}
