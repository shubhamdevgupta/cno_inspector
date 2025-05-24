
class VerifyOtpResponse {
  final bool? Status;
  final String? LoginId;
  final String? Message;
  final int? UserId;

  VerifyOtpResponse({
    required this.Status,
    required this.LoginId,
    required this.Message,
    required this.UserId,
  });

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponse(
      Status: json['Status'],
      LoginId: json['LoginId'],
      Message: json['Message'],
      UserId: json['UserId'],
    );
  }
}
