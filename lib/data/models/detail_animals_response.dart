import 'package:danitor/data/models/animal_detail_model.dart';
import 'package:danitor/domain/entities/animal_detail.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/detail_animals.dart';

class DetailAnimalsResponse extends Equatable {
  const DetailAnimalsResponse({
    required this.results,
  });

  final List<AnimalDetailModel> results;

  factory DetailAnimalsResponse.fromJson(Map<String, dynamic> json) =>
      DetailAnimalsResponse(
        results: List<AnimalDetailModel>.from(
            json["results"].map((x) => AnimalDetailModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };

  DetailAnimals toEntity() {
    return DetailAnimals(
      results: results.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [results];
}
