
import 'package:danitor/domain/entities/destination.dart';
import 'package:equatable/equatable.dart';

class LocationResult extends Equatable{
    const LocationResult({
        required this.animals,
        required this.destination,
    });

    final List<String> animals;
    final Destination destination;

    factory LocationResult.fromJson(Map<String, dynamic> json) => LocationResult(
        animals: List<String>.from(json["animals"].map((x) => x)),
        destination: Destination.fromJson(json["destination"]),
    );

    Map<String, dynamic> toJson() => {
        "animals": List<dynamic>.from(animals.map((x) => x)),
        "destination": destination.toJson(),
    };
    
      @override
      List<Object?> get props => [animals, destination];
}
