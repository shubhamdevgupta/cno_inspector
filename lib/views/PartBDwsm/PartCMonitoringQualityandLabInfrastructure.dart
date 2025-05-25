import 'package:cno_inspection/services/LocalStorageService.dart';
import 'package:cno_inspection/utils/AppConstants.dart';
import 'package:cno_inspection/utils/customradiobttn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/dwsmInfoProvider/DwsmProvider.dart';
import '../../utils/AppStyles.dart';
import '../../utils/LoaderUtils.dart';
import '../../utils/customtxtfeild.dart';
import '../../utils/toast_helper.dart';
import 'DWSMCommonClass.dart';
import 'DashboardDWSM.dart';
import 'PartDOperationandMaintenance.dart';

class MonitioringQuality extends StatefulWidget {
  const MonitioringQuality({Key? key}) : super(key: key);

  @override
  _MonitioringQuality createState() => _MonitioringQuality();
}

class _MonitioringQuality extends State<MonitioringQuality> {
  LocalStorageService localStorageService = LocalStorageService();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      final args =
      ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      if (args != null) {
        final districtid = args['districtid'] as int?;
        final stateId = args['stateId'] as int?;
        final dwsmProvider = Provider.of<Dwsmprovider>(context, listen: false);
        if (districtid != null) {
          dwsmProvider.setDistrictId(districtid);
        }
        if (stateId != null) {
          dwsmProvider.setStateId(stateId);
        }
        dwsmProvider.fetchCoordinationData("31", "478", "121212");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Replace the current route with a new one
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => Dashboarddwsm()),
        );

        // Return false to prevent the default back navigation behavior
        return false;
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/icons/header_bg.png'),
              fit: BoxFit.cover),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              // Removes the default back button
              centerTitle: true,
              title: Text(
                "Monitoring, Quality and Lab Infrastructure",
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
                      MaterialPageRoute(builder: (context) => Dashboarddwsm()),
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
            body: Consumer<Dwsmprovider>(
              builder: (context, dwsmProvider, childe) {
                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 20, left: 6, right: 6, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Dwsmcommonclass(
                          no: 3,
                        ),
                        Card(
                          elevation: 5,
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.deepOrangeAccent, width: 1.4),
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12.withOpacity(0.06),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(5),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Customradiobttn(
                                    question:
                                        "1. Are water supply assets (OHTs, WTPs, Pump Houses, etc.) geotagged?",
                                    options: dwsmProvider
                                        .assetsGeotaggedMap.keys
                                        .toList(),
                                    selectedOption:
                                        dwsmProvider.assetsGeotagged,
                                    onChanged: (val) {
                                      dwsmProvider.assetsGeotagged = val;
                                    },
                                  ),
                                  SizedBox(height: 12),
                                  Customradiobttn(
                                    question:
                                        "2. Does the district have an NABL-accredited lab or equivalent for water quality testing?",
                                    options:
                                        dwsmProvider.yesNoMap.keys.toList(),
                                    selectedOption: dwsmProvider.hasNablLab,
                                    onChanged: (val) {
                                      dwsmProvider.hasNablLab = val;
                                    },
                                  ),
                                  if (dwsmProvider.hasNablLabID == 2)
                                    Customtxtfeild(
                                      label:
                                          "2.1 If no, how is testing managed?",
                                      controller:
                                          dwsmProvider.testingManagedController,
                                    ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: SizedBox(
                                      height: 35,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.deepOrange,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10), // Adjust the radius as needed
                                          ),
                                        ),
                                        onPressed: () async {

                                          LoaderUtils.showLoadingWithMessage(context,
                                          isLoading: dwsmProvider.isLoading,message: "Saving  Monitoring, Quality and Lab Infrastructure");

                                          await dwsmProvider.saveMonitoringQualityLab(userId: localStorageService.getInt(AppConstants.prefUserId)!, stateId: dwsmProvider.stateId!, districtId: dwsmProvider.districtId!,
                                              areAssetsGeotagged: dwsmProvider.assetsGeotaggedID, hasNABLLab: dwsmProvider.hasNablLabID,
                                              testingManagementDescription: dwsmProvider.testingManagedController.text);
                                          if (dwsmProvider.status!) {
                                            ToastHelper.showToastMessage(
                                                dwsmProvider.message!,
                                                backgroundColor: Colors.green);
                                            Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      PartDoperationandmaintenance()),
                                            );
                                          } else {
                                            ToastHelper.showToastMessage(
                                                dwsmProvider.message!,
                                                backgroundColor: Colors.red);
                                          }
                                        },
                                        child: Text(
                                          "SAVE & NEXT",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
}
