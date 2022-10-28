import 'package:dartz/dartz.dart';

import '../../core/common/failure.dart';
import '../repositories/danitor_repository.dart';

class IsLoginUsecase {
  final DanitorRepository repository;

  IsLoginUsecase({required this.repository});

  Future<Either<Failure, bool>> execute() async {
    return repository.isLogin();
  }
}
