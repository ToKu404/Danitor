import 'package:dartz/dartz.dart';

import '../../core/common/failure.dart';
import '../repositories/danitor_repository.dart';

class UpdateLocationUsecase {
  final DanitorRepository danitorRepository;
  UpdateLocationUsecase({required this.danitorRepository});

  Future<Either<Failure, bool>> execute(int idLocation) {
    return danitorRepository.updateLocation(idLocation);
  }
}
