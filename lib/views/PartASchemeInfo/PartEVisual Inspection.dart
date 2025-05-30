import 'package:cno_inspection/provider/AppStateProvider.dart';
import 'package:cno_inspection/views/PartASchemeInfo/Dashboardschemeinfo.dart';
import 'package:cno_inspection/views/PartASchemeInfo/PartDSchemeImplementationScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/schemeInfoProvider/SchemeProvider.dart';
import '../../services/LocalStorageService.dart';
import '../../utils/AppConstants.dart';
import '../../utils/AppStyles.dart';
import '../../utils/LoaderUtils.dart';
import '../../utils/MultiSelectionlist.dart';
import '../../utils/UserFeedback.dart';
import '../../utils/customradiobttn.dart';
import '../../utils/customtxtfeild.dart';
import '../../utils/toast_helper.dart';
import 'SchemeInfoCommonScreen.dart';

class VisualInspectionScreen extends StatefulWidget {
  const VisualInspectionScreen({Key? key}) : super(key: key);

  @override
  _VisualInspectionScreen createState() => _VisualInspectionScreen();
}

class _VisualInspectionScreen extends State<VisualInspectionScreen> {
  LocalStorageService _localStorageService = LocalStorageService();
  ProjectMode? modeType;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
      ModalRoute
          .of(context)
          ?.settings
          .arguments as Map<String, dynamic>?;
      if (args != null) {
        final schemeId = args['schemeId'] as int?;
        final stateId = args['stateId'] as int?;

        final schemeProvider =
        Provider.of<Schemeprovider>(context, listen: false);
        schemeProvider.clearVisualInspectionAnswers();

        if (schemeId != null) {
          schemeProvider.setSchemeId(schemeId);
        }
        if (stateId != null) {
          schemeProvider.setStateId(stateId);
        }
        modeType = Provider
            .of<AppStateProvider>(context, listen: false)
            .mode;

        schemeProvider.fetchSchemeVisualInspectionData(
            stateId.toString(), schemeId.toString(),
            _localStorageService.getInt(AppConstants.prefUserId).toString(),
            modeType!.modeValue);
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
                "Visual Inspection",
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
                          no: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
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
                              padding: EdgeInsets.all(8),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Note: A walk-through to inspect various components of scheme to be carried out (Photographs to highlight deficiencies to be taken).",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  const Divider(height: 20),

                                  const Text(
                                      "1. Through visual inspection, are there signs of poor workmanship as mentioned:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  const Text(
                                      "1(a)	Inspection of WTP/OHSR/ESR/GSR/MBR/Pump house:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15)),
                                  SizedBox(
                                    height: 4,
                                  ),

                                  //
                                  Customradiobttn(
                                    question:
                                    "a.1 spalling (peeling off surface)",
                                    options:
                                    schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                    schemeProvider.getSelectedPartEa1,
                                    onChanged: (val) {
                                      schemeProvider.setQuesPartEa1 = val;
                                    },
                                  ),

                                  Customradiobttn(
                                    question: "a.2 cracks",
                                    options:
                                    schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                    schemeProvider.getSelectedPartEa2,
                                    onChanged: (val) {
                                      schemeProvider.setQuesPartEa2 = val;
                                    },
                                  ),
                                  Customradiobttn(
                                    question: "a.3 red/brown rust marks",
                                    options:
                                    schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                    schemeProvider.getSelectedPartEa3,
                                    onChanged: (val) {
                                      schemeProvider.setQuesPartEa3 = val;
                                    },
                                  ),
                                  Customradiobttn(
                                    question: "a.4 swollen concrete",
                                    options:
                                    schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                    schemeProvider.getSelectedPartEa4,
                                    onChanged: (val) {
                                      schemeProvider.setQuesPartEa4 = val;
                                    },
                                  ),
                                  Customradiobttn(
                                    question: "a.5 trapped jute/plastic bags",
                                    options:
                                    schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                    schemeProvider.getSelectedPartEa5,
                                    onChanged: (val) {
                                      schemeProvider.setQuesPartEa5 = val;
                                    },
                                  ),
                                  Customradiobttn(
                                    question:
                                    "a.6 protruding rusted reinforcement bars",
                                    options:
                                    schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                    schemeProvider.getSelectedPartEa6,
                                    onChanged: (val) {
                                      schemeProvider.setQuesPartEa6 = val;
                                    },
                                  ),

                                  Customradiobttn(
                                    question:
                                    "a.7 dampness of concrete surfaces",
                                    options:
                                    schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                    schemeProvider.getSelectedPartEa8,
                                    onChanged: (val) {
                                      schemeProvider.setQuesPartEa8 = val;
                                    },
                                  ),
                                  Customradiobttn(
                                    question: "a.8 visible white marks)",
                                    options:
                                    schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                    schemeProvider.getSelectedPartEa9,
                                    onChanged: (val) {
                                      schemeProvider.setQuesPartEa9 = val;
                                    },
                                  ),
                                  Customradiobttn(
                                    question: "a.9 visible stone aggregates)",
                                    options:
                                    schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                    schemeProvider.getSelectedPartEa10,
                                    onChanged: (val) {
                                      schemeProvider.setQuesPartEa10 = val;
                                    },
                                  ),
                                  Customradiobttn(
                                    question:
                                    "a.10 structures missing vertical alignment)",
                                    options:
                                    schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                    schemeProvider.getSelectedPartEa11,
                                    onChanged: (val) {
                                      schemeProvider.setQuesPartEa11 = val;
                                    },
                                  ),
                                  Customradiobttn(
                                    question:
                                    "a.11 visible sag in the slab/beam)",
                                    options:
                                    schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                    schemeProvider.getSelectedPartEa12,
                                    onChanged: (val) {
                                      schemeProvider.setQuesPartEa12 = val;
                                    },
                                  ),
                                  Customradiobttn(
                                    question:
                                    "a.12 high vibration observed in the pumps)",
                                    options:
                                    schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                    schemeProvider.getSelectedPartEa13,
                                    onChanged: (val) {
                                      schemeProvider.setQuesPartEa13 = val;
                                    },
                                  ),
                                  Customradiobttn(
                                    question: "a.13	leakages in reservoirs)",
                                    options:
                                    schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                    schemeProvider.getSelectedPartEa14,
                                    onChanged: (val) {
                                      schemeProvider.setQuesPartEa14 = val;
                                    },
                                  ),
                                  Customradiobttn(
                                    question:
                                    "a.14 high leakages from the pumps	)",
                                    options:
                                    schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                    schemeProvider.getSelectedPartEa15,
                                    onChanged: (val) {
                                      schemeProvider.setQuesPartEa15 = val;
                                    },
                                  ),

                                  const SizedBox(height: 10),
                                  const Text("1(b). Inspection of Pipelines:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15)),
                                  const SizedBox(height: 4),
                                  Customradiobttn(
                                    question:
                                    "b.1 leakages in transmission pipelines/valves",
                                    options:
                                    schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                    schemeProvider.getSelectedPartEb1,
                                    onChanged: (val) {
                                      schemeProvider.setQuesPartEb1 = val;
                                    },
                                  ),
                                  Customradiobttn(
                                    question:
                                    "b.2 leakages in distribution pipelines/valves",
                                    options:
                                    schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                    schemeProvider.getSelectedPartEb2,
                                    onChanged: (val) {
                                      schemeProvider.setQuesPartEb2 = val;
                                    },
                                  ),
                                  Customradiobttn(
                                    question:
                                    "b.3 wet patches/pool of water on the ground along the route of pipe	",
                                    options:
                                    schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                    schemeProvider.getSelectedPartEb3,
                                    onChanged: (val) {
                                      schemeProvider.setQuesPartEb3 = val;
                                    },
                                  ),

                                  // Repeat for 1(b)...

                                  Customradiobttn(
                                    question:
                                    "2. Whether quality verification is being done by the third party or the State department during manufacturing of pipe (random quality checks reports to be seen)?",
                                    options:
                                    schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                    schemeProvider.getSelectedPartE2,
                                    onChanged: (val) {
                                      schemeProvider.setQuesPartE2 = val;
                                    },
                                  ),

                                  Customradiobttn(
                                    question:
                                    "3. Are the pipes as mentioned in the DPR (material such as HDPE, DI, etc., diameter) being implemented on ground (random check to be done)?",
                                    options:
                                    schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                    schemeProvider.getSelectedPartE3,
                                    onChanged: (val) {
                                      schemeProvider.setQuesPartE3 = val;
                                    },
                                  ),

                                  Customradiobttn(
                                    question:
                                    "4. Are there any complaints regarding pipeline laying as per the approved design as per DPR?",
                                    options:
                                    schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                    schemeProvider.getSelectedPartE4,
                                    onChanged: (val) {
                                      schemeProvider.setQuesPartE4 = val;
                                    },
                                  ),

                                  Customradiobttn(
                                    question:
                                    "5. Is TPIA engaged for this scheme?",
                                    options:
                                    schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                    schemeProvider.getSelectedPartE5,
                                    onChanged: (val) {
                                      schemeProvider.setQuesPartE5 = val;
                                    },
                                  ),

                                  Customradiobttn(
                                    question:
                                    "6.	Are sample based quality checks being done from third party labs for pipes, civil works, and key components (if yes, random reports to be seen)",
                                    options:
                                    schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                    schemeProvider.getSelectedPartE6,
                                    onChanged: (val) {
                                      schemeProvider.setQuesPartE6 = val;
                                    },
                                  ),

                                  Customradiobttn(
                                    question:
                                    "7.	Is concurrent supervision in the scope of TPIA? ",
                                    options:
                                    schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                    schemeProvider.getSelectedPartE7,
                                    onChanged: (val) {
                                      schemeProvider.setQuesPartE7 = val;
                                    },
                                  ),

                                  Customradiobttn(
                                    question:
                                    "8.	Has TPIA conducted quality checks at different stages of construction? ",
                                    options:
                                    schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                    schemeProvider.getSelectedPartE8,
                                    onChanged: (val) {
                                      schemeProvider.setQuesPartE8 = val;
                                    },
                                  ),

                                  Customradiobttn(
                                    question:
                                    "9.	Are there records of observations/inspection reports issued by TPIA?",
                                    options:
                                    schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                    schemeProvider.getSelectedPartE9,
                                    onChanged: (val) {
                                      schemeProvider.setQuesPartE9 = val;
                                    },
                                  ),

                                  // Continue similarly for all remaining questions...

                                  CustomMultiSelectChipQuestion(
                                    question:
                                    '10. Are there any serious issues observed by TPIAs about construction of schemes: If, yes, type of issues:',
                                    options: schemeProvider.question10Map.keys
                                        .toList(),
                                    selectedValues:
                                    schemeProvider.getSelectedPartE10,
                                    onSelectionChanged: (val) {
                                      schemeProvider.selectedPartE10 = val;
                                      print(
                                          'SelecteddelayReasons: ${schemeProvider
                                              .getSelectedPartE10} : ${schemeProvider
                                              .selectedDelayReasonsID}');
                                    },
                                  ),

                                  if (schemeProvider.getSelectedPartE10.contains("Others"))
                                    Customtxtfeild(
                                      label: "In Case of Other please provide details:",
                                      controller: schemeProvider.PartEothersComplaintController,
                                      maxLines: 2,
                                    ),

                                  SizedBox(
                                    height: 10,
                                  ),
                                  Customradiobttn(
                                    question:
                                    "11. Action based on TPIA observations",
                                    options: schemeProvider.question11Map.keys
                                        .toList(),
                                    selectedOption:
                                    schemeProvider.getSelectedPartE11,
                                    onChanged: (val) {
                                      schemeProvider.selectedPartE11 = val;
                                    },
                                  ),

                                  Customradiobttn(
                                    question:
                                    "12. TPIA verifies Measurement Books?",
                                    options: schemeProvider.question12Map.keys
                                        .toList(),
                                    selectedOption:
                                    schemeProvider.getSelectedPartE12,
                                    onChanged: (val) {
                                      schemeProvider.selectedPartE12 = val;
                                    },
                                    orientation: Axis
                                        .vertical, // <--- Added to display vertically
                                  ),

                                  const Text(
                                    '13. Hydrotesting of pipelines done (reports to be seen)',
                                    style:
                                    TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 6),

                                  Customradiobttn(
                                    question: '13.1 Transmission line',
                                    options:
                                    schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                    schemeProvider.getSelectedPartE13a,
                                    onChanged: (val) {
                                      schemeProvider.selectedPartE13a = val;
                                    },
                                  ),
                                  Customradiobttn(
                                    question: '13.2 Distribution line',
                                    options:
                                    schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption: schemeProvider.quesPartE13b,
                                    onChanged: (val) {
                                      schemeProvider.quesPartE13b = val;
                                    },
                                  ),

                                  Customradiobttn(
                                    question:
                                    "14. Test reports provided (random samples to be seen)",
                                    options: schemeProvider.question14Map.keys
                                        .toList(),
                                    selectedOption: schemeProvider.quesPartE14,
                                    onChanged: (val) {
                                      schemeProvider.quesPartE14 = val;
                                    },
                                  ),

                                  Customradiobttn(
                                    question:
                                    "15. Whether departmental engineers do quality checks",
                                    options: schemeProvider.question15Map.keys
                                        .toList(),
                                    selectedOption: schemeProvider.quesPartE15,
                                    onChanged: (val) {
                                      schemeProvider.quesPartE15 = val;
                                    },
                                    orientation: Axis.vertical,
                                  ),

                                  Customradiobttn(
                                    question:
                                    "16. Whether departmental engineers (JE/AE/DE/EE etc.) are verifying measurements of construction works",
                                    options: schemeProvider.question16Map.keys
                                        .toList(),
                                    selectedOption: schemeProvider.quesPartE16,
                                    onChanged: (val) {
                                      schemeProvider.quesPartE16 = val;
                                    },
                                    orientation: Axis.vertical,
                                  ),

                                  Customradiobttn(
                                    question:
                                    "17. Scheme commissioned as per protocol?",
                                    options: schemeProvider.question17Map.keys
                                        .toList(),
                                    selectedOption: schemeProvider.quesPartE17,
                                    onChanged: (val) {
                                      schemeProvider.quesPartE17 = val;
                                    },
                                    orientation: Axis.vertical,
                                  ),

                                  Customradiobttn(
                                    question:
                                    "18. Document proof of commissioning available",
                                    options: schemeProvider.question18Map.keys
                                        .toList(),
                                    selectedOption: schemeProvider.quesPartE18,
                                    onChanged: (val) {
                                      schemeProvider.quesPartE18 = val;
                                    },
                                  ),


                                  CustomObservationField(
                                    labelText: '*  Obseration on "Visual Inspection" :',
                                    controller:  schemeProvider.PartEUserObservation,
                                  ),


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
                                          LoaderUtils.showLoadingWithMessage(
                                              context,
                                              isLoading: true,
                                              message:
                                              "Additional info for Retrofitting/Augmentation Schemes only");

                                          LoaderUtils.showLoadingWithMessage(
                                              context, isLoading: schemeProvider
                                              .isLoading,
                                              message: "Additional info for Retrofitting/Augmentation Schemes only");

                                          await schemeProvider.saveVisualInspection(
                                              userId: _localStorageService.getInt(AppConstants.prefUserId)!,
                                              stateId: schemeProvider.stateId!,
                                              schemeId: schemeProvider.schemeId!,
                                              costOverrun: 000,
                                              spalling: schemeProvider.selectedId_partEa1,
                                              cracks: schemeProvider.selectedId_partEa2,
                                              rustMarks: schemeProvider.selectedId_partEa3,
                                              swollenConcrete: schemeProvider.selectedId_partEa4,
                                              trappedJute: schemeProvider.selectedId_partEa5,
                                              rustedBars: schemeProvider
                                                  .selectedId_partEa6,
                                              //a7
                                              dampness: schemeProvider
                                                  .selectedId_partEa8,
                                              whiteMarks: schemeProvider
                                                  .selectedId_partEa9,
                                              stoneAggregates: schemeProvider
                                                  .selectedId_partEa10,
                                              verticalAlignment: schemeProvider
                                                  .selectedId_partEa11,
                                              sagSlabBeam: schemeProvider
                                                  .selectedId_partEa12,
                                              highVibrationPumps: schemeProvider
                                                  .selectedId_partEa13,
                                              reservoirLeakage: schemeProvider
                                                  .selectedId_partEa14,
                                              highLeakagePumps: schemeProvider
                                                  .selectedId_partEa15,

                                              pipelineLeakageTransmission: schemeProvider
                                                  .selectedId_partEb1,
                                              pipelineLeakageDistribution: schemeProvider
                                                  .selectedId_partEb2,
                                              wetPatches: schemeProvider
                                                  .selectedId_partEb3,

                                              verifyPipeQuality: schemeProvider
                                                  .selectedId_partE2,
                                              pipesAsPerDPR: schemeProvider
                                                  .selectedId_partE3,
                                              complaintsOnPipelineDesign: schemeProvider
                                                  .selectedId_partE4,
                                              isTPIAEngaged: schemeProvider
                                                  .selectedId_partE5,
                                              sampleChecks: schemeProvider
                                                  .selectedId_partE6,
                                              concurrentSupervision: schemeProvider
                                                  .selectedId_partE7,
                                              tpiaStageChecks: schemeProvider
                                                  .selectedId_partE8,
                                              tpiaReports: schemeProvider
                                                  .selectedId_partE9,
                                              actionOnTPIA: schemeProvider
                                                  .selectedId_partE11,
                                              tpiaVerifyMB: schemeProvider
                                                  .selectedId_partE12,
                                              hydroTestingDone: schemeProvider
                                                  .selectedId_partE13a,
                                              // 13b distrabution line
                                              testReportsProvided: schemeProvider
                                                  .selectedId_partE14,
                                              deptQualityChecks: schemeProvider
                                                  .selectedId_partE15,
                                              deptMeasurementVerification: schemeProvider
                                                  .selectedId_partE16,
                                              schemeCommissioned: schemeProvider
                                                  .selectedId_partE17,
                                              commissioningProofAvailable: schemeProvider
                                                  .selectedId_partE18,
                                              tpiaIssueTypes: schemeProvider
                                                  .selectedId_partE10,
                                              modeType: modeType!.modeValue,
                                              hydroTestingDistribute:-1,
                                            visualInspectionRemarks: schemeProvider.PartEUserObservation.text,
                                            typeofissuestpiasOther: schemeProvider.PartEothersComplaintController.text
                                          ); // TODO check that parameter hydroTestingDistribute

                                          if (schemeProvider.status!) {
                                            ToastHelper.showToastMessage(
                                                schemeProvider.message!,
                                                backgroundColor: Colors.green);
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      SchemeImplementationScreen()),
                                            );
                                          } else {
                                            ToastHelper.showToastMessage(
                                                schemeProvider.message!,
                                                backgroundColor: Colors.red);
                                          }

                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    Dashboardschemeinfo()),
                                          );
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
                                  ),
                                ],
                              ),
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
