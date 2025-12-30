import 'package:dio/dio.dart';
import '../models/profile_model.dart';
import '../models/api_response_model.dart';
import 'api_service.dart';

class ProfileService {
  final ApiService _apiService = ApiService();

  // Get user profile
  Future<ApiResponse<ProfileModel>> getProfile() async {
    try {
      final response = await _apiService.dio.get('/profile');

      if (response.statusCode == 200) {
        final profile = ProfileModel.fromJson(response.data['data']);
        return ApiResponse.success(
          profile,
          message: response.data['message'] ?? 'Profile fetched successfully',
        );
      } else {
        return ApiResponse.error(
          response.data['message'] ?? 'Failed to fetch profile',
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(
        e.response?.data['message'] ?? 'Network error occurred',
      );
    } catch (e) {
      return ApiResponse.error(
        'An unexpected error occurred',
      );
    }
  }

  // Update user profile
  Future<ApiResponse<ProfileModel>> updateProfile({
    String? name,
    String? bio,
    String? location,
    String? interestedIn,
    String? ageRange,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (name != null) data['name'] = name;
      if (bio != null) data['bio'] = bio;
      if (location != null) data['location'] = location;
      if (interestedIn != null) data['interested_in'] = interestedIn;
      if (ageRange != null) data['age_range'] = ageRange;

      final response = await _apiService.dio.put('/profile', data: data);

      if (response.statusCode == 200) {
        final profile = ProfileModel.fromJson(response.data['data']);
        return ApiResponse.success(
          profile,
          message: response.data['message'] ?? 'Profile updated successfully',
        );
      } else {
        return ApiResponse.error(
          response.data['message'] ?? 'Failed to update profile',
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(
        e.response?.data['message'] ?? 'Network error occurred',
      );
    } catch (e) {
      return ApiResponse.error(
        'An unexpected error occurred',
      );
    }
  }

  // Upload profile picture
  Future<ApiResponse<String>> uploadProfilePicture(String filePath) async {
    try {
      final formData = FormData.fromMap({
        'profile_picture': await MultipartFile.fromFile(filePath),
      });

      final response = await _apiService.dio.post(
        '/profile/picture',
        data: formData,
      );

      if (response.statusCode == 200) {
        final imageUrl = response.data['data']['url'] as String;
        return ApiResponse.success(
          imageUrl,
          message: response.data['message'] ?? 'Profile picture uploaded successfully',
        );
      } else {
        return ApiResponse.error(
          response.data['message'] ?? 'Failed to upload profile picture',
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(
        e.response?.data['message'] ?? 'Network error occurred',
      );
    } catch (e) {
      return ApiResponse.error(
        'An unexpected error occurred',
      );
    }
  }

  // Get who likes you
  Future<ApiResponse<List<dynamic>>> getWhoLikesYou() async {
    try {
      final response = await _apiService.dio.get('/profile/who-likes-you');

      if (response.statusCode == 200) {
        final likes = response.data['data'] as List<dynamic>;
        return ApiResponse.success(
          likes,
          message: response.data['message'] ?? 'Fetched successfully',
        );
      } else {
        return ApiResponse.error(
          response.data['message'] ?? 'Failed to fetch',
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(
        e.response?.data['message'] ?? 'Network error occurred',
      );
    } catch (e) {
      return ApiResponse.error(
        'An unexpected error occurred',
      );
    }
  }

  // Deactivate account
  Future<ApiResponse<void>> deactivateAccount() async {
    try {
      final response = await _apiService.dio.post('/profile/deactivate');

      if (response.statusCode == 200) {
        return ApiResponse.success(
          null,
          message: response.data['message'] ?? 'Account deactivated successfully',
        );
      } else {
        return ApiResponse.error(
          response.data['message'] ?? 'Failed to deactivate account',
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(
        e.response?.data['message'] ?? 'Network error occurred',
      );
    } catch (e) {
      return ApiResponse.error(
        'An unexpected error occurred',
      );
    }
  }
}
