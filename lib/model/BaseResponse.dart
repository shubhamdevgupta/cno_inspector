// lib/models/base_response.dart

class BaseResponse {
  final bool status;
  final String message;
  final int id;

  BaseResponse({
    required this.status,
    required this.message,
    required this.id,
  });

  factory BaseResponse.fromJson(
      Map<String, dynamic> json,
      ) {
    return BaseResponse(
      status: json['Status'] ?? 0,
      message: json['msg'] ?? '',
      id: json['Id']??0
    );
  }

  Map<String, dynamic> toJson(

      ) {
    return {
      'Status': status,
      'msg': message,
      'Id': id,
    };
  }
}
