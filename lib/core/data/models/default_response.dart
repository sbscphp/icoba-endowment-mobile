class DefaultResponse {
  DefaultResponse({
    this.data,
    this.message,
    this.error,
  });

  final dynamic data;
  final String? message;
  final bool? error;

  factory DefaultResponse.fromJson(Map<String, dynamic> json) =>
      DefaultResponse(
        data: json["data"],
        message: json["message"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
    "data": data,
    "message": message,
    "error": error,
  };
}