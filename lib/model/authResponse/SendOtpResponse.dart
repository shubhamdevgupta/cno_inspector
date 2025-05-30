

class SendOtpResponse {
  final bool? status;
  final String? message;
  final String? mobileNumber;
  final String? loginId;
  final String? responseOtp;
  final String? emailId;

  SendOtpResponse({
    required this.status,
    required this.message,
    required this.mobileNumber,
    required this.loginId,
    required this.responseOtp,
    required this.emailId,
  });

  factory SendOtpResponse.fromJson(Map<String, dynamic> json) {
    return SendOtpResponse(
      status: json['Status'],
      message: json['Message'],
      mobileNumber: json['MobileNumber'],
      loginId: json['LoginId'],
      responseOtp: json['ResponseOTP'],
      emailId: json['EmailId'],
    );
  }
}
