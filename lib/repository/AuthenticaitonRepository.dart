import 'dart:convert';

import 'package:cno_inspection/model/authResponse/VerifyOtpResponse.dart';

import '../model/authResponse/SendOtpResponse.dart';
import '../services/BaseApiService.dart';

class AuthenticaitonRepository {
  final BaseApiService _apiService = BaseApiService();

  Future<SendOtpResponse> sendOtp(String loginId) async {
    try {
      final response = await _apiService.post(
        '/CNOSurvey/SendOTP',
        body: jsonEncode({
          'LoginId': loginId,
        }),
      );

      return SendOtpResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<VerifyOtpResponse> verifyOtp(String loginId, String otp) async {
    try {
      final response = await _apiService.post(
        '/CNOSurvey/VerifyOTP',
        body: jsonEncode({
          'LoginId': loginId,
          'OTP': otp,
        }),
      );

      return VerifyOtpResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
