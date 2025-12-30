class ApiConfig {
  // Base URL - Update this with your backend server URL
  // For Android emulator: 'http://10.0.2.2:8000/api'
  // For iOS simulator: 'http://localhost:8000/api'
  // For physical device: 'http://YOUR_COMPUTER_IP:8000/api' (e.g., 'http://192.168.1.100:8000/api')
  // For production: 'https://your-production-url.com/api'
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  // Authentication endpoints (matching backend routes)
  static const String loginEndpoint = '/login';
  static const String registerEndpoint = '/register';
  static const String verifyEndpoint = '/verify';
  static const String resendVerificationEndpoint = '/resend_verification_code';
  static const String refreshTokenEndpoint = '/refresh_token';

  // Password reset endpoints
  static const String forgotPasswordEndpoint = '/forget-password';
  static const String verifyResetCodeEndpoint = '/verify_reset_code';
  static const String resetPasswordEndpoint = '/reset_password';

  // Timeout configurations
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Storage keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
  static const String userIdKey = 'user_id';
}
