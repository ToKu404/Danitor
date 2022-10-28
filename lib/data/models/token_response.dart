import 'package:danitor/domain/entities/location_result.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/token_entity.dart';

class TokenResponse extends Equatable {
  const TokenResponse({
    required this.result,
  });

  final TokenData result;

  factory TokenResponse.fromJson(Map<String, dynamic> json) => TokenResponse(
        result: TokenData.fromJson(json["result"]),
      );

  TokenEntity toEntity() {
    return TokenEntity(result: result.toEntity());
  }

  @override
  List<Object?> get props => [result];
}

class TokenData extends Equatable {
  const TokenData({
    required this.token,
  });

  final String token;

  factory TokenData.fromJson(Map<String, dynamic> json) => TokenData(
        token: json["access_token"],
      );

  TokenResult toEntity() {
    return TokenResult(token: token);
  }

  @override
  List<Object?> get props => [token];
}
