import 'package:cno_inspection/provider/authentication_provider.dart';
import 'package:cno_inspection/provider/dashboardProvider.dart';
import 'package:cno_inspection/provider/vwscInfoProvider/VwscProvider.dart';
import 'package:cno_inspection/services/LocalStorageService.dart';
import 'package:cno_inspection/utils/AppConstants.dart';
import 'package:cno_inspection/views/InteractionDWSM/PartACoordinationPlanningReviewScreen.dart';
import 'package:cno_inspection/views/InteractionDWSM/PartBSourceSustainabilityWaterConservation.dart';
import 'package:cno_inspection/views/InteractionDWSM/PartCMonitoringQualityandLabInfrastructure.dart';
import 'package:cno_inspection/views/InteractionDWSM/PartDOperationandMaintenance.dart';
import 'package:cno_inspection/views/InteractionDWSM/PartEQualityAssuranceandCommissioning.dart';
import 'package:cno_inspection/views/InteractionDWSM/PartFPublicComplaintsandGrievance.dart';
import 'package:cno_inspection/views/InteractionVWSC/CommunityFeedbackPartC.dart';
import 'package:cno_inspection/views/InteractionVWSC/CommunityInvolvementPartB.dart';
import 'package:cno_inspection/views/InteractionVWSC/GrievancePartE.dart';
import 'package:cno_inspection/views/InteractionVWSC/WaterQualityPartD.dart';

import 'package:cno_inspection/views/InteractionVWSC/WaterSupplyPartA.dart';

import 'package:cno_inspection/views/InteractionDWSM/DashboardDWSM.dart';
import 'package:cno_inspection/views/InteractionVWSC/DashboardVWSC.dart';

import 'package:cno_inspection/views/auth/DashboardScreen.dart';
import 'package:cno_inspection/views/auth/AuthScreen.dart';
import 'package:cno_inspection/views/auth/SplashScreen.dart';
import 'package:cno_inspection/views/schemeInfo/Dashboardschemeinfo.dart';
import 'package:cno_inspection/views/schemeInfo/PartBSchemePlanningScreen.dart';
import 'package:cno_inspection/views/schemeInfo/PartASourceScreen.dart';
import 'package:cno_inspection/views/schemeInfo/PartCRetrofittingAugmentationScreen.dart';
import 'package:cno_inspection/views/schemeInfo/PartDSchemeImplementationScreen.dart';
import 'package:cno_inspection/views/schemeInfo/PartEVisual%20Inspection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => Vwscprovider()),
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
        '/': (context) => SplashScreen(),
        AppConstants.navigateToDashboard: (context) => Dashboardscreen(),
        AppConstants.navigateToLogin: (context) => Loginscreen(),
        AppConstants.navigateToDashboardSchemeInfo: (context) => Dashboardschemeinfo(),
        AppConstants.navigateToDashboardDWSM: (context) => Dashboarddwsm(),
        AppConstants.navigateToDashboardVWSC: (context) => Dashboardvwsc(),


        AppConstants.navigateToSourceScreenQuestions: (context) => SourceScreenQuestions(),
        AppConstants.navigateToSchemePlanningScreen: (context) => SchemePlanningScreen(),
        AppConstants.navigateToRetrofittingAugmentationScreen: (context) => RetrofittingAugmentationScreen(),
        AppConstants.navigateToSchemeImplementationScreen: (context) => SchemeImplementationScreen(),
        AppConstants.navigateToVisualInspectionScreen: (context) => VisualInspectionScreen(),

        AppConstants.navigateToCoordinationPlanningScreen: (context) => CoordinationPlanningReview(),
        AppConstants.navigateToSourceSustainablitiyWasterConservation: (context) => SourceSustainablitiyWasterConservation(),
        AppConstants.navigateToMonitoringQuality: (context) => MonitioringQuality(),
        AppConstants.navigateToOperationandMaintance: (context) => PartDoperationandmaintenance(),
        AppConstants.navigateToQualityAssurance: (context) => PartEQualityAssuranceCommissioning(),
        AppConstants.navigateToPartFPublicCompliant: (context) => PartFPublicCompliant(),

        AppConstants.navigateToWaterSupplyPartA: (context) => WaterSupplyPartA(),
        AppConstants.navigateToCommunityInvolvementPartB: (context) => CommunityInvolvementPartB(),
        AppConstants.navigateToCommunityFeedbackPartC: (context) => CommunityFeedbackPartC(),
        AppConstants.navigateToQulityPartD: (context) => WaterQualityPartD(),
        AppConstants.navigateToGrievancePartE: (context) => GrievancePartE(),


      },
    );
  }
}
