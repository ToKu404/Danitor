import 'package:danitor/data/models/location_result_model.dart';
import 'package:danitor/domain/entities/location_entity.dart';
import 'package:equatable/equatable.dart';

class LocationResponse extends Equatable {
  const LocationResponse({
    required this.result,
  });

  final LocationResultModel result;

  factory LocationResponse.fromJson(Map<String, dynamic> json) =>
      LocationResponse(
        result: LocationResultModel.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };

  LocationEntity toEntity() {
    return LocationEntity(result: result.toEntity());
  }

  @override
  List<Object?> get props => [result];
}
