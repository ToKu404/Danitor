import 'package:danitor/domain/entities/bounding_box.dart';
import 'package:equatable/equatable.dart';

class BoundingBoxModel extends Equatable {
  const BoundingBoxModel({
    required this.xmax,
    required this.ymax,
    required this.xmin,
    required this.ymin,
  });

  final double xmax;
  final double ymax;
  final double xmin;
  final double ymin;

  factory BoundingBoxModel.fromJson(Map<String, dynamic> json) =>
      BoundingBoxModel(
        xmin: json["xmin"].toDouble(),
        xmax: json["xmax"].toDouble(),
        ymin: json["ymin"].toDouble(),
        ymax: json["ymax"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "xmin": xmin,
        "xmax": xmax,
        "ymin": ymin,
        "ymax": ymax,
      };

  BoundingBox toEntity() {
    return BoundingBox(xmax: xmax, ymax: ymax, xmin: xmin, ymin: ymin);
  }

  @override
  List<Object?> get props => [xmax, ymax, xmin, ymin];
}
