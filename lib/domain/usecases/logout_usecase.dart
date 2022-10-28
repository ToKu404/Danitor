import 'package:dartz/dartz.dart';

import '../../core/common/failure.dart';
import '../repositories/danitor_repository.dart';

class LogoutUsecase {
  final DanitorRepository repository;

  LogoutUsecase({required this.repository});

  Future<Either<Failure, bool>> execute() async {
    return repository.logout();
  }
}
