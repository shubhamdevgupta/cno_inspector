// views/DashboardScreen.dart
import 'package:cno_inspection/provider/dwsmInfoProvider/DwsmProvider.dart';
import 'package:cno_inspection/utils/CustomSearchableDropdown.dart';
import 'package:cno_inspection/utils/Showerrormsg.dart';
import 'package:cno_inspection/views/tabLayout/DashboardTabView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/DashboardResponse/DashboardResponse.dart';
import '../../provider/AppStateProvider.dart';
import '../../provider/dashboardProvider.dart';
import '../../services/LocalStorageService.dart';
import '../../utils/AppConstants.dart';
import '../../utils/AppStyles.dart';
import '../auth/DashboardScreen.dart';

class Dashboarddwsm extends StatefulWidget {
  const Dashboarddwsm({super.key});

  @override
  State<Dashboarddwsm> createState() => _Dashboarddwsm();
}

class _Dashboarddwsm extends State<Dashboarddwsm> {
  late DashboardProvider dashboardProvider;
  late Dwsmprovider dwsmprovider;
  LocalStorageService localStorageService = LocalStorageService();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      dashboardProvider =
          Provider.of<DashboardProvider>(context, listen: false);
      final modeType = Provider.of<AppStateProvider>(context, listen: false).mode;

      await dashboardProvider.fetchDashboardData(localStorageService.getInt(AppConstants.prefUserId)!,2,modeType.modeValue);

      dwsmprovider = Provider.of<Dwsmprovider>(context, listen: false);

      //clear part a
      dwsmprovider.clearCoordinationFields();

      // clear part b
      dwsmprovider.clearSustainabilityFields();

      // clear part c

      dwsmprovider.clearMonitoringFields();

