import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/dashboardProvider.dart';
import '../../utils/AppConstants.dart';
import 'DashboardCard.dart';

class AboveTenPercentTab extends StatelessWidget {
  const AboveTenPercentTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        final hasData = provider.cnoDashboardHomeList.isNotEmpty;
        final data = hasData ? provider.cnoDashboardHomeList.first : null;

        final int totalSchemes = data?.totalSchemeUpper ?? 0;
        final int totalDistricts = data?.totalDistrictUpper ?? 0;
        final int totalVillages = data?.totalVillageUpper ?? 0;

        return SingleChildScrollView(
          child: Column(
            children: [

              DashboardCard(
                title: "Scheme Inspection Form",
                baselineStatus: "Total Schemes \n$totalSchemes",
                onStartPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    AppConstants.navigateToDashboardSchemeInfo,
                    arguments: {'source': "10"},
                  );
                },
                primaryColor: Colors.blue,
                accentColor: Colors.blue.shade50,
                imagePath: "assets/icons/water-supply.png",
              ),


              DashboardCard(
                title: "Interaction with DWSM",
                baselineStatus: "Total Districts \n$totalDistricts",
                onStartPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    AppConstants.navigateToDashboardDWSM,
                    arguments: {'source': "10"},
                  );
                },
                primaryColor: Colors.deepOrangeAccent,
                accentColor: Colors.orange.shade50,
                imagePath: "assets/icons/sanitizer.png",
              ),

              DashboardCard(
                title: "Interaction with VWSC",
                baselineStatus: "Total VWSC \n$totalVillages",
                onStartPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    AppConstants.navigateToDashboardVWSC,
                    arguments: {'source': "10"},
                  );
                },
                primaryColor: Colors.green,
                accentColor: Colors.lightGreen.shade50,
                imagePath: "assets/icons/village.png",
              ),
            ],
          ),
        );
      },
    );
  }
}
