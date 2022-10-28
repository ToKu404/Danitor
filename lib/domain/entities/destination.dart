import 'package:equatable/equatable.dart';

class Destination extends Equatable {
  const Destination(
      {required this.country,
      required this.destination,
      required this.id,
      required this.uriImage});

  final String country;
  final String destination;
  final String uriImage;

  final int id;

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        country: json["country"],
        destination: json["destination"],
        id: json["id"],
        uriImage: json["uri_image"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "destination": destination,
        "id": id,
        "uri_image": uriImage,
      };

  @override
  List<Object?> get props => [country, destination, id];
}
