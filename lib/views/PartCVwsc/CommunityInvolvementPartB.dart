import 'package:cno_inspection/provider/vwscInfoProvider/VwscProvider.dart';
import 'package:cno_inspection/utils/customradiobttn.dart';
import 'package:cno_inspection/utils/customtxtfeild.dart';
import 'package:cno_inspection/views/PartCVwsc/BelowVWSCCommon.dart';
import 'package:cno_inspection/views/PartCVwsc/CommunityFeedbackPartC.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/AppStateProvider.dart';
import '../../provider/vwscInfoProvider/VwscProvider.dart';
import '../../services/LocalStorageService.dart';
import '../../utils/AppConstants.dart';
import '../../utils/AppStyles.dart';
import '../../utils/LoaderUtils.dart';
import '../../utils/MultiSelectionlist.dart';
import '../../utils/UserFeedback.dart';
import '../../utils/toast_helper.dart';
import 'DashboardVWSC.dart';
import 'AboveVWSCCommonClass.dart';

class CommunityInvolvementPartB extends StatefulWidget {
  @override
  State<CommunityInvolvementPartB> createState() =>
      _CommunityInvolvementPartBState();
}

class _CommunityInvolvementPartBState extends State<CommunityInvolvementPartB> {
  final LocalStorageService _localStorage = LocalStorageService();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      if (args != null) {
        final villageId = args['villageId'] as int?;
        final stateId = args['stateId'] as int?;

        // You can now use them, or set them in your provider

        final vwscProvider = Provider.of<Vwscprovider>(context, listen: false);
        vwscProvider.clearCommunityInvolvementData();
        if (villageId != null) {
          vwscProvider.setVillageId(villageId);
        }
        if (stateId != null) {
          vwscProvider.setStateId(stateId);
        }
        vwscProvider.fetchCommunityInvolvement(
            stateId.toString(),
            villageId.toString(),
            _localStorage.getInt(AppConstants.prefUserId).toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Replace the current route with a new one
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => Dashboardvwsc()),
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
                "Community Involvement & VWSC Functionality",
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
                      MaterialPageRoute(builder: (context) => Dashboardvwsc()),
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
            body: Consumer<Vwscprovider>(builder: (context, vwscProvider, child) {
              final mode = Provider.of<AppStateProvider>(context, listen: false).mode;



              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    mode == ProjectMode.below10? Belowvwsccommon(no: 2):  Abovevwsccommonclass(no: 2,),


                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Card(
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
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [






                                Visibility(
                                  visible: mode == ProjectMode.above10,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Customradiobttn(
                                        question: "1. Is VWSC or Pani samiti formed:",
                                        options: vwscProvider.yesNoMap.keys.toList(),
                                        selectedOption: vwscProvider.selectedVWSCFormed,
                                        onChanged: (val) {
                                          vwscProvider.selectedVWSCFormed = val;
                                          print(
                                              'selectedVWSCFormed------- ${vwscProvider.selectedVWSCFormed} : ${vwscProvider.selectedVWSCFormedID}');
                                        },
                                      ),
                                      Customradiobttn(
                                        question: "2. Is VWSC bank account opened:",
                                        options: vwscProvider.yesNoMap.keys.toList(),
                                        selectedOption:
                                        vwscProvider.selectedVWSCBankAccount,
                                        onChanged: (val) {
                                          vwscProvider.selectedVWSCBankAccount = val;
                                          print(
                                              'selectedVWSCBankAccountID------- ${vwscProvider.selectedVWSCBankAccountID}');
                                        },
                                      ),
                                      Customradiobttn(
                                        question:
                                        "3. VWSC/GP involvement in scheme operations:",
                                        options: vwscProvider.VwscGPInvolmentOptions,
                                        selectedOption:
                                        vwscProvider.selectedVWSCInvolvement,
                                        onChanged: (val) {
                                          vwscProvider.selectedVWSCInvolvement = val;
                                          print(
                                              'selectedVWSCInvolvementID------- ${vwscProvider.selectedVWSCInvolvementID}');
                                        },
                                      ),


                                      //TODO this question is not part of below 10%
                                      Customradiobttn(
                                        question:
                                        "4. As-built Drawing of Pipelines available with GP office:",
                                        options: vwscProvider.yesNoMap.keys.toList(),
                                        selectedOption:
                                        vwscProvider.selectedAsBuiltDrawing,
                                        onChanged: (val) {
                                          vwscProvider.selectedAsBuiltDrawing = val;
                                          print(
                                              'selectedAsBuiltDrawingID------- ${vwscProvider.selectedAsBuiltDrawingID}');
                                        },
                                      ),
                                      Customradiobttn(
                                        question:
                                        "5. Whether meetings of VWSC are conducted in a periodic manner?",
                                        options: vwscProvider.yesNoMap.keys.toList(),
                                        selectedOption:
                                        vwscProvider.selectedVWSCMeetingConducted,
                                        onChanged: (val) {
                                          vwscProvider.selectedVWSCMeetingConducted =
                                              val;
                                          print(
                                              'selectedVWSCMeetingConductedID------- ${vwscProvider.selectedVWSCMeetingConductedID}');
                                        },
                                      ),
                                      if (vwscProvider.selectedVWSCMeetingConductedID ==
                                          1)
                                        Customtxtfeild(
                                          label: 'If meeting held yes, Frequency:',
                                          controller: vwscProvider.FrequencyController,
                                          keyboardType: TextInputType.text,
                                        ),
                                      Customradiobttn(
                                        question:
                                        "6. Whether records of VWSC meetings are available?",
                                        options: vwscProvider.yesNoMap.keys.toList(),
                                        selectedOption:
                                        vwscProvider.selectedVWSCRecordsAvailable,
                                        onChanged: (val) {
                                          vwscProvider.selectedVWSCRecordsAvailable =
                                              val;
                                          print(
                                              'selectedVWSCRecordsAvailableID------- ${vwscProvider.selectedVWSCRecordsAvailableID}');
                                        },
                                      ),
                                      Customradiobttn(
                                        question: "7. VWSC/GP involved in O&M:",
                                        options:
                                        vwscProvider.VWSCOMInvolvedID.keys.toList(),
                                        selectedOption:
                                        vwscProvider.selectedVWSCOMInvolved,
                                        onChanged: (val) {
                                          vwscProvider.selectedVWSCOMInvolved = val;
                                          print(
                                              'selectedVWSCRecordsAvailableID------- ${vwscProvider.selectedVWSCOMInvolvedID}');
                                        },
                                      ),


                                      //TODO this question is not part of below 10%
                                      Customradiobttn(
                                        question:
                                        "8. Scheme formally handed over to GP/VWSC:",
                                        options: vwscProvider.SchemeHandoverOptions,
                                        selectedOption:
                                        vwscProvider.selectedSchemeHandover,
                                        onChanged: (val) {
                                          vwscProvider.selectedSchemeHandover = val;
                                          print(
                                              'selectedSchemeHandoverID------- ${vwscProvider.selectedSchemeHandoverID}');
                                        },
                                      ),
                                      Customradiobttn(
                                        question:
                                        "9. Operation & Maintenance arrangements:",
                                        options: vwscProvider.OMArrangementsOptions,
                                        selectedOption:
                                        vwscProvider.selectedOMArrangements,
                                        onChanged: (val) {
                                          vwscProvider.selectedOMArrangements = val;
                                          print(
                                              'selectedOMArrangementsID------- ${vwscProvider.selectedOMArrangementsID}');
                                        },
                                      ),
                                      Customradiobttn(
                                        question:
                                        "10. Community awareness about scheme features:",
                                        options: vwscProvider.CommunityAwarenessOptions,
                                        selectedOption:
                                        vwscProvider.selectedCommunityAwareness,
                                        onChanged: (val) {
                                          vwscProvider.selectedCommunityAwareness = val;
                                          print(
                                              'selectedCommunityAwarenessID------- ${vwscProvider.selectedCommunityAwarenessID}');
                                        },
                                      ),
                                      Customradiobttn(
                                        question:
                                        "11. Community satisfaction with water quality:",
                                        options: vwscProvider
                                            .WaterQualitySatisfactionOptions,
                                        selectedOption: vwscProvider
                                            .selectedWaterQualitySatisfaction,
                                        onChanged: (val) {
                                          vwscProvider
                                              .selectedWaterQualitySatisfaction = val;
                                          print(
                                              'selectedWaterQualitySatisfactionID------- ${vwscProvider.selectedWaterQualitySatisfactionID}');
                                        },
                                      ),
                                    ],
                                  ),
                                ),

                                Visibility(
                                  visible: mode == ProjectMode.below10,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Customradiobttn(
                                        question: "1. Is VWSC or Pani samiti formed:",
                                        options: vwscProvider.yesNoMap.keys.toList(),
                                        selectedOption: vwscProvider.selectedVWSCFormed,
                                        onChanged: (val) {
                                          vwscProvider.selectedVWSCFormed = val;
                                          print(
                                              'selectedVWSCFormed------- ${vwscProvider.selectedVWSCFormed} : ${vwscProvider.selectedVWSCFormedID}');
                                        },
                                      ),
                                      Customradiobttn(
                                        question: "2. Is VWSC bank account opened:",
                                        options: vwscProvider.yesNoMap.keys.toList(),
                                        selectedOption:
                                        vwscProvider.selectedVWSCBankAccount,
                                        onChanged: (val) {
                                          vwscProvider.selectedVWSCBankAccount = val;
                                          print(
                                              'selectedVWSCBankAccountID------- ${vwscProvider.selectedVWSCBankAccountID}');
                                        },
                                      ),
                                      Customradiobttn(
                                        question:
                                        "3. VWSC/GP involvement in scheme operations:",
                                        options: vwscProvider.VwscGPInvolmentOptions,
                                        selectedOption:
                                        vwscProvider.selectedVWSCInvolvement,
                                        onChanged: (val) {
                                          vwscProvider.selectedVWSCInvolvement = val;
                                          print(
                                              'selectedVWSCInvolvementID------- ${vwscProvider.selectedVWSCInvolvementID}');
                                        },
                                      ),



                                      Customradiobttn(
                                        question:
                                        "4. Whether meetings of VWSC are conducted in a periodic manner?",
                                        options: vwscProvider.yesNoMap.keys.toList(),
                                        selectedOption:
                                        vwscProvider.selectedVWSCMeetingConducted,
                                        onChanged: (val) {
                                          vwscProvider.selectedVWSCMeetingConducted =
                                              val;
                                          print(
                                              'selectedVWSCMeetingConductedID------- ${vwscProvider.selectedVWSCMeetingConductedID}');
                                        },
                                      ),
                                      if (vwscProvider.selectedVWSCMeetingConductedID ==
                                          1)
                                        Customtxtfeild(
                                          label: 'If meeting held yes, Frequency:',
                                          controller: vwscProvider.FrequencyController,
                                          keyboardType: TextInputType.text,
                                        ),
                                      Customradiobttn(
                                        question:
                                        "5. Whether records of VWSC meetings are available?",
                                        options: vwscProvider.yesNoMap.keys.toList(),
                                        selectedOption:
                                        vwscProvider.selectedVWSCRecordsAvailable,
                                        onChanged: (val) {
                                          vwscProvider.selectedVWSCRecordsAvailable =
                                              val;
                                          print(
                                              'selectedVWSCRecordsAvailableID------- ${vwscProvider.selectedVWSCRecordsAvailableID}');
                                        },
                                      ),
                                      Customradiobttn(
                                        question: "6. VWSC/GP involved in O&M:",
                                        options:
                                        vwscProvider.VWSCOMInvolvedID.keys.toList(),
                                        selectedOption:
                                        vwscProvider.selectedVWSCOMInvolved,
                                        onChanged: (val) {
                                          vwscProvider.selectedVWSCOMInvolved = val;
                                          print(
                                              'selectedVWSCRecordsAvailableID------- ${vwscProvider.selectedVWSCOMInvolvedID}');
                                        },
                                      ),


                                      Customradiobttn(
                                        question:
                                        "7. Operation & Maintenance arrangements:",
                                        options: vwscProvider.OMArrangementsOptions,
                                        selectedOption:
                                        vwscProvider.selectedOMArrangements,
                                        onChanged: (val) {
                                          vwscProvider.selectedOMArrangements = val;
                                          print(
                                              'selectedOMArrangementsID------- ${vwscProvider.selectedOMArrangementsID}');
                                        },
                                      ),
                                      Customradiobttn(
                                        question:
                                        "8. Community awareness about scheme features:",
                                        options: vwscProvider.CommunityAwarenessOptions,
                                        selectedOption:
                                        vwscProvider.selectedCommunityAwareness,
                                        onChanged: (val) {
                                          vwscProvider.selectedCommunityAwareness = val;
                                          print(
                                              'selectedCommunityAwarenessID------- ${vwscProvider.selectedCommunityAwarenessID}');
                                        },
                                      ),
                                      Customradiobttn(
                                        question:
                                        "9. Community satisfaction with water quality:",
                                        options: vwscProvider
                                            .WaterQualitySatisfactionOptions,
                                        selectedOption: vwscProvider
                                            .selectedWaterQualitySatisfaction,
                                        onChanged: (val) {
                                          vwscProvider
                                              .selectedWaterQualitySatisfaction = val;
                                          print(
                                              'selectedWaterQualitySatisfactionID------- ${vwscProvider.selectedWaterQualitySatisfactionID}');
                                        },
                                      ),
                                    ],
                                  ),
                                ),

                           /*     CustomObservationField(
                                  labelText: '* User Observation / Remarks:',
                                  controller:  vwscProvider.PartBVWSCuserObservationController,
                                ),*/


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
                                        LoaderUtils.showLoadingWithMessage(
                                            context,
                                            isLoading: vwscProvider.isLoading,
                                            message:
                                                "Community Involvement & VWSC Functionality");
                                        //   vwscProvider.fetchCommunityInvolvement("45", "111140", "1121");
                                        await vwscProvider.saveVwscCommunityInvolvement(
                                            userId: _localStorage
                                                .getInt(AppConstants.prefUserId)!,
                                            stateId: vwscProvider.stateId!,
                                            villageId: vwscProvider.villageId!,
                                            isPaniSamitiFormed: vwscProvider.selectedVWSCFormedID,
                                            isVwscBankAccount: vwscProvider.selectedVWSCBankAccountID,
                                            vwscGpInvolvementScheme: vwscProvider.selectedVWSCInvolvementID,
                                            drawingPipelineAvlGpOffice: vwscProvider.selectedAsBuiltDrawingID,
                                            isVwscMeetingPeriodic: vwscProvider.selectedVWSCMeetingConductedID,
                                            meetingHeldFrequency: vwscProvider.FrequencyController.text,
                                            isVwscMeetingRecordAvl: vwscProvider.selectedVWSCRecordsAvailableID,
                                            vwscInvolvementOM: vwscProvider.selectedVWSCOMInvolvedID,
                                            schemeHandedOverGp: vwscProvider.selectedSchemeHandoverID,
                                            omArrangement: vwscProvider.selectedOMArrangementsID,
                                            communityAwareness: vwscProvider.selectedCommunityAwarenessID,
                                            communitySatisfactionWithWq: vwscProvider.selectedWaterQualitySatisfactionID,
                                            createdBy: _localStorage.getInt(AppConstants.prefUserId)!);

                                        if (vwscProvider.status!) {
                                          ToastHelper.showToastMessage(
                                              vwscProvider.message!,
                                              backgroundColor: Colors.green);
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    CommunityFeedbackPartC()),
                                          );
                                        } else {
                                          ToastHelper.showToastMessage(
                                              vwscProvider.message!,
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
                      ),
                    )
                  ],
                ),
              );
            })),
      ),
    );
  }

  Widget buildRadioGroup(
    String title,
    List<String> options,
    String? groupValue,
    void Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(title),
        ...options.map(
          (value) => RadioListTile<String>(
            title: Text(value),
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
        )
      ],
    );
  }
}
