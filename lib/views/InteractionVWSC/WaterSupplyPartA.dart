import 'package:cno_inspection/utils/CustomCheckBoxQuestion.dart';
import 'package:cno_inspection/views/InteractionVWSC/CommunityInvolvementPartB.dart';
import 'package:cno_inspection/views/InteractionVWSC/DashboardVWSC.dart';
import 'package:flutter/material.dart';

import '../../utils/AppStyles.dart';
import '../../utils/CommonScreen.dart';
import '../../utils/CustomRadioQuestion.dart';
import '../../utils/MultiSelectionlist.dart';
import '../../utils/customradiobttn.dart';
import '../../utils/customtxtfeild.dart';
import 'VWSCCommonClass.dart';

class WaterSupplyPartA extends StatefulWidget {
  const WaterSupplyPartA({Key? key}) : super(key: key);

  @override
  _WaterSupplyPartA createState() => _WaterSupplyPartA();
}

class _WaterSupplyPartA extends State<WaterSupplyPartA> {
  List<String> selectedFrequency = [];
  String? selectedHouseholdWater;
  String? selectedRemoteGroups;
  TextEditingController reasonRemoteGroupsController = TextEditingController();
  String? selectedTailEnd;
  String? selectedSchemeStatus;
  List<String> selectedInstitutions = [];
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
              "Water Supply Functionality",
              style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),
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
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 20, left: 6, right: 6, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Vwsccommonclass(
                        no: 1,
                      ),

                      Card(
                        elevation: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.blue, width: 1.4),
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
                          child: Container(

                            child: Column(


                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [


                                CustomMultiSelectChipQuestion(
                                  question: "1. Water supply frequency:",
                                  options: [
                                    "Daily",
                                    "Once in two days",
                                    "Once in three days",
                                    "Irregular",
                                    "Not functional"
                                  ],
                                  selectedValues: selectedFrequency,
                                  onSelectionChanged: (val) => setState(() => selectedFrequency = val),
                                ),


                                Customradiobttn(
                                  question: "2. Is adequate water quantity reaching all the households?",
                                  options: ["Yes", "No"],
                                  selectedOption: selectedHouseholdWater,
                                  onChanged: (val) => setState(() => selectedHouseholdWater = val),
                                ),

                                Customradiobttn(
                                  question: "3. Is adequate water quantity reaching to remote/SC/ST/PVTG groups?",
                                  options: ["Yes", "No"],
                                  selectedOption: selectedRemoteGroups,
                                  onChanged: (val) => setState(() => selectedRemoteGroups = val),
                                ),

                                if (selectedRemoteGroups == "No")
                                  Customtxtfeild(
                                    label: "If no, please provide the reasons",
                                    controller: reasonRemoteGroupsController,
                                  ),


                                Customradiobttn(
                                  question: "4. Whether water reaches tail-end households:",
                                  options: ["Yes – Consistently", "Occasionally", "No", "Not Verified"],
                                  selectedOption: selectedTailEnd,
                                  onChanged: (val) => setState(() => selectedTailEnd = val),
                                ),

                                Customradiobttn(
                                  question: "5. Scheme operational status since commissioning:",
                                  options: [
                                    "Fully operational >3 months",
                                    "Operational but with interruptions",
                                    "Non-functional",
                                    "Partially commissioned"
                                  ],
                                  selectedOption: selectedSchemeStatus,
                                  onChanged: (val) => setState(() => selectedSchemeStatus = val),
                                ),

                                CustomMultiSelectChipQuestion(
                                  question: "6. Whether piped water supply services available at institutions:",
                                  options: ["Schools", "Anganwadi’s", "PHCs", "Not Applicable"],
                                  selectedValues: selectedInstitutions,
                                  onSelectionChanged: (selectedList) {
                                    setState(() {
                                      selectedInstitutions = selectedList;
                                    });
                                  },
                                ),


                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    height: 35,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xffb0D6EFD),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => CommunityInvolvementPartB()),);

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
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
