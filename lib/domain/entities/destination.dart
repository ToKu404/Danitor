import 'package:equatable/equatable.dart';

class Destination extends Equatable {
  const Destination({
    required this.country,
    required this.destination,
    required this.id,
  });

  final String country;
  final String destination;
  final int id;

  factory Destination.fromJson(Map<String, dynamic> json) =>
      Destination(
        country: json["country"],
        destination: json["destination"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "destination": destination,
        "id": id,
      };

  @override
  List<Object?> get props => [country, destination, id];
}
