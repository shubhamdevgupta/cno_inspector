import 'package:cno_inspection/utils/customradiobttn.dart';
import 'package:cno_inspection/views/InteractionVWSC/CommunityFeedbackPartC.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/vwscInfoProvider/VwscProvider.dart';
import '../../utils/AppStyles.dart';
import '../../utils/CommonScreen.dart';
import '../../utils/CustomCheckBoxQuestion.dart';
import '../../utils/CustomRadioQuestion.dart';
import '../../utils/MultiSelectionlist.dart';
import '../../utils/toast_helper.dart';
import 'DashboardVWSC.dart';
import 'VWSCCommonClass.dart';

class CommunityInvolvementPartB extends StatefulWidget {


  @override
  State<CommunityInvolvementPartB> createState() => _CommunityInvolvementPartBState();
}

class _CommunityInvolvementPartBState extends State<CommunityInvolvementPartB> {

  String? selectedVWSCBankAccount; // Yes / No
  String? selectedVWSCInvolvement; // Active / Limited / No Involvement / VWSC not formed
  String? selectedAsBuiltDrawing; // Yes / No
  String? selectedVWSCMeetingConducted; // Yes / No
  String? selectedVWSCMeetingFrequency; // e.g., Weekly / Monthly / Quarterly
  String? selectedVWSCRecordsAvailable; // Yes / No
  String? selectedVWSCOMInvolved; // Yes – Active / Yes – Limited / No / Not Applicable
  String? selectedSchemeHandover; // Yes / No / Not Applicable
  List<String> selectedOMArrangements = []; // VWSC / PHED / Outsourced Contractor / No arrangement
  String? selectedCommunityAwareness; // Well informed / Some awareness / No awareness
  String? selectedWaterQualitySatisfaction; // Satisfied / Partially Satisfied / Dissatisfied / Not Interacted

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Replace the current route with a new one
        /*   Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => VillageList()),
        );*/

