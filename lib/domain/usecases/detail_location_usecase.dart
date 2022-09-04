import 'package:danitor/domain/entities/location_entity.dart';
import 'package:danitor/domain/repositories/danitor_repository.dart';
import 'package:dartz/dartz.dart';

import '../../core/common/failure.dart';

class DetailLocationUsecase {
  final DanitorRepository danitorRepository;
  DetailLocationUsecase({required this.danitorRepository});

  Future<Either<Failure, LocationEntity>> execute(String id) {
    return danitorRepository.getAnimalLocation(id);
  }
}
