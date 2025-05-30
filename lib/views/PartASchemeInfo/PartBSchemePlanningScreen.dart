import 'package:cno_inspection/provider/schemeInfoProvider/SchemeProvider.dart';
import 'package:cno_inspection/services/LocalStorageService.dart';
import 'package:cno_inspection/utils/AppConstants.dart';
import 'package:cno_inspection/provider/schemeInfoProvider/SchemeProvider.dart';
import 'package:cno_inspection/services/LocalStorageService.dart';
import 'package:cno_inspection/utils/AppConstants.dart';
import 'package:cno_inspection/views/PartASchemeInfo/Dashboardschemeinfo.dart';
import 'package:cno_inspection/views/PartASchemeInfo/PartASourceScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/AppStateProvider.dart';
import '../../utils/AppStyles.dart';
import '../../utils/LoaderUtils.dart';
import '../../utils/UserFeedback.dart';
import '../../utils/customradiobttn.dart';
import '../../utils/customtxtfeild.dart';
import '../../utils/toast_helper.dart';
import 'PartCRetrofittingAugmentationScreen.dart';
import 'SchemeInfoCommonScreen.dart';

class SchemePlanningScreen extends StatefulWidget {
  const SchemePlanningScreen({Key? key}) : super(key: key);

  @override
  _SchemePlanningScreen createState() => _SchemePlanningScreen();
}

class _SchemePlanningScreen extends State<SchemePlanningScreen> {
  LocalStorageService _localStorageService = LocalStorageService();
  ProjectMode? modeType;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
      ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      print("STATE 1111 : ${args.toString()}");

