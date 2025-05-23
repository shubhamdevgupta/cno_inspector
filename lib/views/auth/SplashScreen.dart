import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/authentication_provider.dart';
import '../../services/LocalStorageService.dart';
import '../../utils/AppConstants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final LocalStorageService localStorage = LocalStorageService();

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 1)); // Optional splash delay

    final authProvider = Provider.of<AuthenticationProvider>(
        context, listen: false);
    await authProvider.checkLoginStatus();
    print("login statin-->>${authProvider.isLoggedIn}");
    if (authProvider.isLoggedIn) {
      Navigator.pushReplacementNamed(
          context, AppConstants.navigateToDashboard);
    }else{
      Navigator.pushReplacementNamed(
          context, AppConstants.navigateToLogin);
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
