import 'package:cno_inspection/provider/schemeInfoProvider/SchemeProvider.dart';
import 'package:cno_inspection/services/LocalStorageService.dart';
import 'package:cno_inspection/views/PartASchemeInfo/Dashboardschemeinfo.dart';
import 'package:cno_inspection/views/PartASchemeInfo/PartASourceScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/AppStateProvider.dart';
import '../../utils/AppConstants.dart';
import '../../utils/AppStyles.dart';
import '../../utils/CommonScreen.dart';
import '../../utils/CustomCheckBoxQuestion.dart';
import '../../utils/CustomTextField.dart';
import '../../utils/LoaderUtils.dart';
import '../../utils/UserFeedback.dart';
import '../../utils/customcheckquestion.dart';
import '../../utils/customradiobttn.dart';
import '../../utils/customtxtfeild.dart';
import '../../utils/toast_helper.dart';
import 'PartBSchemePlanningScreen.dart';
import 'PartDSchemeImplementationScreen.dart';
import 'SchemeInfoCommonScreen.dart';

class RetrofittingAugmentationScreen extends StatefulWidget {
  const RetrofittingAugmentationScreen({Key? key}) : super(key: key);

  @override
  _RetrofittingAugmentationScreen createState() =>
      _RetrofittingAugmentationScreen();
}

