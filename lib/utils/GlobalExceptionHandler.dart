import 'package:flutter/material.dart';
import '../main.dart'; // Ensure this has `navigatorKey`
import '../utils/toast_helper.dart';
import '../views/auth/ExceptionScreen.dart';
import 'CustomException.dart';

class GlobalExceptionHandler {
  static void handleException(Exception e) {
    print("Exception caught: $e");

    if (navigatorKey.currentContext == null) {
      debugPrint("Navigator key context is null.");
      return;
    }

    final context = navigatorKey.currentContext!;
    String errorMessage = e is AppException ? e.toString() : "Unexpected error occurred\n$e";

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (e is NetworkException) {
        if (navigatorKey.currentState?.canPop() == true) {
          navigatorKey.currentState?.pop();
        }
        ToastHelper.showSnackBar(context, errorMessage);
      } else {
        if (navigatorKey.currentState?.canPop() == true) {
          navigatorKey.currentState?.pop();
        }
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            contentPadding: EdgeInsets.zero,
            content: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.4,
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              child: ExceptionScreen(errorMessage: errorMessage),
            ),
          ),
        );
      }
    });
  }
}
