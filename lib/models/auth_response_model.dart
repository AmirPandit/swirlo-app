import 'package:json_annotation/json_annotation.dart';

part 'auth_response_model.g.dart';

@JsonSerializable()
class AuthResponseModel {
  @JsonKey(name: 'access_token')
  final String accessToken;

  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  @JsonKey(name: 'user_id')
  final String userId;

  @JsonKey(name: 'token_type')
  final String tokenType;

  @JsonKey(name: 'is_verified')
  final bool isVerified;

  @JsonKey(name: 'is_active')
  final bool isActive;

  final String? email;

  AuthResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
    this.tokenType = 'bearer',
    this.isVerified = false,
    this.isActive = false,
    this.email,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);
}
