import 'package:danitor/core/common/failure.dart';
import 'package:danitor/domain/entities/detection.dart';
import 'package:danitor/domain/repositories/danitor_repository.dart';
import 'package:dartz/dartz.dart';

class DetectionUsecase {
  final DanitorRepository repository;

  DetectionUsecase({required this.repository});

  Future<Either<Failure, Detection>> execute(String image) {
    return repository.getDetectionResult(image);
  }
}
