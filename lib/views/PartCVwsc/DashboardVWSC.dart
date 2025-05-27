// views/DashboardScreen.dart
import 'package:cno_inspection/model/DashboardResponse/DashboardResponse.dart';
import 'package:cno_inspection/provider/vwscInfoProvider/VwscProvider.dart';
import 'package:cno_inspection/views/tabLayout/DashboardTabView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/AppStateProvider.dart';
import '../../provider/dashboardProvider.dart';
import '../../services/LocalStorageService.dart';
import '../../utils/AppConstants.dart';
import '../../utils/AppStyles.dart';
import '../../utils/CustomSearchableDropdown.dart';
import '../auth/DashboardScreen.dart';

class Dashboardvwsc extends StatefulWidget {
  const Dashboardvwsc({super.key});

  @override
  State<Dashboardvwsc> createState() => _Dashboardvwsc();
}

class _Dashboardvwsc extends State<Dashboardvwsc> {
  final LocalStorageService _localStorage = LocalStorageService();

  late DashboardProvider dashboardProvider;
  late Vwscprovider vwscprovider;
  String path = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      dashboardProvider =
          Provider.of<DashboardProvider>(context, listen: false);
      final mode = Provider.of<AppStateProvider>(context, listen: false).mode;

      await dashboardProvider.fetchDashboardData(_localStorage.getInt(AppConstants.prefUserId)!,3,mode.modeValue);
      _localStorage.saveInt(
          "villageId", dashboardProvider.dashboardList.first.villageId);

      vwscprovider = Provider.of<Vwscprovider>(context, listen: false);

      //part a clear
       vwscprovider.clearValuesforqueA();

       vwscprovider.clearValuesforqueA();

       // part b clear
      vwscprovider.clearCommunityInvolvementData();

      // part c clear
      vwscprovider.clearCommunityFeedback();

      // part d clear
      vwscprovider.clearFetchWaterQuality();

