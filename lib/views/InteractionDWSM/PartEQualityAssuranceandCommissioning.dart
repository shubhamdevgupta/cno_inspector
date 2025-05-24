import 'package:cno_inspection/utils/customradiobttn.dart';
import 'package:cno_inspection/views/InteractionDWSM/PartFPublicComplaintsandGrievance.dart';
import 'package:cno_inspection/views/PartASchemeInfo/Dashboardschemeinfo.dart';
import 'package:cno_inspection/views/PartASchemeInfo/PartASourceScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/dwsmInfoProvider/DwsmProvider.dart';
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


class PartEQualityAssuranceCommissioning extends StatefulWidget {
  const PartEQualityAssuranceCommissioning({Key? key}) : super(key: key);

  @override
  _PartEQualityAssuranceCommissioning createState() => _PartEQualityAssuranceCommissioning();
}

class _PartEQualityAssuranceCommissioning extends State<PartEQualityAssuranceCommissioning> {
// State variables
  // State variables
  List<String> authorizedInspectors = [];
  String? commissioningProtocolFollowed;
  List<String> commissioningPresence = [];
  String? thirdPartyAssessment;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      final districtid = args['districtid'] as int?;
      final stateId = args['stateId'] as int?;
      final dwsmProvider = Provider.of<Dwsmprovider>(context, listen: false);
      if (districtid != null) {
        dwsmProvider.setDistrictId(districtid);
      }
      if (stateId != null) {
        dwsmProvider.setStateId(stateId);
      }
    }
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
              "Quality Assurance and Commissioning",
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
                        no: 5,
                      ),
                      Card(
                        elevation: 5,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.green, width: 1.4),
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

                                // Authorized inspectors
                                CustomMultiSelectChipQuestion(
                                  question: "1. Who all are authorized to inspect and measure works during field inspection?",
                                  options: [
                                    "PHED Engineer",
                                    "PMC/PMU",
                                    "TPIA",
                                    "VWSC",
                                    "Contractor Representative",
                                    "Others"
                                  ],
                                  selectedValues: authorizedInspectors,
                                  onSelectionChanged: (values) {
                                    setState(() {
                                      authorizedInspectors = values;
                                    });
                                  },
                                ),

                                const SizedBox(height: 10),

                                // Commissioning protocol followed
                                Customradiobttn(
                                  question: "2. Is the commissioning protocol being followed?",
                                  options: ["Yes", "No"],
                                  selectedOption: commissioningProtocolFollowed,
                                  onChanged: (val) => setState(() => commissioningProtocolFollowed = val),
                                ),

                                const SizedBox(height: 10),

                                // Presence during commissioning
                                CustomMultiSelectChipQuestion(
                                  question: "3. During commissioning of schemes, who are generally present?",
                                  options: [
                                    "PHED",
                                    "VWSC Members",
                                    "PRI Representatives",
                                    "ISA",
                                    "TPIA",
                                    "Community Members"
                                  ],
                                  selectedValues: commissioningPresence,
                                  onSelectionChanged: (values) {
                                    setState(() {
                                      commissioningPresence = values;
                                    });
                                  },
                                ),

                                const SizedBox(height: 10),

                                // Assessment of TPIAs
                                Customradiobttn(
                                  question: "4. Has the district undertaken any assessment of third-party inspection agencies on quality checks for JJM schemes?",
                                  options: ["Yes – Regularly", "Occasionally", "Not Done"],
                                  selectedOption: thirdPartyAssessment,
                                  onChanged: (val) => setState(() => thirdPartyAssessment = val),
                                ),

                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    height: 35,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => PartFPublicCompliant()),);

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
