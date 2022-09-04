import 'package:danitor/data/models/destination_model.dart';
import 'package:danitor/domain/entities/location_result.dart';
import 'package:equatable/equatable.dart';

class LocationResultModel extends Equatable {
  const LocationResultModel({
    required this.animals,
    required this.destination,
  });

  final List<String> animals;
  final DestinationModel destination;

  factory LocationResultModel.fromJson(Map<String, dynamic> json) =>
      LocationResultModel(
        animals: List<String>.from(json["animals"].map((x) => x)),
        destination: DestinationModel.fromJson(json["destination"]),
      );

  Map<String, dynamic> toJson() => {
        "animals": List<dynamic>.from(animals.map((x) => x)),
        "destination": destination.toJson(),
      };

  LocationResult toEntity() {
    return LocationResult(
        animals: animals, destination: destination.toEntity());
  }

  @override
  List<Object?> get props => [animals, destination];
}