      //part e clear
      vwscprovider.clearFetchGrievance();

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
                "Interaction with VWSC",
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
              final mode = Provider.of<AppStateProvider>(context, listen: false).mode;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select VWSC",
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
                        // Space between title and dropdown
                        CustomSearchableDropdown(
                          title: 'Select VWSC',
                          value: dashboardProvider.dashboardList
                                  .firstWhere(
                                    (village) =>
                                        village.villageId ==
                                        dashboardProvider.selectedVwscId,
                                    orElse: () =>CnoDashboardItem.empty(),
                                  )
                                  .villageName ??
                              'Select Village',
                          items: dashboardProvider.dashboardList
                              .map((item) => item.villageName ?? '')
                              .where((name) => name.isNotEmpty)
                              .toSet()
                              .toList(), // Ensure uniqueness
                          onChanged: (selectedVillageName) {
                            if (selectedVillageName == null) return;

                            final selectedItem =
                                dashboardProvider.dashboardList.firstWhere(
                              (item) => item.villageName == selectedVillageName,
                              orElse: () => CnoDashboardItem.empty(),
                            );

                            dashboardProvider
                                .setSelectedVWSC(selectedItem.villageId);
                            print(
                                'village id ${dashboardProvider.selectedVwscId}');

                            path = _buildLocationPath([
                              selectedItem.stateName ?? '',
                              selectedItem.districtName ?? '',
                              selectedItem.blockName ?? '',
                              selectedItem.panchayatName ?? '',
                              selectedItem.villageName ?? '',
                            ]);
                          },
                        ),
                      ],
                    ),
                    if (dashboardProvider.selectedVwscId != 0)
                      Column(
                        children: [
                          Visibility(
                            visible: path.isNotEmpty,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _iconCircle(Icons.location_on, Colors.red),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    path,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Visibility(
                            visible: mode == ProjectMode.above10,
                            child: buildSampleCard(
                              qnumber: "A.",
                              title: "Water Supply Functionality",
                              color: Colors.blue,
                              onTap: () {
                                final selectedVillageId =
                                    dashboardProvider.selectedVwscId;
                                final stateId =
                                    dashboardProvider.dashboardList.first.stateId;
                                print('sending----- $stateId');
                                Navigator.pushReplacementNamed(context,
                                    AppConstants.navigateToWaterSupplyPartA,
                                    arguments: {
                                      'villageId': selectedVillageId,
                                      'stateId': stateId,
                                    });
                              },
                            ),
                          ),

                          Visibility(
                            visible: mode == ProjectMode.below10,
                            child: buildSampleCard(
                              qnumber: "A.",
                              title: "Water Supply Functionality",
                              color: Colors.blue,
                              onTap: () {
                                final selectedVillageId =
                                    dashboardProvider.selectedVwscId;
                                final stateId =
                                    dashboardProvider.dashboardList.first.stateId;
                                print('sending----- $stateId');
                                Navigator.pushReplacementNamed(context,
                                    AppConstants.navigateToBelowPartAWaterSupplyFunctionality,
                                    arguments: {
                                      'villageId': selectedVillageId,
                                      'stateId': stateId,
                                    });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          buildSampleCard(
                            qnumber: "B.",
                            title: "Community Involvement & VWSC Functionality",
                            color: Colors.orangeAccent,
                            onTap: () {
                              final selectedVillageId =
                                  dashboardProvider.selectedVwscId;
                              final stateId =
                                  dashboardProvider.dashboardList.first.stateId;
                              Navigator.pushReplacementNamed(
                                  context,
                                  AppConstants
                                      .navigateToCommunityInvolvementPartB,
                                  arguments: {
                                    'villageId': selectedVillageId,
                                    'stateId': stateId,
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
                              title:
                                  "Community feedback on quality of construction",
                              color: Colors.deepOrangeAccent,
                              onTap: () {
                                final selectedVillageId =
                                    dashboardProvider.selectedVwscId;
                                final stateId =
                                    dashboardProvider.dashboardList.first.stateId;
                                Navigator.pushReplacementNamed(context,
                                    AppConstants.navigateToCommunityFeedbackPartC,
                                    arguments: {
                                      'villageId': selectedVillageId,
                                      'stateId': stateId,
                                    });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            visible: mode == ProjectMode.below10,
                            child: buildSampleCard(
                              qnumber: "C.",
                              title: "Water Quality Monitoring",
                              color: Colors.lightGreen,
                              onTap: () {
                                final selectedVillageId =
                                    dashboardProvider.selectedVwscId;
                                final stateId =
                                    dashboardProvider.dashboardList.first.stateId;
                                Navigator.pushReplacementNamed(
                                    context, AppConstants.navigateToQulityPartD,
                                    arguments: {
                                      'villageId': selectedVillageId,
                                      'stateId': stateId,
                                    });
                              },
                            ),
                          ),

                          Visibility(
                            visible: mode == ProjectMode.above10,
                            child: buildSampleCard(
                              qnumber: "D.",
                              title: "Water Quality Monitoring",
                              color: Colors.lightGreen,
                              onTap: () {
                                final selectedVillageId =
                                    dashboardProvider.selectedVwscId;
                                final stateId =
                                    dashboardProvider.dashboardList.first.stateId;
                                Navigator.pushReplacementNamed(
                                    context, AppConstants.navigateToQulityPartD,
                                    arguments: {
                                      'villageId': selectedVillageId,
                                      'stateId': stateId,
                                    });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            visible: mode == ProjectMode.below10,
                            child: buildSampleCard(
                              qnumber: "D.",
                              title: "Grievance Redressal",
                              color: Colors.green,
                              onTap: () {
                                final selectedVillageId =
                                    dashboardProvider.selectedVwscId;
                                final stateId =
                                    dashboardProvider.dashboardList.first.stateId;
                                Navigator.pushReplacementNamed(
                                    context, AppConstants.navigateToGrievancePartE,
                                    arguments: {
                                      'villageId': selectedVillageId,
                                      'stateId': stateId,
                                    });
                              },
                            ),
                          ),

                          Visibility(
                            visible: mode == ProjectMode.above10,
                            child: buildSampleCard(
                              qnumber: "E.",
                              title: "Grievance Redressal",
                              color: Colors.green,
                              onTap: () {
                                final selectedVillageId =
                                    dashboardProvider.selectedVwscId;
                                final stateId =
                                    dashboardProvider.dashboardList.first.stateId;
                                Navigator.pushReplacementNamed(
                                    context, AppConstants.navigateToGrievancePartE,
                                    arguments: {
                                      'villageId': selectedVillageId,
                                      'stateId': stateId,
                                    });
                              },
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              );
            })),
      ),
    );
  }

  String _buildLocationPath(List<String?> parts) {
    return parts.where((e) => e != null && e.isNotEmpty).join(" > ");
  }

  Widget _iconCircle(IconData icon, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: bgColor, size: 18),
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
