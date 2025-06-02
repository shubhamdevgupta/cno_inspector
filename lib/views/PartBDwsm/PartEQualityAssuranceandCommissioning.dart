import 'package:cno_inspection/services/LocalStorageService.dart';
import 'package:cno_inspection/utils/AppConstants.dart';
import 'package:cno_inspection/utils/customradiobttn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/AppStateProvider.dart';
import '../../provider/dwsmInfoProvider/DwsmProvider.dart';
import '../../utils/AppStyles.dart';
import '../../utils/LoaderUtils.dart';
import '../../utils/MultiSelectionlist.dart';
import '../../utils/customtxtfeild.dart';
import '../../utils/toast_helper.dart';
import 'AboveDWSMCommonClass.dart';
import 'BelowDWSMCommon.dart';
import 'DashboardDWSM.dart';
import 'PartBDWSMUserobservation.dart';
import 'PartFPublicComplaintsandGrievance.dart';

class PartEQualityAssuranceCommissioning extends StatefulWidget {
  const PartEQualityAssuranceCommissioning({Key? key}) : super(key: key);

  @override
  _PartEQualityAssuranceCommissioning createState() =>
      _PartEQualityAssuranceCommissioning();
}

class _PartEQualityAssuranceCommissioning
    extends State<PartEQualityAssuranceCommissioning> {
  LocalStorageService localStorageService = LocalStorageService();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final  modeType = Provider.of<AppStateProvider>(context, listen: false).mode;
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      if (args != null) {
        final districtid = args['districtid'] as int?;
        final stateId = args['stateId'] as int?;
        final dwsmProvider = Provider.of<Dwsmprovider>(context, listen: false);
        dwsmProvider.clearfetchQualityAssuranceData();
        if (districtid != null) {
          dwsmProvider.setDistrictId(districtid);
        }
        if (stateId != null) {
          dwsmProvider.setStateId(stateId);
        }


        dwsmProvider.fetchQualityAssuranceData(
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
                "Quality Assurance and Commissioning",
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
                final modeType = Provider.of<AppStateProvider>(context, listen: false).mode;
                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 20, left: 6, right: 6, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [




                     modeType == ProjectMode.below10?Belowdwsmcommon(no: 4): Dwsmcommonclass(no: 5),

                        Card(
                          elevation: 5,
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.green, width: 1.4),
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
                                  // Authorized inspectors

                                  Column(
                                    children: [
                                      CustomMultiSelectChipQuestion(
                                        question: '1. Who all are authorized to inspect and measure works during field inspection?',
                                        options: dwsmProvider.authorizedInspectorsMap.keys.toList(),
                                        selectedValues: dwsmProvider.authorizedInspectors,
                                        onSelectionChanged: (val) {
                                          dwsmProvider.authorizedInspectors = val;
                                        },
                                      ),

                                      const SizedBox(height: 10),
                                      Customradiobttn(
                                        question:
                                            "2. Is the commissioning protocol being followed?",
                                        options:
                                            dwsmProvider.yesNoMap.keys.toList(),
                                        selectedOption: dwsmProvider
                                            .commissioningProtocolFollowed,
                                        onChanged: (val) => dwsmProvider
                                                .commissioningProtocolFollowed =
                                            val,
                                      ),

                                      Visibility(
                                        visible: modeType == ProjectMode.below10,
                                        child: Customradiobttn(
                                          question:
                                              "3.Has the district has hired any third-party inspection agencies on quality checks for JJM schemes?",
                                          options:
                                              dwsmProvider.yesNoMap.keys.toList(),
                                          selectedOption: dwsmProvider
                                              .thirdPartyInspectionAgency,
                                          onChanged: (val) => dwsmProvider
                                                  .thirdPartyInspectionAgency =
                                              val,
                                        ),
                                      ),
                                      Visibility(
                                        visible: modeType == ProjectMode.above10,
                                        child: Column(
                                          children: [
                                            CustomMultiSelectChipQuestion(
                                              question: '3. During commissioning of schemes, who are generally present?',
                                              options: dwsmProvider
                                                  .commissioningPresenceMap.keys
                                                  .toList(),
                                              selectedValues: dwsmProvider.commissioningPresence,
                                              onSelectionChanged: (val) {
                                                dwsmProvider.commissioningPresence = val;
                                              },
                                            ),
                                            const SizedBox(height: 10),
                                            Customradiobttn(
                                              question:
                                              "4.	Has the district undertaken any assessment of third-party inspection agencies on quality checks for JJM schemes?",
                                              options: dwsmProvider
                                                  .thirdPartyAssessmentMap.keys
                                                  .toList(),
                                              selectedOption:
                                              dwsmProvider.thirdPartyAssessment,
                                              onChanged: (val) => dwsmProvider
                                                  .thirdPartyAssessment = val,
                                            ),
                                          ],
                                        ),
                                      ),

                                      Customtxtfeild(
                                        label: "5. Observation for Quality Assurance and Commissioning.",
                                        controller: dwsmProvider
                                            .obserVationQualityAssurance,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: SizedBox(
                                          height: 35,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    10), // Adjust the radius as needed
                                              ),
                                            ),
                                            onPressed: () async {

                                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => PartFPublicCompliant()),
                                              );
                                            },
                                            child: Text(
                                              "SKIP",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 35,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
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
                                                "Saving Quality Assurance and Commissioning");

                                            await dwsmProvider.saveQualityAssurance(
                                              userId: localStorageService.getInt(AppConstants.prefUserId)!,
                                                stateId: dwsmProvider.stateId!,
                                              districtId: dwsmProvider.districtId!,
                                                inspectionAuthority: dwsmProvider.selectedAuthorizedInspectorID,
                                              isCommissioningProtocolFollowed: dwsmProvider.commissioningProtocolFollowedID,
                                                schemesPresentDuringCommissioning:[4,2],
                                              districtAssessmentAgencies: dwsmProvider.thirdPartyAssessmentID,
                                                districtHiredAgencies: dwsmProvider.thirdPartyInspectionAgencyID,
                                              modeType: modeType.modeValue,
                                                observationQualityAssurance: dwsmProvider.obserVationQualityAssurance.text
                                            );

                                            if (dwsmProvider.status!) {
                                              ToastHelper.showToastMessage(
                                                  dwsmProvider.message!,
                                                  backgroundColor: Colors.green);

                                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => PartFPublicCompliant()),
                                              );

                                            } else {
                                              ToastHelper.showToastMessage(
                                                  dwsmProvider.message!,
                                                  backgroundColor: Colors.red);
                                            }
                                          },
                                          child: Text(
                                            "SAVE",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )



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