      if (args != null) {
        final schemeId = args['schemeId'] as int?;
        final stateId = args['stateId'] as int?;

        final schemeProvider =
        Provider.of<Schemeprovider>(context, listen: false);
        schemeProvider.clearfetchSchemePlanning();
        if (schemeId != null) {
          schemeProvider.setSchemeId(schemeId);
        }
        if (stateId != null) {
          schemeProvider.setStateId(stateId);
        }
        modeType = Provider.of<AppStateProvider>(context, listen: false).mode;

        schemeProvider.fetchSchemePlanning(stateId.toString(), schemeId.toString(), _localStorageService.getInt(AppConstants.prefUserId).toString(),modeType!.modeValue);
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Replace the current route with a new one
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => Dashboardschemeinfo()),
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
                "Scheme Planning",
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
                      MaterialPageRoute(
                          builder: (context) => Dashboardschemeinfo()),
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
            body: Consumer<Schemeprovider>(
              builder: (context, schemeProvider, child) {
                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 20, left: 6, right: 6, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Schemeinfocommonscreen(
                          no: 2,
                        ),
                        Card(
                          elevation: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.orangeAccent, width: 1.4),
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

      // Above 10% part Start
                                Visibility(
                                  visible: modeType==ProjectMode.above10,
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // 1. Survey questions
                                      const Text(
                                        '1. Has the surveys done for planning of the scheme:',
                                        style: TextStyle(fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(height: 6),
                                      Customradiobttn(
                                        question: '1.1 Topographical survey',
                                        options: schemeProvider.yesNoMap.keys.toList(),
                                        selectedOption: schemeProvider.topoSurvey,
                                        onChanged: (value) {
                                          schemeProvider.topoSurvey = value;
                                        },
                                      ),
                                      Customradiobttn(
                                        question: '1.2 GPS/physical survey done',
                                        options: schemeProvider.yesNoMap.keys.toList(),
                                        selectedOption: schemeProvider.gpsSurvey,
                                        onChanged: (value) {
                                          schemeProvider.gpsSurvey = value;
                                        },
                                      ),
                                      Customradiobttn(
                                        question: '1.3 Google Earth/Maps survey',
                                        options: schemeProvider.yesNoMap.keys.toList(),
                                        selectedOption:
                                        schemeProvider.googleEarthSurvey,
                                        onChanged: (value) {
                                          schemeProvider.googleEarthSurvey = value;
                                        },
                                      ),
                                      Customradiobttn(
                                        question: '1.4 No survey done',
                                        options: schemeProvider.yesNoMap.keys.toList(),
                                        selectedOption: schemeProvider.noSurvey,
                                        onChanged: (value) {
                                          schemeProvider.noSurvey = value;
                                        },
                                      ),
                                      const SizedBox(height: 10),

                                    // 2. WTP design hours
                                    Customtxtfeild(
                                      label:
                                      '2.	What are the running hours per day considered for designing of WTP/Transmission main?',
                                      controller: schemeProvider.wtpHoursController,
                                      keyboardType: TextInputType.number,
                                    ),
                                    const SizedBox(height: 10),

                                    // 3. Retention time
                                    const Text(
                                      '3.	What is the retention time in hours per day considered for design of ',
                                      style: TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 6),
                                    Customtxtfeild(
                                      label: '3.1 OHSR/OHT/ESR (in hrs)',
                                      controller: schemeProvider.ohsrTimeController,
                                      keyboardType: TextInputType.number,
                                    ),
                                    const SizedBox(height: 6),
                                    Customtxtfeild(
                                      label: '3.2 MBR (in hrs)',
                                      controller: schemeProvider.mbrTimeController,
                                      keyboardType: TextInputType.number,
                                    ),
                                    const SizedBox(height: 10),

                                    // 4. Pipe material selection
                                    const Text(
                                      '4.	Please specify the selection of pipe material for distribution network in the following terrain with reasons:',
                                      style: TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 6),
                                    Customtxtfeild(
                                      label: '4.1 Rocky Strata - Pipe Material Used',
                                      controller:
                                      schemeProvider.rockyPipeMaterialController,
                                      keyboardType: TextInputType.text,
                                    ),
                                    const SizedBox(height: 6),
                                    Customtxtfeild(
                                      label: '4.2 Soil Strata - Pipe Material Used',
                                      controller:
                                      schemeProvider.soilPipeMaterialController,
                                      keyboardType: TextInputType.text,
                                    ),
                                    const SizedBox(height: 10),

                                    // 5. On-spot excavation check (Radio)
                                    const Text(
                                      '5.	Do the on-spot excavation on any sample stretch of pipeline and check for pipe material and dia as per DPR:',
                                      style: TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 6),
                                    Customradiobttn(
                                      question: 'Found as per DPR',
                                      options: schemeProvider.yesNoMap.keys.toList(),
                                      selectedOption: schemeProvider.onSpotExcavation,
                                      onChanged: (val) {
                                        schemeProvider.onSpotExcavation = val;
                                      },
                                    ),

                                    if (schemeProvider.onSpotExcavation == "Yes")
                                      Customtxtfeild(
                                        label: 'If deviation found, provide reason',
                                        controller: schemeProvider.deviationReasonController,
                                        keyboardType: TextInputType.text,
                                      ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
// Above 10% part End



                                // Below 10% part Start
                                Visibility(
                                  visible: modeType==ProjectMode.below10,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Customtxtfeild(
                                      label: '1. What are the reasons if the scheme is approved but the work is not awarded till date?',
                                      controller: schemeProvider.schemePlanning_Question1Controller,
                                      keyboardType: TextInputType.text,
                                    ),

                                  Customtxtfeild(
                                    label: '2. If the work is awarded, please provide the reasons for no physical progress?',
                                    controller: schemeProvider.schemePlanning_Question2Controller,
                                    keyboardType: TextInputType.text,
                                  ),


                                  const Text(
                                    '3. Has the surveys done for planning of the scheme:',
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 6),
                                  Customradiobttn(
                                    question: '3.1 Topographical survey',
                                    options: schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption: schemeProvider.topoSurvey,
                                    onChanged: (value) {
                                      schemeProvider.topoSurvey = value;
                                    },
                                  ),
                                  Customradiobttn(
                                    question: '3.2 GPS/physical survey done',
                                    options: schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption: schemeProvider.gpsSurvey,
                                    onChanged: (value) {
                                      schemeProvider.gpsSurvey = value;
                                    },
                                  ),
                                  Customradiobttn(
                                    question: '3.3 Google Earth/Maps survey',
                                    options: schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                    schemeProvider.googleEarthSurvey,
                                    onChanged: (value) {
                                      schemeProvider.googleEarthSurvey = value;
                                    },
                                  ),
                                  Customradiobttn(
                                    question: '4.4 No survey done',
                                    options: schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption: schemeProvider.noSurvey,
                                    onChanged: (value) {
                                      schemeProvider.noSurvey = value;
                                    },
                                  ),
                                  const SizedBox(height: 10),

                                  // 4. Pipe material selection
                                  const Text(
                                    '4.	Please specify the selection of pipe material for distribution network in the following terrain with reasons:',
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 6),
                                  Customtxtfeild(
                                    label: '4.1 Rocky Strata',
                                    controller:
                                    schemeProvider.rockyPipeMaterialController,
                                    keyboardType: TextInputType.text,
                                  ),
                                  const SizedBox(height: 6),
                                  Customtxtfeild(
                                    label: '4.2 Soil Strata',
                                    controller:
                                    schemeProvider.soilPipeMaterialController,
                                    keyboardType: TextInputType.text,
                                  ),
                                  const SizedBox(height: 10),

                                  Customtxtfeild(
                                    label: '5. Please review the villages which are covered in the scheme and evaluate that villages covered under the scheme have multiple schemes being sanctioned? Kindly see if it is over planning or has any justifiable grounds. Link has been provided for reference...',
                                    controller: schemeProvider.schemePlanning_Question5Controller,
                                    keyboardType: TextInputType.text,
                                  ),

                                  Customtxtfeild(
                                    label: '6. If multiple schemes have been designed for conjunctive use for a short lean period and there is no evidence of dynamic fluctuation in water table, was there a possibility to retain the existing ground water/local source for the scheme?',
                                    controller: schemeProvider.schemePlanning_Question6Controller,
                                    keyboardType: TextInputType.text,
                                  ),

                                  const SizedBox(height: 10),
                                ],
                              )
                              ),

                              // Below 10% part End


                                CustomObservationField(
                                  labelText: '* Obseration on "Scheme Planning":',
                                  controller:  schemeProvider.PartBUserObservation,
                                ),

                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    height: 35,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.orangeAccent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10), // Adjust the radius as needed
                                        ),
                                      ),
                                      onPressed: () async {
                                        LoaderUtils.showLoadingWithMessage(context, isLoading: schemeProvider.isLoading,message: "Saving Scheme Planning...");
print("STATE : ${schemeProvider.stateId}");
                                        await schemeProvider.saveSchemePlanning(
                                            userId: _localStorageService
                                                .getInt(AppConstants.prefUserId)!,
                                            stateId: schemeProvider.stateId!,
                                            schemeId: schemeProvider.schemeId!,
                                            topoSurvey:
                                                schemeProvider.topoSurveyID,
                                            gpsSurvey: schemeProvider.gpsSurveyID,
                                            googleSurvey: schemeProvider
                                                .googleEarthSurveyID,
                                            numberOfSurveys:
                                                schemeProvider.noSurveyID,
                                            designRunningHours: int.tryParse(schemeProvider
                                                .wtpHoursController.text)!,
                                            retentionTimeOHT: int.tryParse(schemeProvider
                                                .ohsrTimeController.text)!,
                                            retentionTimeMBR: int.tryParse(schemeProvider
                                                .mbrTimeController.text)!,
                                            terrainRocky: schemeProvider
                                                .rockyPipeMaterialController.text,
                                            terrainSoil: schemeProvider
                                                .soilPipeMaterialController.text,
                                            foundAsPerDPR:
                                                schemeProvider.onSpotExcavationID,
                                            deviation: schemeProvider.deviationReasonController.text,
                                         user_remark: schemeProvider.PartBUserObservation.text,


                                         reason_not_awarded_scheme_planning:schemeProvider.schemePlanning_Question1Controller.text ,
                                         work_awarded_no_physical_progress:schemeProvider. schemePlanning_Question2Controller.text ,
                                         multiple_schemes_sanctioned_justify_detial: schemeProvider.schemePlanning_Question5Controller.text,
                                         desgined_conjunctive_detail: schemeProvider.schemePlanning_Question6Controller.text,
                                         phy_status: modeType!.modeValue ,);
                                        if (schemeProvider.status!) {
                                          ToastHelper.showToastMessage(
                                              schemeProvider.message!,
                                              backgroundColor: Colors.green);
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    RetrofittingAugmentationScreen()),
                                          );
                                        } else {
                                          ToastHelper.showToastMessage(
                                              schemeProvider.message!,
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
