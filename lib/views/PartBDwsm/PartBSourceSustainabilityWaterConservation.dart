import 'package:cno_inspection/services/LocalStorageService.dart';
import 'package:cno_inspection/utils/customradiobttn.dart';
import 'package:cno_inspection/views/PartBDwsm/PartC_below_TechnoCommercialViability.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/AppStateProvider.dart';
import '../../provider/dwsmInfoProvider/DwsmProvider.dart';
import '../../utils/AppConstants.dart';
import '../../utils/AppStyles.dart';
import '../../utils/LoaderUtils.dart';
import '../../utils/customtxtfeild.dart';
import '../../utils/toast_helper.dart';
import 'DWSMCommonClass.dart';
import 'DashboardDWSM.dart';
import 'PartCMonitoringQualityandLabInfrastructure.dart';

class SourceSustainablitiyWasterConservation extends StatefulWidget {
  const SourceSustainablitiyWasterConservation({Key? key}) : super(key: key);

  @override
  _SourceSustainablitiyWasterConservation createState() =>
      _SourceSustainablitiyWasterConservation();
}

class _SourceSustainablitiyWasterConservation
    extends State<SourceSustainablitiyWasterConservation> {
  LocalStorageService localStorageService = LocalStorageService();
ProjectMode? modeType;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      if (args != null) {
        final districtid = args['districtid'] as int?;
        final stateId = args['stateId'] as int?;
        final dwsmProvider = Provider.of<Dwsmprovider>(context, listen: false);
        dwsmProvider.clearSustainabilityFields();
        if (districtid != null) {
          dwsmProvider.setDistrictId(districtid);
        }
        if (stateId != null) {
          dwsmProvider.setStateId(stateId);
        }
         modeType = Provider.of<AppStateProvider>(context, listen: false).mode;

        dwsmProvider.fetchSustainabilityData(
            stateId.toString(),
            districtid.toString(),
            localStorageService.getInt(AppConstants.prefUserId).toString(),modeType!.modeValue);
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
                "Source Sustainability and Water Conservation",
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
              builder: (context, dwsmProvider, child) {

                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 20, left: 6, right: 6, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Dwsmcommonclass(
                          no: 2,
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
                                      "1. Are source sustainability measures being promoted (e.g., groundwater recharge, reuse of treated wastewater)?",
                                  options: dwsmProvider
                                      .sourceSustainabilityMap.keys
                                      .toList(),
                                  selectedOption:
                                      dwsmProvider.sourceSustainability,
                                  onChanged: (val) =>
                                      dwsmProvider.sourceSustainability = val,
                                ),
                                const SizedBox(height: 12),

                                // Q2
                                Customradiobttn(
                                  question:
                                      "2. Are piped water schemes based on groundwater sources protected from contamination?",
                                  options: dwsmProvider
                                      .groundwaterProtectionMap.keys
                                      .toList(),
                                  selectedOption:
                                      dwsmProvider.groundwaterProtection,
                                  onChanged: (val) =>
                                      dwsmProvider.groundwaterProtection = val,
                                ),
                                const SizedBox(height: 12),

                                // Q3
                                Customradiobttn(
                                  question:
                                      "3. Is at least one recharge structure per groundwater source implemented?",
                                  options: dwsmProvider
                                      .rechargeStructureMap.keys
                                      .toList(),
                                  selectedOption:
                                      dwsmProvider.rechargeStructureImplemented,
                                  onChanged: (val) => dwsmProvider
                                      .rechargeStructureImplemented = val,
                                ),
                                if (dwsmProvider
                                        .rechargeStructureImplementedID ==
                                    3) ...[
                                  const SizedBox(height: 8),
                                  Customtxtfeild(
                                    label: "If no, reason:",
                                    controller:
                                        dwsmProvider.rechargeReasonController,
                                  ),
                                ],
                                const SizedBox(height: 12),

                                // Q4
                                Customradiobttn(
                                  question:
                                      "4. Are any impact studies or assessments conducted on source sustainability efforts?",
                                  options: dwsmProvider.impactStudiesMap.keys
                                      .toList(),
                                  selectedOption: dwsmProvider.impactStudies,
                                  onChanged: (val) =>
                                      dwsmProvider.impactStudies = val,
                                ),
                                SizedBox(
                                  height: 10,
                                ),

                                //TODO Please add this question in below 10%
                                Visibility(
                                  visible: modeType == ProjectMode.below10,
                                  child: Customradiobttn(
                                    question:
                                        "5. •	Does the district have an NABL-accredited lab or equivalent for water quality testing?",
                                    options:
                                        dwsmProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                        dwsmProvider.accreditedLabWaterQuality,
                                    onChanged: (val) => dwsmProvider
                                        .accreditedLabWaterQuality = val,
                                  ),
                                ),
                                if (dwsmProvider.accreditedLabWaterQualityID ==
                                    2) ...[
                                  const SizedBox(height: 8),
                                  Customtxtfeild(
                                    label: "If no, how is testing managed:",
                                    controller: dwsmProvider
                                        .testingManagedDataController,
                                  ),
                                ],

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
                                        LoaderUtils.showLoadingWithMessage(
                                            context,
                                            isLoading: dwsmProvider.isLoading,
                                            message:
                                                "Saving Source Sustainability and Water Conservation");

                                     await  dwsmProvider.saveSourceSustainability(
                                            userId: localStorageService.getInt(
                                                AppConstants.prefUserId)!,
                                            stateId: dwsmProvider.stateId!,
                                            districtId:
                                                dwsmProvider.districtId!,
                                            areSustainabilityMeasuresPromoted:
                                                dwsmProvider
                                                    .sourceSustainabilityId,
                                            areGWSourcesProtected: dwsmProvider
                                                .groundwaterProtectionId,
                                            isRechargeStructureImplemented:
                                                dwsmProvider
                                                    .rechargeStructureImplementedID,
                                            reasonIfNotImplemented: dwsmProvider
                                                .rechargeReasonController.text,
                                            areImpactStudiesConducted:
                                                dwsmProvider.impactStudiesID,
                                            accrediteLabWaterQuality:
                                                dwsmProvider
                                                    .accreditedLabWaterQualityID,
                                            accrediteLabWaterQualityNoRemark:
                                                dwsmProvider
                                                    .testingManagedDataController
                                                    .text,
                                            modeType: modeType!.modeValue);

                                        if (dwsmProvider.status!) {
                                          ToastHelper.showToastMessage(
                                              dwsmProvider.message!,
                                              backgroundColor: Colors.green);
                                          if(modeType==ProjectMode.below10){
                                            Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      PartcBelowTechnocommercialviabilityP()),
                                            );
                                          }else{
                                            Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      MonitioringQuality()),
                                            );
                                          }

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
                            ),
                          ),
                        ),
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
