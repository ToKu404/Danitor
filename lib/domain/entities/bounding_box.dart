import 'package:equatable/equatable.dart';

class BoundingBox extends Equatable {
  const BoundingBox({
    required this.xmax,
    required this.ymax,
    required this.xmin,
    required this.ymin,
  });

  final double xmax;
  final double ymax;
  final double xmin;
  final double ymin;

  @override
  List<Object?> get props => [xmax, ymax, xmin, ymin];
}
