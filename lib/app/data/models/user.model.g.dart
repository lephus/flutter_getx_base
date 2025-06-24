// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      createdAt: fromJsonToLocal(json['createdAt'] as String?),
      updatedAt: fromJsonToLocal(json['updatedAt'] as String?),
      role: json['role'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      avatar: json['avatar'] as String?,
      gender: json['gender'] as String?,
      address: json['address'] as String?,
      birthday: fromJsonToLocal(json['birthday'] as String?),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'role': instance.role,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'avatar': instance.avatar,
      'gender': instance.gender,
      'address': instance.address,
      'birthday': instance.birthday?.toIso8601String(),
    };

CreateFirebaseFcmModel _$CreateFirebaseFcmModelFromJson(
        Map<String, dynamic> json) =>
    CreateFirebaseFcmModel(
      token: json['token'] as String,
    );

Map<String, dynamic> _$CreateFirebaseFcmModelToJson(
        CreateFirebaseFcmModel instance) =>
    <String, dynamic>{
      'token': instance.token,
    };
