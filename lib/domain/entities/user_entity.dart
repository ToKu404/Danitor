import 'package:equatable/equatable.dart';

class UserEntityData extends Equatable {
  const UserEntityData({
    required this.result,
  });

  final UserEntity result;

  factory UserEntityData.fromJson(Map<String, dynamic> json) => UserEntityData(
        result: UserEntity.fromJson(json["result"]),
      );

  @override
  List<Object?> get props => [result];
}

class UserEntity extends Equatable {
  const UserEntity(
      {required this.username, required this.location, required this.name});

  final String username;
  final int? location;
  final String name;

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        username: json["username"],
        location: json["location"],
        name: json["name"],
      );

  @override
  List<Object?> get props => [username, location, name];
}
