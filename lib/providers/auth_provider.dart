import 'package:flutter/foundation.dart';
import 'dart:convert';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/storage_service.dart';

enum AuthStatus {
  uninitialized,
  authenticated,
  unauthenticated,
  authenticating,
}

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final StorageService _storage = StorageService();

  AuthStatus _status = AuthStatus.uninitialized;
  UserModel? _user;
  String? _errorMessage;
  bool _needsVerification = false;

  // Getters
  AuthStatus get status => _status;
  UserModel? get user => _user;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _status == AuthStatus.authenticated;
  bool get isLoading => _status == AuthStatus.authenticating;
  bool get needsVerification => _needsVerification;

  // Initialize - Check for existing session
  Future<void> initialize() async {
    try {
      final isAuth = await _authService.isAuthenticated();
      if (isAuth) {
        // Load user from storage
        final storedUser = await _authService.getStoredUser();
        if (storedUser != null) {
          _user = storedUser;
          _status = AuthStatus.authenticated;
        } else {
          _status = AuthStatus.unauthenticated;
        }
      } else {
        _status = AuthStatus.unauthenticated;
      }
    } catch (e) {
      _status = AuthStatus.unauthenticated;
    }
    notifyListeners();
  }

  // Login
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _status = AuthStatus.authenticating;
    _errorMessage = null;
    _needsVerification = false;
    notifyListeners();

    final response = await _authService.login(
      email: email,
      password: password,
    );

    if (response.success && response.data != null) {
      // Create user model from auth response
      _user = UserModel(
        userId: response.data!.userId,
        email: email,
        isVerified: response.data!.isVerified,
        isActive: response.data!.isActive,
      );
      _status = AuthStatus.authenticated;
      _needsVerification = false;
      notifyListeners();
      return true;
    } else {
      _errorMessage = response.message;
      _needsVerification = response.needsVerification;
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  // Register
  Future<bool> register({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    _status = AuthStatus.authenticating;
    _errorMessage = null;
    notifyListeners();

    final response = await _authService.register(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );

    if (response.success && response.data != null) {
      // Registration successful, user needs to verify
      _errorMessage = null;
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return true;
    } else {
      _errorMessage = response.message;
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  // Verify user
  Future<bool> verifyUser({
    required String email,
    required String verificationCode,
  }) async {
    _status = AuthStatus.authenticating;
    _errorMessage = null;
    notifyListeners();

    final response = await _authService.verifyUser(
      email: email,
      verificationCode: verificationCode,
    );

    if (response.success && response.data != null) {
      _errorMessage = null;
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return true;
    } else {
      _errorMessage = response.message;
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  // Resend verification code
  Future<bool> resendVerificationCode({
    required String email,
  }) async {
    _errorMessage = null;

    final response = await _authService.resendVerificationCode(
      email: email,
    );

    if (response.success) {
      _errorMessage = response.message;
      notifyListeners();
      return true;
    } else {
      _errorMessage = response.message;
      notifyListeners();
      return false;
    }
  }

  // Request password reset code
  Future<bool> forgotPassword({
    required String email,
  }) async {
    _status = AuthStatus.authenticating;
    _errorMessage = null;
    notifyListeners();

    final response = await _authService.forgotPassword(
      email: email,
    );

    if (response.success) {
      _errorMessage = response.message;
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return true;
    } else {
      _errorMessage = response.message;
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  // Verify password reset code
  Future<bool> verifyResetCode({
    required String email,
    required String resetCode,
  }) async {
    _status = AuthStatus.authenticating;
    _errorMessage = null;
    notifyListeners();

    final response = await _authService.verifyResetCode(
      email: email,
      resetCode: resetCode,
    );

    if (response.success) {
      _errorMessage = response.message;
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return true;
    } else {
      _errorMessage = response.message;
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  // Reset password
  Future<bool> resetPassword({
    required String email,
    required String resetCode,
    required String newPassword,
    required String confirmPassword,
  }) async {
    _status = AuthStatus.authenticating;
    _errorMessage = null;
    notifyListeners();

    final response = await _authService.resetPassword(
      email: email,
      resetCode: resetCode,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );

    if (response.success) {
      _errorMessage = response.message;
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return true;
    } else {
      _errorMessage = response.message;
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    _status = AuthStatus.unauthenticated;
    _errorMessage = null;
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
