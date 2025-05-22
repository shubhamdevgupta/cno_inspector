import 'package:cno_inspection/provider/authentication_provider.dart';
import 'package:cno_inspection/utils/AppConstants.dart';
import 'package:cno_inspection/views/InteractionVWSC/vwscScreen.dart';
import 'package:cno_inspection/views/auth/DashboardScreen.dart';
import 'package:cno_inspection/views/auth/LoginScreen.dart';
import 'package:cno_inspection/views/schemeInfo/SchemePlanningScreen.dart';
import 'package:cno_inspection/views/schemeInfo/SourceScreen.dart';
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
    //    '/': (context) => SWMQuestions(),
        '/': (context) => SourceScreenQuestions(),
        AppConstants.navigateSchemePlanningScreen: (context) => SchemePlanningScreen(),
        AppConstants.navigateToDashboard: (context) => Dashboardscreen(),
        AppConstants.navigateToLogin: (context) => Loginscreen(),
      },
    );
  }
}
