// views/DashboardScreen.dart
import 'package:cno_inspection/provider/schemeInfoProvider/SchemeProvider.dart';
import 'package:cno_inspection/views/tabLayout/DashboardTabView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/AppStateProvider.dart';
import '../../provider/dashboardProvider.dart';
import '../../services/LocalStorageService.dart';
import '../../utils/AppConstants.dart';
import '../../utils/AppStyles.dart';
import '../../utils/CustomDropdown.dart';
import '../auth/DashboardScreen.dart';

class Dashboardschemeinfo extends StatefulWidget {
  const Dashboardschemeinfo({super.key});

  @override
  State<Dashboardschemeinfo> createState() => _Dashboardschemeinfo();
}

class _Dashboardschemeinfo extends State<Dashboardschemeinfo> {
  late DashboardProvider dashboardProvider;
  late Schemeprovider schemeprovider;
  LocalStorageService localStorageService = LocalStorageService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      dashboardProvider =Provider.of<DashboardProvider>(context,listen: false);

      final mode = Provider.of<AppStateProvider>(context, listen: false).mode;

      await dashboardProvider.fetchDashboardData(localStorageService.getInt(AppConstants.prefUserId)!,1,mode.modeValue);
      dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
      schemeprovider = Provider.of<Schemeprovider>(context,listen: false);
      //clear for part a
      schemeprovider.clearfetchSourceSurvey();
      //clear for part b
      schemeprovider.clearfetchSchemePlanning();
      //clear for part c
      schemeprovider.clearfetchAdditionalInfoRetrofit();
      //clear for part d
      schemeprovider.clearSchemeImplementationData();
      //clear for par e
      schemeprovider.clearVisualInspectionAnswers();

    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Replace the current route with a new one
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => DashboardTabView()),
        );

        return false;
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/icons/header_bg.png'), fit: BoxFit.cover),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              // Removes the default back button
              centerTitle: true,
              title: Text(
                "Scheme Inspection",
                style: AppStyles.appBarTitle,
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.pop(context);
                  } else {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => DashboardTabView()),
                      (route) => false,
                    );
                  }
                },
              ),

              //elevation
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF096DA8), // Dark blue color
                      Color(0xFF3C8DBC), // Green color
                    ],
                    begin: Alignment.topCenter, // Start at the top center
                    end: Alignment.bottomCenter, // End at the bottom center
                  ),
                ),
              ),
              elevation: 5,
            ),
            body: Consumer<DashboardProvider>(
              builder: (context, dashboardProvider, child) {
                if (dashboardProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select Scheme",
                            style: TextStyle(
                              fontSize: 16, fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold,
                              color: Colors
                                  .black87, // Dark text for better readability
                            ),
                          ),

                        const Divider(
                          height: 10,
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        SizedBox(height: 4), // Space between title and dropdown
                        CustomDropdown(
                          value: dashboardProvider.selectedSchemeID,
                          items: dashboardProvider.dashboardList.map((scheme) {
                            return DropdownMenuItem<String>(
                              value: scheme.schemeId.toString(),
                              child: Text(
                                scheme.schemeName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                            );
                          }).toList(),
                          title: "",
                          appBarTitle: "Select Scheme",
                          showSearchBar: false,
                          onChanged: (value) {
                            dashboardProvider.setSelectedScheme(value);
                          },
                        )
                      ],
                    ),
                    if (dashboardProvider.selectedSchemeID !=null && dashboardProvider.selectedSchemeID!.isNotEmpty)
                      Column(
                        children: [
                          buildSampleCard(
                            qnumber: "A.",
                            title: "Source",
                            color: Colors.blue,
                            onTap: () {
                              Navigator.pushReplacementNamed(context,
                                  AppConstants.navigateToSourceScreenQuestions,
                                  arguments: {
                                    'schemeId': int.parse(dashboardProvider.selectedSchemeID!),
                                    'stateId': dashboardProvider.dashboardList.first.stateId,
                                  });
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          buildSampleCard(
                            qnumber: "B.",
                            title: "Scheme Planning",
                            color: Colors.orangeAccent,
                            onTap: () {
                              Navigator.pushReplacementNamed(context,
                                  AppConstants.navigateToSchemePlanningScreen,
                                  arguments: {
                                    'schemeId': int.parse(dashboardProvider.selectedSchemeID!),
                                    'stateId': dashboardProvider.dashboardList.first.stateId,
                                  });
                              // Your onTap logic
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          buildSampleCard(
                            qnumber: "C.",
                            title: "Additional information for Retrofitting",
                            color: Colors.deepOrangeAccent,
                            onTap: () {
                              // Your onTap logic
                              Navigator.pushReplacementNamed(
                                  context,
                                  AppConstants
                                      .navigateToRetrofittingAugmentationScreen,
                                  arguments: {
                                    'schemeId':int.parse(dashboardProvider.selectedSchemeID!),
                                    'stateId': dashboardProvider
                                        .dashboardList.first.stateId,
                                  });
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          buildSampleCard(
                            qnumber: "D.",
                            title: "Scheme implementation",
                            color: Colors.lightGreen,
                            onTap: () {
                              // Your onTap logic
                              Navigator.pushReplacementNamed(
                                  context,
                                  AppConstants
                                      .navigateToSchemeImplementationScreen,
                                  arguments: {
                                    'schemeId':int.parse(dashboardProvider.selectedSchemeID!),
                                    'stateId': dashboardProvider
                                        .dashboardList.first.stateId,
                                  });
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          buildSampleCard(
                            qnumber: "E.",
                            title: "Visual Inspection",
                            color: Colors.green,
                            onTap: () {
                              // Your onTap logic
                              Navigator.pushReplacementNamed(context,
                                  AppConstants.navigateToVisualInspectionScreen,
                                  arguments: {
                                    'schemeId':int.parse(dashboardProvider.selectedSchemeID!),
                                    'stateId': dashboardProvider
                                        .dashboardList.first.stateId,
                                  });
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              );
            },
          )),
    ));
  }

  Widget buildSampleCard({
    required String qnumber,
    required String title,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: color.withOpacity(0.4), width: 1.4),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.06),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // QNumber badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    qnumber,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Title text
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),

                // Count badge
              ],
            ),
            const SizedBox(height: 14),

            // Continue button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onTap,
                icon: const Icon(Icons.arrow_forward,
                    size: 18, color: Colors.white),
                label: const Text(
                  "Continue",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
