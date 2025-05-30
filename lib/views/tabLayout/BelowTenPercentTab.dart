import 'package:cno_inspection/utils/LoaderUtils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/authentication_provider.dart';
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

        return provider.isLoading?LoaderUtils.conditionalLoader(isLoading: provider.isLoading):SingleChildScrollView(
          child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DashboardCard(
                      title: "Scheme Inspection Form",
                      value: "Total Schemes \n$totalSchemes",
                      onStartPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          AppConstants.navigateToDashboardSchemeInfo,
                          arguments: {'source': "9"},
                        );
                      },
                      primaryColor: Colors.blue,
                      accentColor: Colors.blue.shade50,
                      imagePath: "assets/icons/water-supply.png",
                    ),
                    DashboardCard(
                      title: "Interaction with DWSM",
                      value: "Total Districts \n$totalDistricts",
                      onStartPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          AppConstants.navigateToDashboardDWSM,
                          arguments: {'source': "9"},
                        );
                      },
                      primaryColor: Colors.deepOrange,
                      accentColor: Colors.orange.shade50,
                      imagePath: "assets/icons/sanitizer.png",
                    ),
                    DashboardCard(
                      title: "Interaction with VWSC",
                      value: "Total VWSC \n$totalVillages",
                      onStartPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          AppConstants.navigateToDashboardVWSC,
                          arguments: {'source': "9"},
                        );
                      },
                      primaryColor: Colors.green,
                      accentColor: Colors.lightGreen.shade50,
                      imagePath: "assets/icons/village.png",
                    ),
                    ElevatedButton(
                        onPressed: () {
                          final authProvider =
                              Provider.of<AuthenticationProvider>(context,
                                  listen: false);
                          authProvider.logoutUser();
                          Navigator.pushReplacementNamed(
                              context, AppConstants.navigateToLogin);
                        },
                        child: Text('logout'))
                  ],
                ),
        );
      },
    );
  }
}
