import 'package:danitor/domain/entities/destination.dart';
import 'package:equatable/equatable.dart';

class DestinationModel extends Equatable {
  const DestinationModel({
    required this.country,
    required this.destination,
    required this.id,
  });

  final String country;
  final String destination;
  final int id;

  factory DestinationModel.fromJson(Map<String, dynamic> json) =>
      DestinationModel(
        country: json["country"],
        destination: json["destination"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "destination": destination,
        "id": id,
      };

  Destination toEntity() {
    return Destination(country: country, destination: destination, id: id);
  }

  @override
  List<Object?> get props => [country, destination, id];
}