        // Return false to prevent the default back navigation behavior
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
          body: Consumer<Vwscprovider>(
            builder: (context, vwscProvider, child) {
              return  Stack(
                children: [

                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Vwsccommonclass(
                          no: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            elevation: 5,
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.orangeAccent, width: 1.4),
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
                                    SizedBox(height: 10,),
                                    Customradiobttn(
                                      question: "1. Is VWSC or Pani samiti formed:",
                                      options: ["Yes", "No"],
                                      selectedOption: vwscProvider.selectedVWSCFormed,

                                      onChanged: (val) {
                                        vwscProvider.selectedVWSCFormed = val;
                                        print('selectedVWSCFormed------- ${vwscProvider.selectedVWSCFormed}');

                                      },

                                    ),
                                    Customradiobttn(
                                      question: "2. Is VWSC bank account opened:",
                                      options: ["Yes", "No"],
                                      selectedOption: selectedVWSCBankAccount,
                                      onChanged: (val) {
                                        vwscProvider.selectedVWSCBankAccount = val;
                                        print('selectedVWSCBankAccountID------- ${vwscProvider.selectedVWSCBankAccountID}');

                                      },
                                      ),

                                    Customradiobttn(
                                      question: "3. VWSC/GP involvement in scheme operations:",
                                      options: ["Active", "Limited", "No Involvement", "VWSC not formed"],
                                      selectedOption: vwscProvider.selectedVWSCInvolvement,
                                      onChanged: (val) {
                                        vwscProvider.selectedVWSCInvolvement = val;
                                        print('selectedVWSCInvolvementID------- ${vwscProvider.selectedVWSCInvolvementID}');

                                      },
                                    ),
                                    Customradiobttn(
                                      question: "4. As-built Drawing of Pipelines available with GP office:",
                                      options: ["Yes", "No"],
                                      selectedOption: vwscProvider.selectedAsBuiltDrawing,
                                      onChanged: (val) {
                                        vwscProvider.selectedAsBuiltDrawing = val;
                                        print('selectedAsBuiltDrawingID------- ${vwscProvider.selectedAsBuiltDrawingID}');

                                      },
                                    ),
                                    Customradiobttn(
                                      question: "5. Whether meetings of VWSC are conducted in a periodic manner?",
                                      options: ["Yes", "No"],
                                      selectedOption: vwscProvider.selectedVWSCMeetingConducted,
                                      onChanged: (val) {
                                        vwscProvider.selectedVWSCMeetingConducted = val;
                                        print('selectedVWSCMeetingConductedID------- ${vwscProvider.selectedVWSCMeetingConductedID}');

                                      },
                                    ),
                                    if (selectedVWSCMeetingConducted == "Yes")
                                      Customradiobttn(
                                        question: "If meeting held yes, Frequency:",
                                        options: ["Weekly", "Monthly", "Quarterly", "Other"],
                                        selectedOption: vwscProvider.selectedVWSCMeetingFrequency,
                                        onChanged: (val) {
                                          vwscProvider.selectedVWSCMeetingFrequency = val;
                                          print('selectedVWSCMeetingFrequencyID------- ${vwscProvider.selectedVWSCMeetingFrequencyID}');

                                        },
                                      ),
                                    Customradiobttn(
                                      question: "6. Whether records of VWSC meetings are available?",
                                      options: ["Yes", "No"],
                                      selectedOption:  vwscProvider.selectedVWSCRecordsAvailable,
                                      onChanged: (val) {
                                        vwscProvider.selectedVWSCRecordsAvailable = val;
                                        print('selectedVWSCRecordsAvailableID------- ${vwscProvider.selectedVWSCRecordsAvailableID}');

                                      },
                                    ),
                                    Customradiobttn(
                                      question: "7. VWSC/GP involved in O&M:",
                                      options: ["Yes – Active", "Yes – Limited", "No", "Not Applicable"],
                                      selectedOption: vwscProvider.selectedVWSCOMInvolved,
                                      onChanged: (val) {
                                        vwscProvider.selectedVWSCOMInvolved = val;
                                        print('selectedVWSCRecordsAvailableID------- ${vwscProvider.selectedVWSCOMInvolvedID}');

                                      },
                                    ),
                                    Customradiobttn(
                                      question: "8. Scheme formally handed over to GP/VWSC:",
                                      options: ["Yes", "No", "Not Applicable"],
                                      selectedOption: vwscProvider.selectedSchemeHandover,
                                      onChanged: (val) {
                                        vwscProvider.selectedSchemeHandover = val;
                                        print('selectedSchemeHandoverID------- ${vwscProvider.selectedSchemeHandoverID}');

                                      },
                                    ),


                                    Customradiobttn(
                                      question: "9. Operation & Maintenance arrangements:",
                                      options: ["VWSC", "PHED", "Outsourced Contractor", "No arrangement"],
                                      selectedOption: vwscProvider.selectedOMArrangements,
                                      onChanged: (val) {
                                        vwscProvider.selectedOMArrangements = val;
                                        print('selectedOMArrangementsID------- ${vwscProvider.selectedOMArrangementsID}');

                                      },
                                    ),
                                    Customradiobttn(
                                      question: "10. Community awareness about scheme features:",
                                      options: ["Well informed", "Some awareness", "No awareness"],
                                      selectedOption: vwscProvider.selectedCommunityAwareness,
                                      onChanged: (val) {
                                        vwscProvider.selectedCommunityAwareness = val;
                                        print('selectedCommunityAwarenessID------- ${vwscProvider.selectedCommunityAwarenessID}');

                                      },
                                    ),
                                    Customradiobttn(
                                      question: "11. Community satisfaction with water quality:",
                                      options: ["Satisfied", "Partially Satisfied", "Dissatisfied", "Not Interacted"],
                                      selectedOption: vwscProvider.selectedWaterQualitySatisfaction,
                                      onChanged: (val) {
                                        vwscProvider.selectedWaterQualitySatisfaction = val;
                                        print('selectedWaterQualitySatisfactionID------- ${vwscProvider.selectedWaterQualitySatisfactionID}');

                                      },
                                    ),

                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: SizedBox(
                                        height: 35,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.orangeAccent,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                                            ),
                                          ),
                                          onPressed: () async {

                                            await vwscProvider.saveVwscCommunityInvolvement(userId: 34483,
                                              stateId: 32, villageId: 503655,
                                              isPaniSamitiFormed: vwscProvider.selectedVWSCFormedID,
                                              isVwscBankAccount: vwscProvider.selectedVWSCBankAccountID,
                                              vwscGpInvolvementScheme: vwscProvider.selectedVWSCInvolvementID,
                                              drawingPipelineAvlGpOffice: vwscProvider.selectedAsBuiltDrawingID,
                                              isVwscMeetingPeriodic: vwscProvider.selectedVWSCMeetingConductedID,
                                              meetingHeldFrequency: "Reuglar",
                                              isVwscMeetingRecordAvl: vwscProvider.selectedVWSCRecordsAvailableID,
                                              vwscInvolvementOM: vwscProvider.selectedVWSCOMInvolvedID,
                                              schemeHandedOverGp: vwscProvider.selectedSchemeHandoverID,
                                              omArrangement: vwscProvider.selectedOMArrangementsID,
                                              communityAwareness: vwscProvider.selectedCommunityAwarenessID,
                                              communitySatisfactionWithWq: vwscProvider.selectedWaterQualitySatisfactionID,
                                              createdBy: 34483
                                              );


                                            if(vwscProvider.status!){
                                              ToastHelper.showToastMessage( vwscProvider.message!,backgroundColor: Colors.green);
                                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => CommunityFeedbackPartC()),);

                                            }else{
                                              ToastHelper.showToastMessage( vwscProvider.message!,backgroundColor: Colors.red);
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
                                )
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            })
        ),
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