class _RetrofittingAugmentationScreen
    extends State<RetrofittingAugmentationScreen> {
  LocalStorageService _localStorageService = LocalStorageService();
  ProjectMode? modeType;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        final schemeId = args['schemeId'] as int?;
        final stateId = args['stateId'] as int?;

        final schemeProvider =
            Provider.of<Schemeprovider>(context, listen: false);

        schemeProvider.clearfetchAdditionalInfoRetrofit();
        if (schemeId != null) {
          schemeProvider.setSchemeId(schemeId);
        }
        if (stateId != null) {
          schemeProvider.setStateId(stateId);
        }
         modeType = Provider.of<AppStateProvider>(context, listen: false).mode;

        schemeProvider.fetchAdditionalInfoRetrofit(
            stateId.toString(),
            schemeId.toString(),
            _localStorageService.getInt(AppConstants.prefUserId).toString(),modeType!.modeValue);
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
                "Additional info for Retrofitting/Augmentation Schemes only",
                style: AppStyles.appBarTitleSmallText,
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
                                        '1. Whether the condition assessment of the legacy infrastructure done before scheme planning?',
                                    options:
                                        schemeProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                        schemeProvider.legacyInfraAssessment,
                                    onChanged: (val) => schemeProvider
                                        .legacyInfraAssessment = val,
                                  ),
                                  const SizedBox(height: 2),

                                // 2. Text Fields for Legacy Infrastructure Usage
                                const Text(
                                  '2. Legacy infrastructure which has been retrofitted and being used in the scheme under JJM:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 6),

                                Customtxtfeild(
                                  label:
                                      '2.1 Transmission Pipelines (in Kms)',
                                  controller: schemeProvider
                                      .transmissionPipelineKmController,
                                  keyboardType: TextInputType.number,
                                ),
                                const SizedBox(height: 8),

                                Customtxtfeild(
                                  label:
                                      '2.2 Distribution Pipelines (in Kms)',
                                  controller: schemeProvider
                                      .distributionPipelineKmController,
                                  keyboardType: TextInputType.number,
                                ),
                                const SizedBox(height: 8),

                                Customtxtfeild(
                                  label: '2.3 WTP Capacity (in MLD)',
                                  controller: schemeProvider
                                      .wtpCapacityMldController,
                                  keyboardType: TextInputType.number,
                                ),
                                const SizedBox(height: 8),

                                Text('2.4 Storage Structures (Nos./Capacity in KL',style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),),
                                  const SizedBox(height: 8),

                                Customtxtfeild(
                                  label:
                                      'In Nos.',
                                  controller: schemeProvider
                                      .storageStructureDetailsController,
                                  keyboardType: TextInputType.number,
                                ),
                                  Customtxtfeild(
                                  label:
                                      'Capacity (in KL)',
                                  controller: schemeProvider
                                      .storageStructureInKL,
                                  keyboardType: TextInputType.number,
                                ),
                                const SizedBox(height: 10),

                                  Visibility(
                                      visible: modeType==ProjectMode.above10,
                                      child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // 3. Radio Button: As-built Drawing Availability
                                      Customradiobttn(
                                        question:
                                        '3. Is the as-built drawing of the new infrastructure in conjunction with the existing infrastructure available with the department/agency/GP?',
                                        options:
                                        schemeProvider.yesNoMap.keys.toList(),
                                        selectedOption: schemeProvider
                                            .asBuiltDrawingAvailability,
                                        onChanged: (val) => schemeProvider
                                            .asBuiltDrawingAvailability = val,
                                      ),

                                      Customradiobttn(
                                        question:
                                        '4. Has it been digitized and uploaded on PM Gatishakti? ',
                                        options: schemeProvider.yesNoMap.keys
                                            .toList(),
                                        selectedOption:
                                        schemeProvider.onPmGatiShakti,
                                        onChanged: (val) =>
                                        schemeProvider.onPmGatiShakti = val,
                                      ),
                                    if (schemeProvider.onPmGatishaktiID == 0)
                                      Customtxtfeild(
                                        label: '4.1 Reason',
                                        controller:
                                        schemeProvider.reasonController,
                                        keyboardType: TextInputType.text,
                                      ),

                                  ],
                                )),




                                  SizedBox(
                                    height: 10,
                                  ),


                                  CustomObservationField(
                                    labelText: 'Obseration on "Additional information for Retrofitting/Augmentation Schemes only"',
                                    controller:  schemeProvider.PartCUserObservation,
                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: SizedBox(
                                      height: 35,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.deepOrangeAccent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10), // Adjust the radius as needed
                                          ),
                                        ),
                                        onPressed: () async {
                                          LoaderUtils.showLoadingWithMessage(
                                              context,
                                              isLoading: schemeProvider.isLoading,
                                              message:
                                                  "Additional info for Retrofitting/Augmentation Schemes only");
                                          await schemeProvider
                                              .saveRetrofitAdditionalInfo(
                                                  userId: _localStorageService.getInt(
                                                      AppConstants.prefUserId)!,
                                                  stateId:
                                                      schemeProvider.stateId!,
                                                  schemeId:
                                                      schemeProvider.schemeId!,
                                                  isAssessmentDone: schemeProvider
                                                      .selectedLegacyInfraAssessmentId,
                                                  assessmentMethod: '',
                                                  assessmentReason: '',
                                                  //not found
                                                  pipelineKms:double.tryParse(schemeProvider
                                                      .transmissionPipelineKmController
                                                      .text)!,
                                                  distributionKms: double.tryParse(
                                                      schemeProvider
                                                          .distributionPipelineKmController
                                                          .text)!,
                                                  wtpCapacity: double.tryParse(schemeProvider
                                                      .wtpCapacityMldController
                                                      .text)!,
                                                  structureNos: int.tryParse(schemeProvider
                                                      .storageStructureDetailsController
                                                      .text)!,
                                                  structureCapacity: double.tryParse(schemeProvider.storageStructureInKL.text)!,
                                                  // not found
                                                  buildDrawingAvailable: schemeProvider.asBuiltDrawingAvailabilityID,
                                                  onPMGati: schemeProvider.onPmGatishaktiID,
                                                  noReason: schemeProvider.reasonController.text.isEmpty ? "" : schemeProvider.reasonController.text,
                                        phyStatus: modeType!.modeValue,
                                            user_remark: schemeProvider.PartCUserObservation.text


                                          );
                                          if (schemeProvider.status!) {
                                            ToastHelper.showToastMessage(
                                                schemeProvider.message!,
                                                backgroundColor: Colors.green);
                                            Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      SchemeImplementationScreen()),
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
