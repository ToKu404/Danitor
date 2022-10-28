import 'package:danitor/domain/entities/destination.dart';
import 'package:equatable/equatable.dart';

class DestinationModel extends Equatable {
  const DestinationModel(
      {required this.country,
      required this.destination,
      required this.id,
      required this.uriImage});

  final String country;
  final String destination;
  final int id;
  final String uriImage;

  factory DestinationModel.fromJson(Map<String, dynamic> json) =>
      DestinationModel(
          country: json["country"],
          destination: json["destination"],
          id: json["id"],
          uriImage: json['uri_image']);

  Map<String, dynamic> toJson() => {
        "country": country,
        "destination": destination,
        "id": id,
        'uri_image': uriImage,
      };

  Destination toEntity() {
    return Destination(
        country: country, destination: destination, id: id, uriImage: uriImage);
  }

  @override
  List<Object?> get props => [country, destination, id];
}
