import 'dart:async';
import 'dart:convert';

import 'package:cno_inspection/model/authResponse/VerifyOtpResponse.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

import '../model/authResponse/SendOtpResponse.dart';
import '../repository/AuthenticaitonRepository.dart';
import '../services/LocalStorageService.dart';
import '../utils/AppConstants.dart';
import '../utils/CurrentLocation.dart';
import '../utils/GlobalExceptionHandler.dart';
import '../utils/LocationUtils.dart';

class AuthenticationProvider extends ChangeNotifier {
  final AuthenticaitonRepository _authRepository = AuthenticaitonRepository();
  final LocalStorageService _localStorage = LocalStorageService();

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;
  bool _isLoading = false;

  // Getters
  SendOtpResponse? _sendOtpResponse;

  SendOtpResponse? get sendOtpResponse => _sendOtpResponse;

  // Getters
  VerifyOtpResponse? _verifyOtpResponse;

  VerifyOtpResponse? get verifyOtpResponse => _verifyOtpResponse;

  bool get isLoading => _isLoading;
  String errorMsg = '';

  bool _isOtpButtonEnabled = true;
  bool get isOtpButtonEnabled => _isOtpButtonEnabled;

  int _otpTimerSeconds = 0;
  int get otpTimerSeconds => _otpTimerSeconds;

  bool _obscureOtp = true;
  bool get obscureOtp => _obscureOtp;

  Timer? _timer;

  Future<void> checkLoginStatus() async {
    _isLoggedIn = _localStorage.getBool(AppConstants.prefIsLoggedIn) ?? false;
    notifyListeners();
  }

  Future<void> logoutUser() async {
    _isLoggedIn = false;
    await _localStorage.remove(AppConstants.prefIsLoggedIn);
    notifyListeners();
  }

  // Method to login user
  Future<void> sendOtp(loginId, Function onSuccess, Function onFailure) async {
    _isLoading = true;
    notifyListeners();
    try {
      _sendOtpResponse = await _authRepository.sendOtp(loginId);
      if (_sendOtpResponse!.status == true) {
        _isLoggedIn = true;
        _localStorage.saveBool(AppConstants.prefIsLoggedIn, true);
        _startOtpTimer();
        notifyListeners();
        onSuccess();
      } else {
        errorMsg = _sendOtpResponse!.message!;
        onFailure(errorMsg);
      }
    } catch (e) {
      GlobalExceptionHandler.handleException(e as Exception);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> verifyOtp(
      loginId, otp, Function onSuccess, Function onFailure) async {
    _isLoading = true;
    try {
      _verifyOtpResponse = await _authRepository.verifyOtp(loginId, otp);
      if (_verifyOtpResponse!.Status == true) {
        _localStorage.saveInt(AppConstants.prefUserId,verifyOtpResponse!.UserId! );
        onSuccess();
      } else {
        errorMsg = _verifyOtpResponse!.Message!;
        onFailure(errorMsg);
      }
    } catch (e) {
      GlobalExceptionHandler.handleException(e as Exception);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  void _startOtpTimer() {
    _isOtpButtonEnabled = false;
    _otpTimerSeconds = 120; // 2 minutes
    notifyListeners();

    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_otpTimerSeconds <= 1) {
        timer.cancel();
        _isOtpButtonEnabled = true;
        _otpTimerSeconds = 0;
      } else {
        _otpTimerSeconds--;
      }
      notifyListeners();
    });
  }
  String get formattedOtpTimer {
    final minutes = (_otpTimerSeconds ~/ 60).toString().padLeft(1, '0');
    final seconds = (_otpTimerSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  void toggleOtpVisibility() {
    _obscureOtp = !_obscureOtp;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

}
