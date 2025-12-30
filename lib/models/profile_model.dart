import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  @JsonKey(name: 'user_id')
  final String? userId;

  final String? name;

  @JsonKey(name: 'swirlo_id')
  final String? swirloId;

  @JsonKey(name: 'profile_picture')
  final String? profilePicture;

  final String? bio;
  final String? location;

  @JsonKey(name: 'interested_in')
  final String? interestedIn;

  @JsonKey(name: 'age_range')
  final String? ageRange;

  @JsonKey(name: 'who_likes_count')
  final int? whoLikesCount;

  final String? email;

  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  @JsonKey(name: 'push_notifications')
  final bool? pushNotifications;

  @JsonKey(name: 'email_notifications')
  final bool? emailNotifications;

  ProfileModel({
    this.userId,
    this.name,
    this.swirloId,
    this.profilePicture,
    this.bio,
    this.location,
    this.interestedIn,
    this.ageRange,
    this.whoLikesCount,
    this.email,
    this.phoneNumber,
    this.pushNotifications,
    this.emailNotifications,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);

  ProfileModel copyWith({
    String? userId,
    String? name,
    String? swirloId,
    String? profilePicture,
    String? bio,
    String? location,
    String? interestedIn,
    String? ageRange,
    int? whoLikesCount,
    String? email,
    String? phoneNumber,
    bool? pushNotifications,
    bool? emailNotifications,
  }) {
    return ProfileModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      swirloId: swirloId ?? this.swirloId,
      profilePicture: profilePicture ?? this.profilePicture,
      bio: bio ?? this.bio,
      location: location ?? this.location,
      interestedIn: interestedIn ?? this.interestedIn,
      ageRange: ageRange ?? this.ageRange,
      whoLikesCount: whoLikesCount ?? this.whoLikesCount,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      emailNotifications: emailNotifications ?? this.emailNotifications,
    );
  }
}
