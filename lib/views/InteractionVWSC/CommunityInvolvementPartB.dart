import 'package:cno_inspection/provider/vwscInfoProvider/VwscProvider.dart';
import 'package:cno_inspection/utils/customradiobttn.dart';
import 'package:cno_inspection/views/InteractionVWSC/CommunityFeedbackPartC.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/AppStyles.dart';
import '../../utils/CommonScreen.dart';
import '../../utils/CustomCheckBoxQuestion.dart';
import '../../utils/CustomRadioQuestion.dart';
import '../../utils/MultiSelectionlist.dart';
import 'DashboardVWSC.dart';

class CommunityInvolvementPartB extends StatefulWidget {


  @override
  State<CommunityInvolvementPartB> createState() => _CommunityInvolvementPartBState();
}

class _CommunityInvolvementPartBState extends State<CommunityInvolvementPartB> {
  String? selectedVWSCFormed; // Yes / No
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
              "Interaction with VWSC",
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
          body: Stack(
            children: [

              SingleChildScrollView(
                child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [

                     NewScreenPoints(
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
                               Padding(
                                 padding: EdgeInsets.symmetric(vertical: 8.0),
                                 child: Text(
                                   'B. Community Involvement & VWSC Functionality',
                                   style: TextStyle(
                                     fontWeight: FontWeight.bold,
                                     fontSize: 16,
                                     color: Colors.orangeAccent,
                                   ),
                                 ),
                               ),
                               SizedBox(height: 10,),
                               Customradiobttn(
                                 question: "1. Is VWSC or Pani samiti formed:",
                                 options: ["Yes", "No"],
                                 selectedOption: selectedVWSCFormed,
                                 onChanged: (val) => setState(() => selectedVWSCFormed = val),
                               ),
                               Customradiobttn(
                                 question: "2. Is VWSC bank account opened:",
                                 options: ["Yes", "No"],
                                 selectedOption: selectedVWSCBankAccount,
                                 onChanged: (val) => setState(() => selectedVWSCBankAccount = val),
                               ),
                               Customradiobttn(
                                 question: "3. VWSC/GP involvement in scheme operations:",
                                 options: ["Active", "Limited", "No Involvement", "VWSC not formed"],
                                 selectedOption: selectedVWSCInvolvement,
                                 onChanged: (val) => setState(() => selectedVWSCInvolvement = val),
                               ),
                               Customradiobttn(
                                 question: "4. As-built Drawing of Pipelines available with GP office:",
                                 options: ["Yes", "No"],
                                 selectedOption: selectedAsBuiltDrawing,
                                 onChanged: (val) => setState(() => selectedAsBuiltDrawing = val),
                               ),
                               Customradiobttn(
                                 question: "5. Whether meetings of VWSC are conducted in a periodic manner?",
                                 options: ["Yes", "No"],
                                 selectedOption: selectedVWSCMeetingConducted,
                                 onChanged: (val) => setState(() => selectedVWSCMeetingConducted = val),
                               ),
                               if (selectedVWSCMeetingConducted == "Yes")
                                 Customradiobttn(
                                   question: "If meeting held yes, Frequency:",
                                   options: ["Weekly", "Monthly", "Quarterly", "Other"],
                                   selectedOption: selectedVWSCMeetingFrequency,
                                   onChanged: (val) => setState(() => selectedVWSCMeetingFrequency = val),
                                 ),
                               Customradiobttn(
                                 question: "6. Whether records of VWSC meetings are available?",
                                 options: ["Yes", "No"],
                                 selectedOption: selectedVWSCRecordsAvailable,
                                 onChanged: (val) => setState(() => selectedVWSCRecordsAvailable = val),
                               ),
                               Customradiobttn(
                                 question: "7. VWSC/GP involved in O&M:",
                                 options: ["Yes – Active", "Yes – Limited", "No", "Not Applicable"],
                                 selectedOption: selectedVWSCOMInvolved,
                                 onChanged: (val) => setState(() => selectedVWSCOMInvolved = val),
                               ),
                               Customradiobttn(
                                 question: "8. Scheme formally handed over to GP/VWSC:",
                                 options: ["Yes", "No", "Not Applicable"],
                                 selectedOption: selectedSchemeHandover,
                                 onChanged: (val) => setState(() => selectedSchemeHandover = val),
                               ),
                               CustomMultiSelectChipQuestion(
                                 question: "9. Operation & Maintenance arrangements:",
                                 options: ["VWSC", "PHED", "Outsourced Contractor", "No arrangement"],
                                 selectedValues: selectedOMArrangements,
                                 onSelectionChanged: (valList) => setState(() => selectedOMArrangements = valList),
                               ),
                               Customradiobttn(
                                 question: "10. Community awareness about scheme features:",
                                 options: ["Well informed", "Some awareness", "No awareness"],
                                 selectedOption: selectedCommunityAwareness,
                                 onChanged: (val) => setState(() => selectedCommunityAwareness = val),
                               ),
                               Customradiobttn(
                                 question: "11. Community satisfaction with water quality:",
                                 options: ["Satisfied", "Partially Satisfied", "Dissatisfied", "Not Interacted"],
                                 selectedOption: selectedWaterQualitySatisfaction,
                                 onChanged: (val) => setState(() => selectedWaterQualitySatisfaction = val),
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
                                     onPressed: () {
                                       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => CommunityFeedbackPartC()),);

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
          ),
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
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      final villageId = args['villageId'] as int?;
      final stateId = args['stateId'] as int?;

      // You can now use them, or set them in your provider
      final vwscProvider = Provider.of<Vwscprovider>(context, listen: false);
      if (villageId != null) {
        vwscProvider.setVillageId(villageId);
      }
      if (stateId != null) {
        vwscProvider.setStateId(stateId);
      }
    }
  }
}
