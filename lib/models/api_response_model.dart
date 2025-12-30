class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;
  final Map<String, dynamic>? errors;
  final bool needsVerification;

  ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.errors,
    this.needsVerification = false,
  });

  factory ApiResponse.success(T data, {String? message}) {
    return ApiResponse(
      success: true,
      data: data,
      message: message,
    );
  }

  factory ApiResponse.error(
    String message, {
    Map<String, dynamic>? errors,
    bool needsVerification = false,
  }) {
    return ApiResponse(
      success: false,
      message: message,
      errors: errors,
      needsVerification: needsVerification,
    );
  }
}
