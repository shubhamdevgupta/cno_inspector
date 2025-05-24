import 'package:cno_inspection/utils/customradiobttn.dart';
import 'package:cno_inspection/views/PartASchemeInfo/Dashboardschemeinfo.dart';
import 'package:cno_inspection/views/PartASchemeInfo/PartASourceScreen.dart';
import 'package:flutter/material.dart';

import '../../utils/AppStyles.dart';
import '../../utils/CommonScreen.dart';
import '../../utils/CustomCheckBoxQuestion.dart';
import '../../utils/CustomRadioQuestion.dart';
import '../../utils/CustomTextField.dart';
import '../../utils/MultiSelectionlist.dart';
import '../../utils/customcheckquestion.dart';
import '../../utils/customtxtfeild.dart';
import '../PartASchemeInfo/PartBSchemePlanningScreen.dart';
import 'DWSMCommonClass.dart';
import 'DashboardDWSM.dart';


class PartFPublicCompliant extends StatefulWidget {
  const PartFPublicCompliant({Key? key}) : super(key: key);

  @override
  _PartFPublicCompliant createState() => _PartFPublicCompliant();
}

class _PartFPublicCompliant extends State<PartFPublicCompliant> {
// State variables
  // State variables
  String? grievanceMechanismAvailable;
  List<String> grievanceRegistrationMethods = [];
  String? complaintsReceived;
  List<String> complaintTypes = [];
  TextEditingController avgResolutionTimeController = TextEditingController();
  TextEditingController actionTakenController = TextEditingController();

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
              image: AssetImage('assets/icons/header_bg.png'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            // Removes the default back button
            centerTitle: true,
            title: Text(
              "Public Complaints and Grievance Redressal",
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
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 20, left: 6, right: 6, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Dwsmcommonclass(
                        no: 6,
                      ),
                      Card(
                        elevation: 5,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.deepPurpleAccent, width: 1.4),
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
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                // Grievance mechanism available
                                Customradiobttn(
                                  question: "1. Grievance Redressal mechanism available:",
                                  options: ["Yes", "No"],
                                  selectedOption: grievanceMechanismAvailable,
                                  onChanged: (val) => setState(() => grievanceMechanismAvailable = val),
                                ),

                                const SizedBox(height: 10),

                                // How grievances are registered
                                CustomMultiSelectChipQuestion(
                                  question: "2. How grievances are registered by the villagers:",
                                  options: [
                                    "Toll free number",
                                    "Web based portal",
                                    "Mobile application",
                                    "Public grievance registration center",
                                    "Directly calling to PHED/Contractor/O&M agency"
                                  ],
                                  selectedValues: grievanceRegistrationMethods,
                                  onSelectionChanged: (values) {
                                    setState(() {
                                      grievanceRegistrationMethods = values;
                                    });
                                  },
                                ),

                                const SizedBox(height: 10),

                                // Are complaints received
                                Customradiobttn(
                                  question: "3. Are complaints received from public regarding JJM schemes?",
                                  options: ["Yes", "No"],
                                  selectedOption: complaintsReceived,
                                  onChanged: (val) => setState(() => complaintsReceived = val),
                                ),

                                if (complaintsReceived == "Yes") ...[
                                  const SizedBox(height: 10),

                                  // Type of complaints
                                  CustomMultiSelectChipQuestion(
                                    question: "3.1 If yes, type of complaints (tick all applicable):",
                                    options: [
                                      "Poor water quality",
                                      "Incomplete connections",
                                      "Delay in commissioning",
                                      "No water supply",
                                      "Faulty construction",
                                      "Others"
                                    ],
                                    selectedValues: complaintTypes,
                                    onSelectionChanged: (values) {
                                      setState(() {
                                        complaintTypes = values;
                                      });
                                    },
                                  ),

                                  const SizedBox(height: 10),

                                  // Average resolution time
                                  Customtxtfeild(
                                    label: "3.2 What is the average time of resolution:",
                                    controller: avgResolutionTimeController,
                                  ),

                                  const SizedBox(height: 10),

                                  // Action taken
                                  Customtxtfeild(
                                    label: "3.3 Action taken by department:",
                                    controller: actionTakenController,
                                  ),


                                ],

                                SizedBox(height: 10,),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    height: 35,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.deepPurpleAccent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => Dashboarddwsm()),);

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
                            )
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
