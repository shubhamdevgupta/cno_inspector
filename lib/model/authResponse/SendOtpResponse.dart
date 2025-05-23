
/*{
"Status": true,
"Message": "Sucess",
"MobileNumber": "7738705450",
"LoginId": "9871544420"
}*/

class SendOtpResponse {
  final bool? Status;
  final String? Message;
  final String? MobileNumber;
  final String? LoginId;

  SendOtpResponse({
    required this.Status,
    required this.Message,
    required this.MobileNumber,
    required this.LoginId,
  });

  factory SendOtpResponse.fromJson(Map<String, dynamic> json) {
    return SendOtpResponse(
      Status: json['Status'],
      Message: json['Message'],
      MobileNumber: json['MobileNumber'],
      LoginId: json['LoginId'],

    );
  }
}
