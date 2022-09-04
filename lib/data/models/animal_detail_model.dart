import 'package:danitor/domain/entities/animal_detail.dart';
import 'package:equatable/equatable.dart';

class AnimalDetailModel extends Equatable {
  const AnimalDetailModel({
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

  factory AnimalDetailModel.fromJson(Map<String, dynamic> json) =>
      AnimalDetailModel(
        animalAction: json["animal_action"],
        animalDescription: json["animal_description"],
        id: json["id"],
        informationSource: json["information_source"],
        isDangerousDescription: json["is_dangerous_description"],
        isDangerousId: json["is_dangerous_id"],
        isDangerousLabel: json["is_dangerous_label"],
        isPoisonousDescription: json["is_poisonous_description"],
        isPoisonousId: json["is_poisonous_id"],
        isPoisonousLabel: json["is_poisonous_label"],
        name: json["name"],
        webviewLink: json["webview_link"],
      );

  Map<String, dynamic> toJson() => {
        "animal_action": animalAction,
        "animal_description": animalDescription,
        "id": id,
        "information_source": informationSource,
        "is_dangerous_description": isDangerousDescription,
        "is_dangerous_id": isDangerousId,
        "is_dangerous_label": isDangerousLabel,
        "is_poisonous_description": isPoisonousDescription,
        "is_poisonous_id": isPoisonousId,
        "is_poisonous_label": isPoisonousLabel,
        "name": name,
        "webview_link": webviewLink,
      };

  AnimalDetail toEntity() {
    return AnimalDetail(
        animalAction: animalAction,
        animalDescription: animalDescription,
        id: id,
        informationSource: informationSource,
        isDangerousDescription: isDangerousDescription,
        isDangerousId: isDangerousId,
        isDangerousLabel: isDangerousLabel,
        isPoisonousDescription: isPoisonousDescription,
        isPoisonousId: isPoisonousId,
        isPoisonousLabel: isPoisonousLabel,
        name: name,
        webviewLink: webviewLink);
  }

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
