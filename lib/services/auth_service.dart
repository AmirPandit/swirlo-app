import 'package:dio/dio.dart';
import 'dart:convert';
import '../config/api_config.dart';
import '../models/auth_response_model.dart';
import '../models/api_response_model.dart';
import '../models/user_model.dart';
import 'api_service.dart';
import 'storage_service.dart';

class AuthService {
  final ApiService _apiService = ApiService();
  final StorageService _storage = StorageService();

  // Login with email and password
  Future<ApiResponse<AuthResponseModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiService.dio.post(
        ApiConfig.loginEndpoint,
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // Extract data from GenericResponse wrapper
        final responseData = response.data['data'];
        final authResponse = AuthResponseModel.fromJson(responseData);

        // Save tokens
        await _storage.saveAccessToken(authResponse.accessToken);
        await _storage.saveRefreshToken(authResponse.refreshToken);
        await _storage.saveUserId(authResponse.userId);

        // Save user data
        final userData = UserModel(
          userId: authResponse.userId,
          email: email,
          isVerified: authResponse.isVerified,
          isActive: authResponse.isActive,
        );
        await _storage.saveUserData(jsonEncode(userData.toJson()));

        return ApiResponse.success(authResponse);
      }

      return ApiResponse.error('Login failed');
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred: ${e.toString()}');
    }
  }

  // Register new user
  Future<ApiResponse<UserModel>> register({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await _apiService.dio.post(
        ApiConfig.registerEndpoint,
        data: {
          'email': email,
          'password': password,
          'confirm_password': confirmPassword,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Extract data from GenericResponse wrapper
        final responseData = response.data['data'];
        final userResponse = UserModel.fromJson(responseData);

        return ApiResponse.success(
          userResponse,
          message: response.data['message'],
        );
      }

      return ApiResponse.error('Registration failed');
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred: ${e.toString()}');
    }
  }

  // Verify user with verification code
  Future<ApiResponse<UserModel>> verifyUser({
    required String email,
    required String verificationCode,
  }) async {
    try {
      final response = await _apiService.dio.post(
        ApiConfig.verifyEndpoint,
        data: {
          'email': email,
          'verification_code': verificationCode,
        },
      );

      if (response.statusCode == 200) {
        // Extract data from GenericResponse wrapper
        final responseData = response.data['data'];
        final userResponse = UserModel.fromJson(responseData);

        return ApiResponse.success(
          userResponse,
          message: response.data['message'],
        );
      }

      return ApiResponse.error('Verification failed');
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred: ${e.toString()}');
    }
  }

  // Resend verification code
  Future<ApiResponse<void>> resendVerificationCode({
    required String email,
  }) async {
    try {
      final response = await _apiService.dio.post(
        ApiConfig.resendVerificationEndpoint,
        data: {
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        return ApiResponse.success(
          null,
          message: response.data['message'] ?? 'Verification code sent successfully',
        );
      }

      return ApiResponse.error('Failed to resend verification code');
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred: ${e.toString()}');
    }
  }

  // Request password reset code
  Future<ApiResponse<void>> forgotPassword({
    required String email,
  }) async {
    try {
      final response = await _apiService.dio.post(
        ApiConfig.forgotPasswordEndpoint,
        data: {
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        return ApiResponse.success(
          null,
          message: response.data['message'] ?? 'Password reset code sent to your email',
        );
      }

      return ApiResponse.error('Failed to send reset code');
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred: ${e.toString()}');
    }
  }

  // Verify password reset code
  Future<ApiResponse<void>> verifyResetCode({
    required String email,
    required String resetCode,
  }) async {
    try {
      final response = await _apiService.dio.post(
        ApiConfig.verifyResetCodeEndpoint,
        data: {
          'email': email,
          'reset_code': resetCode,
        },
      );

      if (response.statusCode == 200) {
        return ApiResponse.success(
          null,
          message: response.data['message'] ?? 'Reset code verified',
        );
      }

      return ApiResponse.error('Failed to verify reset code');
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred: ${e.toString()}');
    }
  }

  // Reset password with verified code
  Future<ApiResponse<void>> resetPassword({
    required String email,
    required String resetCode,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final response = await _apiService.dio.post(
        ApiConfig.resetPasswordEndpoint,
        data: {
          'email': email,
          'reset_code': resetCode,
          'new_password': newPassword,
          'confirm_password': confirmPassword,
        },
      );

      if (response.statusCode == 200) {
        return ApiResponse.success(
          null,
          message: response.data['message'] ?? 'Password reset successfully',
        );
      }

      return ApiResponse.error('Failed to reset password');
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred: ${e.toString()}');
    }
  }

  // Logout
  Future<ApiResponse<void>> logout() async {
    try {
      await _storage.clearAll();
      return ApiResponse.success(null, message: 'Logged out successfully');
    } catch (e) {
      // Clear local data even if something fails
      await _storage.clearAll();
      return ApiResponse.success(null);
    }
  }

  // Get stored user data
  Future<UserModel?> getStoredUser() async {
    try {
      final userData = await _storage.getUserData();
      if (userData != null) {
        return UserModel.fromJson(jsonDecode(userData));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Check if user is authenticated
  Future<bool> isAuthenticated() async {
    final token = await _storage.getAccessToken();
    return token != null;
  }

  // Handle Dio errors
  ApiResponse<T> _handleDioError<T>(DioException error) {
    if (error.response != null) {
      final statusCode = error.response!.statusCode;
      final data = error.response!.data;

      // Extract message from GenericResponse wrapper if available
      String errorMessage = 'An error occurred';

      if (data is Map<String, dynamic>) {
        if (data.containsKey('message')) {
          // Handle message field which might be a map or string
          if (data['message'] is Map) {
            // Extract message from nested map
            final messageMap = data['message'] as Map<String, dynamic>;
            if (messageMap.containsKey('message')) {
              errorMessage = messageMap['message'].toString();
            } else if (messageMap.containsKey('is_verified')) {
              // Handle unverified user case
              final isVerified = messageMap['is_verified'];
              if (isVerified == false) {
                errorMessage = 'Account not verified. Please check your email for the verification code.';
              } else {
                errorMessage = messageMap.toString();
              }
            } else {
              errorMessage = messageMap.toString();
            }
          } else if (data['message'] is String) {
            errorMessage = data['message'];
          } else {
            errorMessage = data['message'].toString();
          }
        } else if (data.containsKey('detail')) {
          // Handle detail field which might be a map or string
          if (data['detail'] is Map) {
            errorMessage = data['detail']['message'] ?? errorMessage;
          } else {
            errorMessage = data['detail'].toString();
          }
        }
      }

      // Check if this is an unverified user error
      bool isUnverified = false;
      if (data is Map<String, dynamic> && data.containsKey('message')) {
        if (data['message'] is Map) {
          final messageMap = data['message'] as Map<String, dynamic>;
          if (messageMap.containsKey('is_verified') && messageMap['is_verified'] == false) {
            isUnverified = true;
          }
        }
      }

      if (statusCode == 400 || statusCode == 422) {
        return ApiResponse.error(
          errorMessage,
          errors: data is Map<String, dynamic> ? data['errors'] : null,
          needsVerification: isUnverified,
        );
      } else if (statusCode == 401) {
        return ApiResponse.error(errorMessage);
      } else if (statusCode == 500) {
        return ApiResponse.error('Server error. Please try again later.');
      }

      return ApiResponse.error(errorMessage, needsVerification: isUnverified);
    }

    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return ApiResponse.error('Connection timeout. Please check your internet.');
    }

    return ApiResponse.error('Network error. Please try again.');
  }
}
