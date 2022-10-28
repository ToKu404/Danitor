import 'package:danitor/data/models/histories.dart';
import 'package:dartz/dartz.dart';

import '../../core/common/failure.dart';
import '../repositories/danitor_repository.dart';

class GetHistoryUsecase {
  final DanitorRepository danitorRepository;
  GetHistoryUsecase({required this.danitorRepository});

  Future<Either<Failure, List<History>>> execute() {
    return danitorRepository.getHistory();
  }
}
