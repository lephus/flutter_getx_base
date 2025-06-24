// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterModel _$RegisterModelFromJson(Map<String, dynamic> json) =>
    RegisterModel(
      email: json['email'] as String?,
      gender: json['gender'] as String? ?? 'MALE',
      password: json['password'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      role: json['role'] as String,
      ownerId: json['ownerId'] as String?,
    );

Map<String, dynamic> _$RegisterModelToJson(RegisterModel instance) =>
    <String, dynamic>{
      'gender': instance.gender,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'role': instance.role,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'ownerId': instance.ownerId,
    };
