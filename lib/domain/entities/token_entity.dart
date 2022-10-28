import 'package:equatable/equatable.dart';

class TokenEntity extends Equatable {
  const TokenEntity({
    required this.result,
  });

  final TokenResult result;

  factory TokenEntity.fromJson(Map<String, dynamic> json) => TokenEntity(
        result: TokenResult.fromJson(json["result"]),
      );

  @override
  List<Object?> get props => [result];
}

class TokenResult extends Equatable {
  const TokenResult({required this.token});

  final String token;

  factory TokenResult.fromJson(Map<String, dynamic> json) =>
      TokenResult(token: json['access_token']);

  @override
  List<Object?> get props => [token];
}
