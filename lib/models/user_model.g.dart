// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  userId: json['user_id'] as String?,
  email: json['email'] as String,
  isVerified: json['is_verified'] as bool? ?? false,
  isActive: json['is_active'] as bool? ?? false,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'user_id': instance.userId,
  'email': instance.email,
  'is_verified': instance.isVerified,
  'is_active': instance.isActive,
};
