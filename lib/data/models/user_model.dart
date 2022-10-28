import 'package:equatable/equatable.dart';

import '../../domain/entities/user_entity.dart';

class UserModel extends Equatable {
  const UserModel(
      {required this.username, required this.location, required this.name});

  final String username;
  final int? location;
  final String name;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json["username"],
        location: json["location"],
        name: json["name"],
      );

  UserEntity toEntity() {
    return UserEntity(username: username, location: location, name: name);
  }

  @override
  List<Object?> get props => [username, location, name];
}
