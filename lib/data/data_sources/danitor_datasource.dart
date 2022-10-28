// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:danitor/data/models/detail_animals_response.dart';
import 'package:danitor/data/models/location_response.dart';
import 'package:danitor/data/models/token_response.dart';
import 'package:danitor/core/common/auth_helper.dart';
import 'package:http/http.dart' as http;
import 'package:danitor/data/models/detection_model.dart';

import '../../core/common/exception.dart';

abstract class DanitorDataSource {
  Future<DetectionResponse> getDetectionResult(String image, List<int> filters);
  Future<DetailAnimalsResponse> getDetailAnimal(String idx);
  Future<LocationResponse> getAnimalLocation(String id);
  Future<TokenData> login(String username, String password);
  Future<bool> register(String username, String name, String password);
  Future<String> getUser(String token);
  Future<String> getHistory(String token);
  Future<bool> logout();
  Future<bool> isLogin();
}

class DanitorDatasourceImpl implements DanitorDataSource {
  static const BASE_URL = 'http://34.101.118.74:8000';

  final http.Client client;
  final AuthHelper helper;

  DanitorDatasourceImpl({required this.client, required this.helper});

  @override
  Future<DetectionResponse> getDetectionResult(
      String image, List<int> filters) async {
    Map data = {
      "image": image,
      "filters": filters,
    };
    Map dataNoFilter = {
      "image": image,
    };
    final response = await client.post(
      Uri.parse('$BASE_URL/detect'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(filters.isEmpty ? dataNoFilter : data),
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

  @override
  Future<LocationResponse> getAnimalLocation(String id) async {
    final response = await client.get(
      Uri.parse('$BASE_URL/locations/$id'),
    );

    if (response.statusCode == 200) {
      return LocationResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TokenData> login(String username, String password) async {
    final response = await client.post(Uri.parse('$BASE_URL/login'), headers: {
      'username': username,
      'password': password,
    });
    if (response.statusCode == 200) {
      final responseToken = TokenResponse.fromJson(json.decode(response.body));
      helper.setUserId(responseToken.result.token);
      return responseToken.result;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> register(String username, String name, String password) async {
    Map data = {
      'email': username,
      'name': name,
      'password': password,
    };

    final response = await client.post(Uri.parse('$BASE_URL/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data));
    print(response.statusCode);
    if (response.statusCode == 201) {
      return true;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> getUser(String token) async {
    final response = await client.get(Uri.parse('$BASE_URL/user'), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 201) {
      return response.body;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> getHistory(String token) async {
    final response =
        await client.get(Uri.parse('$BASE_URL/histories'), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> isLogin() async {
    return helper.checkUserIdExist();
  }

  @override
  Future<bool> logout() async {
    helper.removeUserId();
    return true;
  }
}
