
class ApiResponse<T> {
  final T? data;
  final String? message;
  final bool? error;


  const ApiResponse({
    this.data,
    this.message,
    this.error,
  });


  factory ApiResponse.fromJson(
      Map<String, dynamic> json,
      T Function(dynamic)? fromJsonT,
      ) {
          final rawData = json['data'];

  // Handle empty list or null — treat as no data
  final isEmptyOrNull = rawData == null || (rawData is List && rawData.isEmpty);

    return ApiResponse<T>(
      data: isEmptyOrNull ? null : (fromJsonT == null ? null : fromJsonT(rawData)),
      message: json['message'] as String?,
      error: json['error'] as bool?,
    );
  }

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) => {
    'data': data == null ? null : toJsonT(data as T),
    'message': message,
    'error': error,
  };

  @override
  String toString() => 'ApiResponse<$T>(error: $error, data: $data)';
}

