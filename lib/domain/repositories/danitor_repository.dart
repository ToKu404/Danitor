import 'package:danitor/domain/entities/detail_animals.dart';
import 'package:dartz/dartz.dart';
import '../../core/common/failure.dart';
import '../entities/detection.dart';

abstract class DanitorRepository {
  Future<Either<Failure, Detection>> getDetectionResult(String image);
  Future<Either<Failure, DetailAnimals>> getDetailAnimal(String idx);
}
