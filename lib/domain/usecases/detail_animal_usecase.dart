import 'package:danitor/domain/entities/detail_animals.dart';
import 'package:danitor/domain/repositories/danitor_repository.dart';
import 'package:dartz/dartz.dart';

import '../../core/common/failure.dart';

class DetailAnimalUsecase {
  final DanitorRepository danitorRepository;
  DetailAnimalUsecase({required this.danitorRepository});

  Future<Either<Failure, DetailAnimals>> execute(String idx) {
    return danitorRepository.getDetailAnimal(idx);
  }
}
