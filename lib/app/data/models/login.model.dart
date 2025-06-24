import 'package:json_annotation/json_annotation.dart';

part 'login.model.g.dart';

@JsonSerializable()
class LoginModel {
  LoginModel({
    required this.userName,
    required this.password,
  });

  final String userName;
  final String password;

    factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}