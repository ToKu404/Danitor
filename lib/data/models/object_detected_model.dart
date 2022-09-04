import 'package:danitor/domain/entities/object_detected.dart';
import 'package:equatable/equatable.dart';

import 'bounding_box_model.dart';

class ObjectDetectedModel extends Equatable {
  const ObjectDetectedModel({
    required this.objectDetectedClass,
    required this.confidence,
    required this.boundingBox,
  });

  final int objectDetectedClass;
  final double confidence;
  final BoundingBoxModel boundingBox;

  factory ObjectDetectedModel.fromJson(Map<String, dynamic> json) =>
      ObjectDetectedModel(
        objectDetectedClass: json["class"],
        confidence: json["confidence"].toDouble(),
        boundingBox: BoundingBoxModel.fromJson(json["bounding_box"]),
      );

  Map<String, dynamic> toJson() => {
        "class": objectDetectedClass,
        "confidence": confidence,
        "bounding_box": boundingBox.toJson(),
      };

  ObjectDetected toEntity() {
    return ObjectDetected(
        objectDetectedClass: objectDetectedClass,
        confidence: confidence,
        boundingBox: boundingBox.toEntity());
  }

  @override
  List<Object?> get props => [objectDetectedClass, confidence, boundingBox];
}
