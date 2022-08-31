// To parse this JSON data, do
//
//     final data = dataFromJson(jsonString);

import 'dart:convert';

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    required this.status,
    required this.detectionCount,
    required this.objectDetected,
  });

  String status;
  int detectionCount;
  List<ObjectDetected> objectDetected;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        detectionCount: json["detection_count"],
        objectDetected: List<ObjectDetected>.from(
            json["object_detected"].map((x) => ObjectDetected.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "detection_count": detectionCount,
        "object_detected":
            List<dynamic>.from(objectDetected.map((x) => x.toJson())),
      };
}

class ObjectDetected {
  ObjectDetected({
    required this.objectDetectedClass,
    required this.confidence,
    required this.boundingBox,
  });

  int objectDetectedClass;
  double confidence;
  BoundingBox boundingBox;

  factory ObjectDetected.fromJson(Map<String, dynamic> json) => ObjectDetected(
        objectDetectedClass: json["class"],
        confidence: json["confidence"].toDouble(),
        boundingBox: BoundingBox.fromJson(json["bounding_box"]),
      );

  Map<String, dynamic> toJson() => {
        "class": objectDetectedClass,
        "confidence": confidence,
        "bounding_box": boundingBox.toJson(),
      };
}

class BoundingBox {
  BoundingBox({
    required this.topLeft,
    required this.topRight,
    required this.bottomLeft,
    required this.bottomRight,
  });

  List<int> topLeft;
  List<int> topRight;
  List<int> bottomLeft;
  List<int> bottomRight;

  factory BoundingBox.fromJson(Map<String, dynamic> json) => BoundingBox(
        topLeft: List<int>.from(json["top_left"].map((x) => x)),
        topRight: List<int>.from(json["top_right"].map((x) => x)),
        bottomLeft: List<int>.from(json["bottom_left"].map((x) => x)),
        bottomRight: List<int>.from(json["bottom_right"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "top_left": List<dynamic>.from(topLeft.map((x) => x)),
        "top_right": List<dynamic>.from(topRight.map((x) => x)),
        "bottom_left": List<dynamic>.from(bottomLeft.map((x) => x)),
        "bottom_right": List<dynamic>.from(bottomRight.map((x) => x)),
      };
}
