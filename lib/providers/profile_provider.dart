import 'package:flutter/foundation.dart';
import '../models/profile_model.dart';
import '../services/profile_service.dart';
import '../services/storage_service.dart';

class ProfileProvider with ChangeNotifier {
  final ProfileService _profileService = ProfileService();
  final StorageService _storageService = StorageService();

  ProfileModel? _profile;
  bool _isLoading = false;
  String? _error;

  ProfileModel? get profile => _profile;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Load profile from API
  Future<void> loadProfile() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final response = await _profileService.getProfile();

    if (response.success && response.data != null) {
      _profile = response.data;
      _error = null;
    } else {
      _error = response.message;
    }

    _isLoading = false;
    notifyListeners();
  }

  // Update profile
  Future<bool> updateProfile({
    String? name,
    String? bio,
    String? location,
    String? interestedIn,
    String? ageRange,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final response = await _profileService.updateProfile(
      name: name,
      bio: bio,
      location: location,
      interestedIn: interestedIn,
      ageRange: ageRange,
    );

    if (response.success && response.data != null) {
      _profile = response.data;
      _error = null;
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _error = response.message;
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Upload profile picture
  Future<bool> uploadProfilePicture(String filePath) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final response = await _profileService.uploadProfilePicture(filePath);

    if (response.success && response.data != null) {
      // Update the profile picture URL
      if (_profile != null) {
        _profile = _profile!.copyWith(profilePicture: response.data);
      }
      _error = null;
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _error = response.message;
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Deactivate account
  Future<bool> deactivateAccount() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final response = await _profileService.deactivateAccount();

    _isLoading = false;
    if (response.success) {
      _error = null;
      notifyListeners();
      return true;
    } else {
      _error = response.message;
      notifyListeners();
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    await _storageService.clearAll();
    _profile = null;
    _error = null;
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
