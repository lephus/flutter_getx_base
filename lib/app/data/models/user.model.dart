import 'package:flutter_getx_base/app/core/settings/endpoints.dart';
import 'package:flutter_getx_base/app/core/utils/converters.util.dart';
import 'package:flutter_getx_base/app/data/enum/user.enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class UserModel {
  String id;
  @JsonKey(fromJson: fromJsonToLocal)
  DateTime? createdAt;
  @JsonKey(fromJson: fromJsonToLocal)
  DateTime? updatedAt;
  String? role;
  String? email;
  String? phoneNumber;
  String? firstName;
  String? lastName;
  String? avatar;
  String? gender;
  String? address;
  @JsonKey(fromJson: fromJsonToLocal)
  DateTime? birthday;

  bool get isAdmin => role == RoleEnum.admin;
  bool get isUSER => role == RoleEnum.user;

  String get fullName => '$firstName $lastName';

  UserModel({
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.role,
    this.email,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.avatar,
    this.gender,
    this.address,
    this.birthday,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class CreateFirebaseFcmModel {
  CreateFirebaseFcmModel({
    required this.token,
  });

  factory CreateFirebaseFcmModel.fromJson(Map<String, dynamic> json) =>
      _$CreateFirebaseFcmModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateFirebaseFcmModelToJson(this);

  String token;
}
