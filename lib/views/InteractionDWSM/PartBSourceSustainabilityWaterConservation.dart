import 'package:cno_inspection/utils/customradiobttn.dart';
import 'package:cno_inspection/views/InteractionDWSM/PartCMonitoringQualityandLabInfrastructure.dart';
import 'package:cno_inspection/views/schemeInfo/Dashboardschemeinfo.dart';
import 'package:cno_inspection/views/schemeInfo/PartASourceScreen.dart';
import 'package:flutter/material.dart';

import '../../utils/AppStyles.dart';
import '../../utils/CommonScreen.dart';
import '../../utils/CustomCheckBoxQuestion.dart';
import '../../utils/CustomRadioQuestion.dart';
import '../../utils/CustomTextField.dart';
import '../../utils/customcheckquestion.dart';
import '../../utils/customtxtfeild.dart';
import '../schemeInfo/PartBSchemePlanningScreen.dart';
import 'DWSMCommonClass.dart';
import 'DashboardDWSM.dart';


class SourceSustainablitiyWasterConservation extends StatefulWidget {
  const SourceSustainablitiyWasterConservation({Key? key}) : super(key: key);

  @override
  _SourceSustainablitiyWasterConservation createState() => _SourceSustainablitiyWasterConservation();
}

class _SourceSustainablitiyWasterConservation extends State<SourceSustainablitiyWasterConservation> {
  String? sourceSustainability; // Actively, Limited, Not Promoted
  String? groundwaterProtection; // Yes, Partially, No
  String? rechargeStructureImplemented; // Yes, In Progress, No
  String? rechargeReason = ""; // only if 'No' selected here
  String? impactStudies; // Yes - Completed, Planned, No

  TextEditingController rechargeReasonController = TextEditingController();

  @override
  void dispose() {
    rechargeReasonController.dispose();
    super.dispose();
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
              image: AssetImage('assets/icons/header_bg.png'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            // Removes the default back button
            centerTitle: true,
            title: Text(
              "Source Sustainability and Water Conservation",
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
                        no: 2,
                      ),
                      Card(
                        elevation: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.deepOrangeAccent, width: 1.4),
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
                                question: "1. Are source sustainability measures being promoted (e.g., groundwater recharge, reuse of treated wastewater)?",
                                options: ["Actively", "Limited", "Not Promoted"],
                                selectedOption: sourceSustainability,
                                onChanged: (val) => setState(() => sourceSustainability = val),
                              ),
                              SizedBox(height: 12),
                              Customradiobttn(
                                question: "2. Are piped water schemes based on groundwater sources protected from contamination?",
                                options: ["Yes", "Partially", "No"],
                                selectedOption: groundwaterProtection,
                                onChanged: (val) => setState(() => groundwaterProtection = val),
                              ),
                              SizedBox(height: 12),
                              Customradiobttn(
                                question: "3. Is at least one recharge structure per groundwater source implemented?",
                                options: ["Yes", "In Progress", "No"],
                                selectedOption: rechargeStructureImplemented,
                                onChanged: (val) {
                                  setState(() {
                                    rechargeStructureImplemented = val;
                                    if (val != "No") {
                                      rechargeReasonController.clear();
                                    }
                                  });
                                },
                              ),
                              if (rechargeStructureImplemented == "No")
                                Customtxtfeild(
                                  label: "If no, reason:",
                                  controller: rechargeReasonController,
                                  maxLines: 2,
                                ),
                              SizedBox(height: 12),
                              Customradiobttn(
                                question: "4. Are any impact studies or assessments conducted on source sustainability efforts?",
                                options: ["Yes – Completed", "Planned", "No"],
                                selectedOption: impactStudies,
                                onChanged: (val) => setState(() => impactStudies = val),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  height: 35,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepOrange,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => MonitioringQuality()),);

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
