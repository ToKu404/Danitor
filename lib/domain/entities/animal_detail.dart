
import 'package:equatable/equatable.dart';

class AnimalDetail extends Equatable {
  const AnimalDetail({
    required this.animalAction,
    required this.animalDescription,
    required this.id,
    required this.informationSource,
    required this.isDangerousDescription,
    required this.isDangerousId,
    required this.isDangerousLabel,
    required this.isPoisonousDescription,
    required this.isPoisonousId,
    required this.isPoisonousLabel,
    required this.name,
    required this.webviewLink,
  });

  final String animalAction;
  final String animalDescription;
  final String id;
  final String informationSource;
  final String isDangerousDescription;
  final String isDangerousId;
  final String isDangerousLabel;
  final String isPoisonousDescription;
  final String isPoisonousId;
  final String isPoisonousLabel;
  final String name;
  final String webviewLink;


  @override
  List<Object?> get props => [
        animalAction,
        animalDescription,
        id,
        informationSource,
        isDangerousDescription,
        isDangerousId,
        isDangerousLabel,
        isPoisonousDescription,
        isPoisonousId,
        isPoisonousLabel,
        name,
        webviewLink,
      ];
}
