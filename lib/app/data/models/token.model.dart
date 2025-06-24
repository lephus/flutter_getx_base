import 'package:json_annotation/json_annotation.dart';

part 'token.model.g.dart';

@JsonSerializable()
class TokenModel {
  TokenModel({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      _$TokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$TokenModelToJson(this);

  String accessToken;
  String refreshToken;
  int expiresIn;
}
