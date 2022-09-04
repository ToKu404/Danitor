import 'package:danitor/domain/entities/animal_detail.dart';
import 'package:equatable/equatable.dart';

class DetailAnimals extends Equatable {
  const DetailAnimals({
    required this.results,
  });

  final List<AnimalDetail> results;


  @override
  List<Object?> get props => [results];
}
