import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/dashboardProvider.dart';
import '../../utils/AppConstants.dart';
import 'DashboardCard.dart';

class BelowTenPercentTab extends StatelessWidget {
  const BelowTenPercentTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        final hasData = provider.cnoDashboardHomeList.isNotEmpty;
        final data = hasData ? provider.cnoDashboardHomeList.first : null;
        final int totalSchemes = data?.totalSchemeBelow ?? 0;
        final int totalDistricts = data?.totalDistrictBelow ?? 0;
        final int totalVillages = data?.totalVillageBelow ?? 0;

        return SingleChildScrollView(
          child: Column(
            children: [
              DashboardCard(
                title: "Scheme Inspection Form",
                baselineStatus: "Total Schemes \n$totalSchemes",
                onStartPressed: () {
                  Navigator.pushReplacementNamed(
                      context, AppConstants.navigateToDashboardSchemeInfo,
                    arguments: {'source': "9"},
                  );
                },
              ),
              DashboardCard(
                title: "Interaction with DWSM",
                baselineStatus: "Total Districts \n$totalDistricts",
                onStartPressed: () {
                  Navigator.pushReplacementNamed(
                      context, AppConstants.navigateToDashboardDWSM,
                    arguments: {'source': "9"},
                  );
                },
              ),
              DashboardCard(
                title: "Interaction with VWSC",
                baselineStatus: "Total VWSC \n$totalVillages",
                onStartPressed: () {
                  Navigator.pushReplacementNamed(
                      context, AppConstants.navigateToDashboardVWSC,
                    arguments: {'source': "9"},
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
