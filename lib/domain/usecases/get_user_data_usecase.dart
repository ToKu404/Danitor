import 'package:danitor/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../../core/common/failure.dart';
import '../repositories/danitor_repository.dart';

class GetUserDataUsecase {
  final DanitorRepository danitorRepository;
  GetUserDataUsecase({required this.danitorRepository});

  Future<Either<Failure, UserEntity>> execute() {
    return danitorRepository.getUserData();
  }
}
