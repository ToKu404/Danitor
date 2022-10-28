import 'dart:io';
import 'package:danitor/core/common/exception.dart';
import 'package:danitor/data/data_sources/danitor_datasource.dart';
import 'package:danitor/data/models/token_response.dart';
import 'package:danitor/domain/entities/detail_animals.dart';
import 'package:danitor/domain/entities/detection.dart';
import 'package:danitor/domain/entities/location_entity.dart';
import 'package:danitor/domain/repositories/danitor_repository.dart';
import 'package:dartz/dartz.dart';

import '../../core/common/failure.dart';

class DanitorRepositoryImpl implements DanitorRepository {
  final DanitorDataSource danitorDataSource;

  DanitorRepositoryImpl({
    required this.danitorDataSource,
  });

  @override
  Future<Either<Failure, Detection>> getDetectionResult(
      String image, List<int> filters) async {
    try {
      final result = await danitorDataSource.getDetectionResult(image, filters);
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

  @override
  Future<Either<Failure, LocationEntity>> getAnimalLocation(String id) async {
    try {
      final result = await danitorDataSource.getAnimalLocation(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TokenData>> login(
      String username, String password) async {
    try {
      final result = await danitorDataSource.login(username, password);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, bool>> register(
      String username, String name, String password) async {
    try {
      final result = await danitorDataSource.register(username, name, password);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, bool>> isLogin() async {
    try {
      final result = await danitorDataSource.isLogin();
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      final result = await danitorDataSource.logout();
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    }
  }
}
