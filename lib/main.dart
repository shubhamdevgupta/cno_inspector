import 'package:cno_inspection/provider/AppStateProvider.dart';
import 'package:cno_inspection/provider/ErrorProvider.dart';
import 'package:cno_inspection/provider/authentication_provider.dart';
import 'package:cno_inspection/provider/dashboardProvider.dart';
import 'package:cno_inspection/provider/dwsmInfoProvider/DwsmProvider.dart';
import 'package:cno_inspection/provider/schemeInfoProvider/SchemeProvider.dart';

import 'package:cno_inspection/provider/vwscInfoProvider/VwscProvider.dart';
import 'package:cno_inspection/services/LocalStorageService.dart';
import 'package:cno_inspection/utils/AppConstants.dart';
import 'package:cno_inspection/views/PartASchemeInfo/PartASchemeInfoUserobservation.dart';
import 'package:cno_inspection/views/PartBDwsm/DashboardDWSM.dart';
import 'package:cno_inspection/views/PartBDwsm/PartACoordinationPlanningReviewScreen.dart';
import 'package:cno_inspection/views/PartBDwsm/PartBDWSMUserobservation.dart';
import 'package:cno_inspection/views/PartBDwsm/PartBSourceSustainabilityWaterConservation.dart';
import 'package:cno_inspection/views/PartBDwsm/PartCMonitoringQualityandLabInfrastructure.dart';
import 'package:cno_inspection/views/PartBDwsm/PartC_below_TechnoCommercialViability.dart';
import 'package:cno_inspection/views/PartBDwsm/PartDOperationandMaintenance.dart';
import 'package:cno_inspection/views/PartBDwsm/PartEQualityAssuranceandCommissioning.dart';
import 'package:cno_inspection/views/PartBDwsm/PartFPublicComplaintsandGrievance.dart';
import 'package:cno_inspection/views/PartCVwsc/CommunityFeedbackPartC.dart';
import 'package:cno_inspection/views/PartCVwsc/CommunityInvolvementPartB.dart';
import 'package:cno_inspection/views/PartCVwsc/DashboardVWSC.dart';
import 'package:cno_inspection/views/PartCVwsc/GrievancePartE.dart';
import 'package:cno_inspection/views/PartCVwsc/PartA_below_WaterSupply.dart';
import 'package:cno_inspection/views/PartCVwsc/PartCVWSCUserobservation.dart';
import 'package:cno_inspection/views/PartCVwsc/WaterQualityPartD.dart';
import 'package:cno_inspection/views/PartCVwsc/WaterSupplyPartA.dart';

import 'package:cno_inspection/views/auth/DashboardScreen.dart';
import 'package:cno_inspection/views/auth/AuthScreen.dart';
import 'package:cno_inspection/views/auth/SplashScreen.dart';
import 'package:cno_inspection/views/PartASchemeInfo/Dashboardschemeinfo.dart';
import 'package:cno_inspection/views/PartASchemeInfo/PartBSchemePlanningScreen.dart';
import 'package:cno_inspection/views/PartASchemeInfo/PartASourceScreen.dart';
import 'package:cno_inspection/views/PartASchemeInfo/PartCRetrofittingAugmentationScreen.dart';
import 'package:cno_inspection/views/PartASchemeInfo/PartDSchemeImplementationScreen.dart';
import 'package:cno_inspection/views/PartASchemeInfo/PartEVisual%20Inspection.dart';
import 'package:cno_inspection/views/tabLayout/DashboardTabView.dart';
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
        ChangeNotifierProvider(create: (_) => Schemeprovider()),
        ChangeNotifierProvider(create: (_) => Dwsmprovider()),
        ChangeNotifierProvider(create: (_) => ErrorProvider()),
        ChangeNotifierProvider(create: (_) => AppStateProvider()),


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
        AppConstants.navigateToDashboardHome: (context) => DashboardTabView(),
        AppConstants.navigateToLogin: (context) => Loginscreen(),
        AppConstants.navigateToDashboardSchemeInfo: (context) => Dashboardschemeinfo(),
        AppConstants.navigateToDashboardDWSM: (context) => Dashboarddwsm(),
        AppConstants.navigateToDashboardVWSC: (context) => Dashboardvwsc(),


        AppConstants.navigateToSourceScreenQuestions: (context) => SourceScreenQuestions(),
        AppConstants.navigateToSchemePlanningScreen: (context) => SchemePlanningScreen(),
        AppConstants.navigateToRetrofittingAugmentationScreen: (context) => RetrofittingAugmentationScreen(),
        AppConstants.navigateToSchemeImplementationScreen: (context) => SchemeImplementationScreen(),
        AppConstants.navigateToVisualInspectionScreen: (context) => VisualInspectionScreen(),

        AppConstants.navigateToPartaschemeinfouserobservation: (context) => Partaschemeinfouserobservation(),

        AppConstants.navigateToCoordinationPlanningScreen: (context) => CoordinationPlanningReview(),
        AppConstants.navigateToSourceSustainablitiyWasterConservation: (context) => SourceSustainablitiyWasterConservation(),
        AppConstants.navigateToMonitoringQuality: (context) => MonitioringQuality(),
        AppConstants.navigateToOperationandMaintance: (context) => PartDoperationandmaintenance(),
        AppConstants.navigateToQualityAssurance: (context) => PartEQualityAssuranceCommissioning(),
        AppConstants.navigateToPartFPublicCompliant: (context) => PartFPublicCompliant(),
        AppConstants.navigateToBelowPartCTechnoCommercialViability: (context) => PartcBelowTechnocommercialviabilityP(),
        AppConstants.navigateToBelowPartAWaterSupplyFunctionality: (context) => PartaBelowWatersupply(),
        AppConstants.navigateToPartbdwsmuserobservation: (context) => Partbdwsmuserobservation(),

        AppConstants.navigateToWaterSupplyPartA: (context) => WaterSupplyPartA(),
        AppConstants.navigateToCommunityInvolvementPartB: (context) => CommunityInvolvementPartB(),
        AppConstants.navigateToCommunityFeedbackPartC: (context) => CommunityFeedbackPartC(),
        AppConstants.navigateToQulityPartD: (context) => WaterQualityPartD(),
        AppConstants.navigateToGrievancePartE: (context) => GrievancePartE(),
        AppConstants.navigateToPartcvwscuserobservation: (context) => Partcvwscuserobservation(),


      },
    );
  }
}
