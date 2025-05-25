// views/DashboardScreen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/DashboardResponse/DashboardResponse.dart';
import '../../provider/dashboardProvider.dart';
import '../../services/LocalStorageService.dart';
import '../../utils/AppConstants.dart';
import '../../utils/AppStyles.dart';
import '../../utils/CustomSearchableDropdown.dart';
import '../auth/DashboardScreen.dart';

class Dashboardschemeinfo extends StatefulWidget {
  const Dashboardschemeinfo({super.key});

  @override
  State<Dashboardschemeinfo> createState() => _Dashboardschemeinfo();
}

class _Dashboardschemeinfo extends State<Dashboardschemeinfo> {
  late DashboardProvider dashboardProvider;
  LocalStorageService localStorageService = LocalStorageService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      dashboardProvider =
          Provider.of<DashboardProvider>(context, listen: false);
      await dashboardProvider.fetchDashboardData(
          localStorageService.getInt(AppConstants.prefUserId)!, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    MaterialPageRoute(builder: (context) => Dashboardscreen()),
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
                        CustomSearchableDropdown(
                            title: "Select Scheme",
                            value: dashboardProvider.dashboardList
                                    .firstWhere(
                                      (district) =>
                                          district.schemeId ==
                                          dashboardProvider.selectedSchemeID,
                                      orElse: () => CnoDashboardItem(
                                        userid: 0,
                                        totalSchemes: 0,
                                        pendingSchemes: 0,
                                        underProcessScheme: 0,
                                        totalDistricts: 0,
                                        pendingDistricts: 0,
                                        underProcessDistricts: 0,
                                        totalVillages: 0,
                                        pendingVillages: 0,
                                        underProcessVillages: 0,
                                        schemeId: 0,
                                        schemeName: '',
                                        stateId: 0,
                                        districtId: 0,
                                        blockId: 0,
                                        panchayatId: 0,
                                        villageId: 0,
                                      ),
                                    )
                                    .schemeName ??
                                'Select Scheme',
                            items: dashboardProvider.dashboardList
                                .map((item) => item.schemeName ?? '')
                                .where((name) => name.isNotEmpty)
                                .toSet()
                                .toList(),
                            onChanged: (selectedScheme) {
                              if (selectedScheme == null) return;

                              final selectedItem =
                                  dashboardProvider.dashboardList.firstWhere(
                                (item) => item.schemeName == selectedScheme,
                                orElse: () => CnoDashboardItem(
                                  userid: 0,
                                  totalSchemes: 0,
                                  pendingSchemes: 0,
                                  underProcessScheme: 0,
                                  totalDistricts: 0,
                                  pendingDistricts: 0,
                                  underProcessDistricts: 0,
                                  totalVillages: 0,
                                  pendingVillages: 0,
                                  underProcessVillages: 0,
                                  schemeId: 0,
                                  schemeName: '',
                                  stateId: 0,
                                  districtId: 0,
                                  blockId: 0,
                                  panchayatId: 0,
                                  villageId: 0,
                                ),
                              );
                              dashboardProvider
                                  .setSelectedDWSM(selectedItem.districtId);
                            })
                      ],
                    ),
                    if (dashboardProvider.selectedSchemeID != 0)
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
                                    'schemeId':
                                        dashboardProvider.selectedSchemeID,
                                    'stateId': dashboardProvider
                                        .dashboardList.first.stateId,
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
                                    'schemeId':
                                        dashboardProvider.selectedSchemeID,
                                    'stateId': dashboardProvider
                                        .dashboardList.first.stateId,
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
                                    'schemeId':
                                        dashboardProvider.selectedSchemeID,
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
                                    'schemeId':
                                        dashboardProvider.selectedSchemeID,
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
                                    'schemeId':
                                        dashboardProvider.selectedSchemeID,
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
    );
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
