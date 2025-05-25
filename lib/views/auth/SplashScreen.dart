import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/UpdateProvider.dart';
import '../../provider/authentication_provider.dart';
import '../../services/LocalStorageService.dart';
import '../../utils/AppConstants.dart';
import '../../utils/UpdateDialog.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final LocalStorageService localStorage = LocalStorageService();
  final UpdateViewModel _updateViewModel = UpdateViewModel();

  @override
  void initState() {
    super.initState();
    _checkForUpdateAndNavigate();
  }

  Future<void> _checkForUpdateAndNavigate() async {
    bool isAvailable = await _updateViewModel.checkForUpdate();
    print('Update available: $isAvailable');

    if (isAvailable && mounted) {
      final updateInfo = await _updateViewModel.getUpdateInfo();

      if (updateInfo != null) {
        print(
            "Dialog will show with: ${updateInfo.apkUrl}, ${updateInfo.whatsNew}");

        // Show dialog and stop further navigation until user interacts
        DialogUtils.showUpdateDialog(context, updateInfo);
        return;
      }
    }
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(
        const Duration(milliseconds: 500)); // Optional splash delay

    final authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    await authProvider.checkLoginStatus();
    print("login statin-->>${authProvider.isLoggedIn}");
    if (authProvider.isLoggedIn) {
      Navigator.pushReplacementNamed(context, AppConstants.navigateToDashboard);
    } else {
      Navigator.pushReplacementNamed(context, AppConstants.navigateToLogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/icons/wqmis_splash.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
/*
9871544420*/