      //clear part d
      dwsmprovider.clearfetchOperationMaintenanceData();
      //clear part e
      dwsmprovider.clearfetchQualityAssuranceData();
      // clear part f
      dwsmprovider.clearfetchGrievanceRedressalData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mode = Provider.of<AppStateProvider>(context, listen: false).mode;
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
              "Interaction with DWSM ",
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
            if (dashboardProvider.dashboardList.isEmpty) {
              AppTextWidgets.errorText(dashboardProvider.errorMsg);
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
                        "Select DWSM",
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
                      SizedBox(height: 4),
                      CustomSearchableDropdown(
                          title: "Select DWSM",
                          value: dashboardProvider.dashboardList
                                  .firstWhere(
                                    (district) =>
                                        district.districtId ==
                                        dashboardProvider.selectedDwsmID,
                                    orElse: () => CnoDashboardItem.empty(),
                                  )
                                  .districtName ??
                              'Select DWSM',
                          items: dashboardProvider.dashboardList
                              .map((item) => item.districtName ?? '')
                              .where((name) => name.isNotEmpty)
                              .toSet()
                              .toList(),
                          onChanged: (selectedDistrict) {
                            if (selectedDistrict == null) return;

                            final selectedItem =
                                dashboardProvider.dashboardList.firstWhere(
                              (item) => item.districtName == selectedDistrict,
                              orElse: () => CnoDashboardItem.empty(),
                            );

                            dashboardProvider
                                .setSelectedDWSM(selectedItem.districtId);
                            print('village id ${dashboardProvider}');
                          })
                    ],
                  ),
                 // if (dashboardProvider.selectedDwsmID != 0)
                    Column(
                      children: [
                        buildSampleCard(
                          qnumber: "A.",
                          title: "Coordination, Planning & Review Mechanism",
                          color: Colors.blue,
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context,
                                AppConstants
                                    .navigateToCoordinationPlanningScreen,
                                arguments: {
                                  'districtid':
                                      dashboardProvider.selectedDwsmID,
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
                          title: "Source Sustainability and Water Conservation",
                          color: Colors.orangeAccent,
                          onTap: () {
                            // Your onTap logic
                            Navigator.pushReplacementNamed(
                                context,
                                AppConstants
                                    .navigateToSourceSustainablitiyWasterConservation,
                                arguments: {
                                  'districtid':
                                      dashboardProvider.selectedDwsmID,
                                  'stateId': dashboardProvider
                                      .dashboardList.first.stateId,
                                });
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        Visibility(
                          visible: mode == ProjectMode.above10,
                          child: buildSampleCard(
                            qnumber: "C.",
                            title: "Monitoring, Quality and Lab Infrastructure",
                            color: Colors.deepOrangeAccent,
                            onTap: () {
                              // Your onTap logic
                              Navigator.pushReplacementNamed(context,
                                  AppConstants.navigateToMonitoringQuality,
                                  arguments: {
                                    'districtid':
                                        dashboardProvider.selectedDwsmID,
                                    'stateId': dashboardProvider
                                        .dashboardList.first.stateId,
                                  });
                            },
                          ),
                        ),


                        Visibility(
                          visible: mode == ProjectMode.below10,
                          child: buildSampleCard(
                            qnumber: "C.",
                            title: "Techno-Commercial Viability",
                            color: Colors.deepOrangeAccent,
                            onTap: () {
                              // Your onTap logic
                              Navigator.pushReplacementNamed(context,
                                  AppConstants.navigateToBelowPartCTechnoCommercialViability,
                                  arguments: {
                                    'districtid':
                                        dashboardProvider.selectedDwsmID,
                                    'stateId': dashboardProvider
                                        .dashboardList.first.stateId,
                                  });
                            },
                          ),
                        ),


                        SizedBox(
                          height: 10,
                        ),



                        Visibility(
                          visible: mode == ProjectMode.above10,
                          child: buildSampleCard(
                            qnumber: "D.",
                            title: "Operation & Maintenance (O&M)",
                            color: Colors.lightGreen,
                            onTap: () {
                              // Your onTap logic
                              Navigator.pushReplacementNamed(context,
                                  AppConstants.navigateToOperationandMaintance,
                                  arguments: {
                                    'districtid':
                                        dashboardProvider.selectedDwsmID,
                                    'stateId': dashboardProvider
                                        .dashboardList.first.stateId,
                                  });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),



                        Visibility(
                          visible: mode == ProjectMode.above10,
                          child: buildSampleCard(
                            qnumber: "E.",
                            title: "Quality Assurance and Commissioning",
                            color: Colors.green,
                            onTap: () {
                              // Your onTap logic
                              Navigator.pushReplacementNamed(context,
                                  AppConstants.navigateToQualityAssurance,
                                  arguments: {
                                    'districtid':
                                        dashboardProvider.selectedDwsmID,
                                    'stateId': dashboardProvider
                                        .dashboardList.first.stateId,
                                  });
                            },
                          ),
                        ),



                        Visibility(
                          visible: mode == ProjectMode.below10,
                          child: buildSampleCard(
                            qnumber: "D",
                            title: "Quality Assurance and Commissioning",
                            color: Colors.green,
                            onTap: () {
                              // Your onTap logic
                              Navigator.pushReplacementNamed(context,
                                  AppConstants.navigateToQualityAssurance,
                                  arguments: {
                                    'districtid':
                                        dashboardProvider.selectedDwsmID,
                                    'stateId': dashboardProvider
                                        .dashboardList.first.stateId,
                                  });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),


                        Visibility(
                          visible: mode == ProjectMode.above10,
                          child: buildSampleCard(
                            qnumber: "F.",
                            title: "Public Complaints and Grievance Redressal",
                            color: Colors.deepPurpleAccent,
                            onTap: () {
                              // Your onTap logic
                              Navigator.pushReplacementNamed(context,
                                  AppConstants.navigateToPartFPublicCompliant,
                                  arguments: {
                                    'districtid':
                                        dashboardProvider.selectedDwsmID,
                                    'stateId': dashboardProvider
                                        .dashboardList.first.stateId,
                                  });
                            },
                          ),
                        ),

                        Visibility(
                          visible: mode == ProjectMode.below10,
                          child: buildSampleCard(
                            qnumber: "E.",
                            title: "Public Complaints and Grievance Redressal",
                            color: Colors.deepPurpleAccent,
                            onTap: () {
                              // Your onTap logic
                              Navigator.pushReplacementNamed(context,
                                  AppConstants.navigateToPartFPublicCompliant,
                                  arguments: {
                                    'districtid':
                                        dashboardProvider.selectedDwsmID,
                                    'stateId': dashboardProvider
                                        .dashboardList.first.stateId,
                                  });
                            },
                          ),
                        ),

                        SizedBox(height: 10,),

                        buildSampleCard(
                          qnumber: "*",
                          title: "User Feedback",
                          color: Colors.redAccent,
                          onTap: () {
                            // Your onTap logic
                            Navigator.pushReplacementNamed(context,
                                AppConstants.navigateToPartbdwsmuserobservation,
                                arguments: {
                                  'districtid':
                                      dashboardProvider.selectedDwsmID,
                                  'stateId': dashboardProvider
                                      .dashboardList.first.stateId,
                                });
                          },
                        ),
                      ],
                    )
                ],
              ),
            );
          })),
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
