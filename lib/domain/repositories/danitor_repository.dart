import 'package:danitor/data/models/token_response.dart';
import 'package:danitor/domain/entities/detail_animals.dart';
import 'package:danitor/domain/entities/location_entity.dart';
import 'package:dartz/dartz.dart';
import '../../core/common/failure.dart';
import '../entities/detection.dart';

abstract class DanitorRepository {
  Future<Either<Failure, Detection>> getDetectionResult(
      String image, List<int> filters);
  Future<Either<Failure, DetailAnimals>> getDetailAnimal(String idx);
  Future<Either<Failure, LocationEntity>> getAnimalLocation(String id);
  Future<Either<Failure, TokenData>> login(String username, String password);
  Future<Either<Failure, bool>> register(
      String username, String name, String password);
  Future<Either<Failure, bool>> logout();
  Future<Either<Failure, bool>> isLogin();
}
