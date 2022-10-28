import 'package:danitor/data/models/user_model.dart';
import 'package:danitor/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';
class UserResponse extends Equatable {
  const UserResponse({
    required this.result,
  });

  final UserModel result;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        result: UserModel.fromJson(json["result"]),
      );

  UserEntityData toEntity() {
    return UserEntityData(result: result.toEntity());
  }

  @override
  List<Object?> get props => [result];
}
