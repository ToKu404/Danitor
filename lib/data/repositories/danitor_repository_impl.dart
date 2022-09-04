import 'dart:io';
import 'package:danitor/core/common/exception.dart';
import 'package:danitor/data/data_sources/danitor_datasource.dart';
import 'package:danitor/domain/entities/detail_animals.dart';
import 'package:danitor/domain/entities/detection.dart';
import 'package:danitor/domain/repositories/danitor_repository.dart';
import 'package:dartz/dartz.dart';

import '../../core/common/failure.dart';

class DanitorRepositoryImpl implements DanitorRepository {
  final DanitorDataSource danitorDataSource;

  DanitorRepositoryImpl({
    required this.danitorDataSource,
  });

  @override
  Future<Either<Failure, Detection>> getDetectionResult(String image) async {
    try {
      final result = await danitorDataSource.getDetectionResult(image);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, DetailAnimals>> getDetailAnimal(String idx) async {
    try {
      final result = await danitorDataSource.getDetailAnimal(idx);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
