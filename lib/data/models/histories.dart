import 'package:danitor/data/models/object_detected_model.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/token_entity.dart';

class HistoriesResults extends Equatable {
  const HistoriesResults({
    required this.result,
  });

  final Histories result;

  factory HistoriesResults.fromJson(Map<String, dynamic> json) =>
      HistoriesResults(
        result: Histories.fromJson(json["result"]),
      );

  @override
  List<Object?> get props => [result];
}

class Histories extends Equatable {
  const Histories({
    required this.history,
  });

  final List<History> history;

  factory Histories.fromJson(Map<String, dynamic> json) => Histories(
        history: List<History>.from(
            json["histories"].map((x) => History.fromJson(x))),
      );

  @override
  List<Object?> get props => [history];
}

class History extends Equatable {
  const History({
    required this.detectionResult,
    required this.detectedAt,
    required this.image,
    required this.location,
  });

  final ObjectDetectedModel detectionResult;
  final String detectedAt;
  final String image;
  final int location;

  factory History.fromJson(Map<String, dynamic> json) => History(
        detectedAt: json['detected_at'],
        detectionResult: ObjectDetectedModel.fromJson(json["detection_result"]),
        image: json['image'],
        location: json['location'],
      );

  @override
  List<Object?> get props => [detectedAt, detectionResult, image, location];
}
