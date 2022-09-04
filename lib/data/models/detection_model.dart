import 'package:danitor/data/models/object_detected_model.dart';
import 'package:danitor/domain/entities/detection.dart';
import 'package:equatable/equatable.dart';

class DetectionResponse extends Equatable {
  const DetectionResponse({
    required this.status,
    required this.detectionCount,
    required this.objectDetected,
  });

  final String status;
  final int detectionCount;
  final List<ObjectDetectedModel> objectDetected;

  factory DetectionResponse.fromJson(Map<String, dynamic> json) =>
      DetectionResponse(
        status: json["status"],
        detectionCount: json["detection_count"],
        objectDetected: List<ObjectDetectedModel>.from(json["object_detected"]
            .map((x) => ObjectDetectedModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "detection_count": detectionCount,
        "object_detected":
            List<dynamic>.from(objectDetected.map((x) => x.toJson())),
      };

  Detection toEntity() {
    return Detection(
      status: status,
      detectionCount: detectionCount,
      objectDetected: objectDetected.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [status, detectionCount, objectDetected];
}
