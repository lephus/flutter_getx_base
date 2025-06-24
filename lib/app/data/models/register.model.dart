import 'package:json_annotation/json_annotation.dart';

part 'register.model.g.dart';

@JsonSerializable()
class RegisterModel {
  RegisterModel({
    this.email,
    this.gender = 'MALE',
    required this.password,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    required this.role,
    this.ownerId,
  });

  String gender;
  String firstName;
  String lastName;
  String role;
  String? email;
  String? phoneNumber;
  String password;
  String? ownerId;

  factory RegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterModelToJson(this);
}
