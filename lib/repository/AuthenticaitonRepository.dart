import 'dart:convert';

import '../model/LoginResponse.dart';
import '../services/BaseApiService.dart';

class AuthenticaitonRepository {
  final BaseApiService _apiService = BaseApiService();

  Future<LoginResponse> loginUser(
      String phoneNumber, String password, String txtSalt, int appId) async {
    try {
      final response = await _apiService.post(
        'APIMobile/Login',
        body: jsonEncode({
          'loginid': phoneNumber,
          'password': password,
          'txtSaltedHash': txtSalt,
          'App_id': appId
        }),
      );

      return LoginResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
