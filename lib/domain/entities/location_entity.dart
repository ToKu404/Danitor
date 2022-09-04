import 'package:danitor/domain/entities/location_result.dart';
import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  const LocationEntity({
    required this.result,
  });

  final LocationResult result;

  factory LocationEntity.fromJson(Map<String, dynamic> json) =>
      LocationEntity(
        result: LocationResult.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };

  @override
  List<Object?> get props => [result];
}
