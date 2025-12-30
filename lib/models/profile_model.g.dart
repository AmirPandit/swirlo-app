// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
  userId: json['user_id'] as String?,
  name: json['name'] as String?,
  swirloId: json['swirlo_id'] as String?,
  profilePicture: json['profile_picture'] as String?,
  bio: json['bio'] as String?,
  location: json['location'] as String?,
  interestedIn: json['interested_in'] as String?,
  ageRange: json['age_range'] as String?,
  whoLikesCount: (json['who_likes_count'] as num?)?.toInt(),
  email: json['email'] as String?,
  phoneNumber: json['phone_number'] as String?,
  pushNotifications: json['push_notifications'] as bool?,
  emailNotifications: json['email_notifications'] as bool?,
);

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'name': instance.name,
      'swirlo_id': instance.swirloId,
      'profile_picture': instance.profilePicture,
      'bio': instance.bio,
      'location': instance.location,
      'interested_in': instance.interestedIn,
      'age_range': instance.ageRange,
      'who_likes_count': instance.whoLikesCount,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'push_notifications': instance.pushNotifications,
      'email_notifications': instance.emailNotifications,
    };
