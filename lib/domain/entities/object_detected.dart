import 'package:equatable/equatable.dart';

import 'bounding_box.dart';

class ObjectDetected extends Equatable {
  const ObjectDetected({
    required this.objectDetectedClass,
    required this.confidence,
    required this.boundingBox,
  });

  final int objectDetectedClass;
  final double confidence;
  final BoundingBox boundingBox;

  @override
  List<Object?> get props => [objectDetectedClass, confidence, boundingBox];
}
