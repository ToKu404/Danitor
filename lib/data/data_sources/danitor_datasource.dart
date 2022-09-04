// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:danitor/data/models/detail_animals_response.dart';
import 'package:http/http.dart' as http;
import 'package:danitor/data/models/detection_model.dart';

import '../../core/common/exception.dart';

abstract class DanitorDataSource {
  Future<DetectionResponse> getDetectionResult(String image);
  Future<DetailAnimalsResponse> getDetailAnimal(String idx);
}

class DanitorDatasourceImpl implements DanitorDataSource {
  static const BASE_URL = 'http://34.101.118.74:5000';

  final http.Client client;

  DanitorDatasourceImpl({required this.client});

  @override
  Future<DetectionResponse> getDetectionResult(String image) async {
    Map data = {
      "image": image,
    };
    final response = await client.post(
      Uri.parse('$BASE_URL/detect'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      return DetectionResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<DetailAnimalsResponse> getDetailAnimal(String idx) async {
    final response = await client.get(
      Uri.parse('$BASE_URL/animals/$idx'),
    );

    if (response.statusCode == 200) {
      return DetailAnimalsResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
