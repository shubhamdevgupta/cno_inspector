import 'package:cno_inspection/provider/authentication_provider.dart';
import 'package:cno_inspection/utils/AppConstants.dart';

import 'package:cno_inspection/views/InteractionVWSC/WaterSupplyPartA.dart';

import 'package:cno_inspection/views/InteractionDWSM/DashboardDWSM.dart';
import 'package:cno_inspection/views/InteractionVWSC/DashboardVWSC.dart';
import 'package:cno_inspection/views/InteractionVWSC/vwscScreen.dart';

import 'package:cno_inspection/views/auth/DashboardScreen.dart';
import 'package:cno_inspection/views/auth/LoginScreen.dart';
import 'package:cno_inspection/views/auth/SplashScreen.dart';
import 'package:cno_inspection/views/schemeInfo/Dashboardschemeinfo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WaterSupplyPartA(),
        AppConstants.navigateToDashboard: (context) => Dashboardscreen(),
        AppConstants.navigateToLogin: (context) => Loginscreen(),
        AppConstants.navigateToDashboardSchemeInfo: (context) => Dashboardschemeinfo(),
        AppConstants.navigateToDashboardDWSM: (context) => Dashboarddwsm(),
        AppConstants.navigateToDashboardVWSC: (context) => Dashboardvwsc(),
      },
    );
  }
}
