import 'dart:developer';

import 'package:cno_inspection/provider/schemeInfoProvider/SchemeProvider.dart';
import 'package:cno_inspection/services/LocalStorageService.dart';
import 'package:cno_inspection/utils/AppConstants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/AppStateProvider.dart';
import '../../utils/AppStyles.dart';
import '../../utils/LoaderUtils.dart';
import '../../utils/UserFeedback.dart';
import '../../utils/Utilityclass.dart';
import '../../utils/customradiobttn.dart';
import '../../utils/customtxtfeild.dart';
import '../../utils/toast_helper.dart';
import 'Dashboardschemeinfo.dart';
import 'PartBSchemePlanningScreen.dart';
import 'SchemeInfoCommonScreen.dart';

class SourceScreenQuestions extends StatefulWidget {
  const SourceScreenQuestions({Key? key}) : super(key: key);

  @override
  _SourceScreenQuestions createState() => _SourceScreenQuestions();
}

class _SourceScreenQuestions extends State<SourceScreenQuestions> {
  LocalStorageService _localStorageService = LocalStorageService();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
   final   modeType = Provider.of<AppStateProvider>(context, listen: false).mode;

      if (args != null) {
        final schemeId = args['schemeId'] as int?;
        final stateId = args['stateId'] as int?;

        final schemeProvider = Provider.of<Schemeprovider>(context, listen: false);
        schemeProvider.clearfetchSourceSurvey();

        if (schemeId != null) {schemeProvider.setSchemeId(schemeId);}
        if (stateId != null) {schemeProvider.setStateId(stateId);}
        schemeProvider.fetchSourceSurvey(stateId.toString(), schemeId.toString(), _localStorageService.getInt(AppConstants.prefUserId).toString(),modeType.modeValue);
      print('-----------${modeType!.modeValue}');
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
                "Source",
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
                final modeType = Provider.of<AppStateProvider>(context, listen: false).mode;
                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 20, left: 6, right: 6, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Schemeinfocommonscreen(
                          no: 1,
                        ),
                        Card(
                          elevation: 5,
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.blue, width: 1.4),
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
                                  // 1. Source finding committee recommended shift to surface water? (Yes/No)
                                  Customradiobttn(
                                    question:
                                        '1. If the source is surface water, then, did the Source finding committee recommend the shift to surface water?',
                                    options:
                                        schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                        schemeProvider.selectedValueQ1,
                                    onChanged: (val) {
                                      schemeProvider.selectedValueQ1 = val;
                                    },
                                  ),

                                  Customradiobttn(
                                    question:
                                        '2. Any study done to assess ground water before going for surface water?',
                                    options:
                                        schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                        schemeProvider.selectedValueQ2,
                                    onChanged: (val) {
                                      schemeProvider.selectedValueQ2 = val;
                                    },
                                  ),

                                  // 3. Number of villages falling under critical zones
                                  const Text(
                                    '3. Number of villages falling under the critical zones as mentioned (https://cgwb.gov.in/en/ground-water-resource-assessment-0):',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 8),

                                  Customtxtfeild(
                                    label: '3.1 Safe (Nos)',
                                    controller: schemeProvider.safeController,
                                    keyboardType: TextInputType.number,
                                  ),
                                  const SizedBox(height: 8),

                                  Customtxtfeild(
                                    label:
                                        '3.2 Critical / Over exploited (Nos)',
                                    controller:
                                        schemeProvider.criticalController,
                                    keyboardType: TextInputType.number,
                                  ),
                                  const SizedBox(height: 8),

                                  Customtxtfeild(
                                    label: '3.3 Semi-critical (Nos)',
                                    controller:
                                        schemeProvider.semiCriticalController,
                                    keyboardType: TextInputType.number,
                                  ),
                                  const SizedBox(height: 12),

                                  // 4. Groundwater contamination analysis? (Yes/No)
                                  Customradiobttn(
                                    question:
                                        '4. In case of groundwater contamination, was any analysis conducted to determine the most techno-economical option — treating the contaminated groundwater or switching to a surface water source?',
                                    options:
                                        schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption: schemeProvider.selectedValueQ3,
                                    onChanged: (val) {
                                      schemeProvider.selectedValueQ3 = val;
                                      print(
                                          'val----- ${schemeProvider.selectedValueQ3Id}');
                                    },
                                  ),

                                  // 5. Water allocation from State WRD / Irrigation Department (text input)
                                  Customradiobttn(
                                    question: '5. Water allocation from the State Water Resource Department (WRD)/ Irrigation Department (ID) from surface source for drinking purpose',
                                    options: schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption: schemeProvider.waterAllocationPurpose,
                                    onChanged: (val){
                                      schemeProvider.selectedWaterAllocation = val;
                                    },
                                  ),

                                  // Below 10% part Start

                                  Visibility(
                                    visible: modeType == ProjectMode.below10,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Customtxtfeild(
                                          label:
                                              '6.	Whether all representatives of source finding committee such as State WRD/ID, State level offices of CGWB etc. were consulted for making the recommendation or it was a PHED level exercise through Dept. Level hydrogeologist only? Provide details',
                                          controller: schemeProvider.sourceFindingRepresentativesConsulted_Controller,
                                          keyboardType: TextInputType.text,
                                        ),
                                        const SizedBox(height: 8),
                                        Customtxtfeild(
                                          label:
                                              '7.	What were the other cost-effective alternative sources available to provide the piped water supply in the area? Provide details',
                                          controller: schemeProvider.alternativeSourcesAvailable_Controller,
                                          keyboardType: TextInputType.text,
                                        ),
                                        const SizedBox(height: 8),
                                      ],
                                    ),
                                  ),

                                  // pass this additional value when api available
                                  /*
                                 schemeProvider.sourceFindingRepresentativesConsulted_Controller.text
                                  schemeProvider.alternativeSourcesAvailable_Controller.text*/

                                  // Below 10% part End

                                  const SizedBox(height: 15),

                                  CustomObservationField(
                                    labelText: '* Obseration on "Source" :',
                                    controller:  schemeProvider.PartAUserObservation,
                                  ),
                                  const SizedBox(height: 15),



                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      SizedBox(
                                        height: 35,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xffb0D6EFD),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  10), // Adjust the radius as needed
                                            ),
                                          ),
                                          onPressed: () async {
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      SchemePlanningScreen()),
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
                                      SizedBox(
                                        height: 35,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xffb0D6EFD),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  10), // Adjust the radius as needed
                                            ),
                                          ),
                                          onPressed: () async {

                                            LoaderUtils.showLoadingWithMessage(
                                                context,
                                                isLoading:
                                                schemeProvider.isLoading,
                                                message: "Saving Source...");
                                            print('---------------${int.tryParse(schemeProvider.safeController.text)} ');

                                            await schemeProvider.saveSourceSurvey(
                                              userId: _localStorageService.getInt(AppConstants.prefUserId) ?? 0,
                                              stateId: schemeProvider.stateId ?? 0,
                                              schemeId: schemeProvider.schemeId ?? 0,
                                            isRecommendShiftToSurface: schemeProvider.selectedValueQ1Id,
                                            studyAccessGroundBeforeSurface: schemeProvider.selectedValueQ2Id,
                                            safeZoneVillages:Utilityclass.stringToZero(schemeProvider.safeController.text),
                                            criticalZoneVillages:     Utilityclass.stringToZero(schemeProvider.criticalController.text    ),
                                            semiCriticalZoneVillages: Utilityclass.stringToZero(schemeProvider.semiCriticalController.text),
                                            groundWaterAnalysisConducted: schemeProvider.selectedValueQ3Id,
                                            waterAllocationFromWRD: schemeProvider.selectedWaterAllocationId,
                                            alterNativeSource: schemeProvider.alternativeSourcesAvailable_Controller.text.isNotEmpty ? schemeProvider.alternativeSourcesAvailable_Controller.text : "",
                                            repressFindinCommitte: schemeProvider.sourceFindingRepresentativesConsulted_Controller.text.isNotEmpty ? schemeProvider.sourceFindingRepresentativesConsulted_Controller.text : "",
                                              modeType: modeType?.modeValue ?? 0,
                                            userremark: schemeProvider.PartAUserObservation.text.isNotEmpty ? schemeProvider.PartAUserObservation.text : "",
                                            );


                                            if (schemeProvider.status!) {
                                              ToastHelper.showToastMessage(
                                                  schemeProvider.message!,
                                                  backgroundColor: Colors.green);
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        SchemePlanningScreen()),
                                              );
                                            } else {
                                              ToastHelper.showToastMessage(
                                                  schemeProvider.message!,
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
