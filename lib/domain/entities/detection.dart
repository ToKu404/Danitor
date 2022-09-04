import 'package:equatable/equatable.dart';

import 'object_detected.dart';

class Detection extends Equatable {
  const Detection({
    required this.status,
    required this.detectionCount,
    required this.objectDetected,
  });

  final String status;
  final int detectionCount;
  final List<ObjectDetected> objectDetected;

  @override
  List<Object?> get props => [status, detectionCount, objectDetected];
}
