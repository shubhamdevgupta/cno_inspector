import 'package:cno_inspection/utils/customradiobttn.dart';
import 'package:cno_inspection/views/InteractionDWSM/PartDOperationandMaintenance.dart';
import 'package:cno_inspection/views/PartASchemeInfo/Dashboardschemeinfo.dart';
import 'package:cno_inspection/views/PartASchemeInfo/PartASourceScreen.dart';
import 'package:flutter/material.dart';

import '../../utils/AppStyles.dart';
import '../../utils/CommonScreen.dart';
import '../../utils/CustomCheckBoxQuestion.dart';
import '../../utils/CustomRadioQuestion.dart';
import '../../utils/CustomTextField.dart';
import '../../utils/customcheckquestion.dart';
import '../../utils/customtxtfeild.dart';
import '../PartASchemeInfo/PartBSchemePlanningScreen.dart';
import 'DWSMCommonClass.dart';
import 'DashboardDWSM.dart';


class MonitioringQuality extends StatefulWidget {
  const MonitioringQuality({Key? key}) : super(key: key);

  @override
  _MonitioringQuality createState() => _MonitioringQuality();
}

class _MonitioringQuality extends State<MonitioringQuality> {
// State variables
  String? assetsGeotagged; // "All", "Partially", "Not Done"
  String? hasNablLab; // "Yes", "No"
  TextEditingController testingManagedController = TextEditingController();

  @override
  void dispose() {
    testingManagedController.dispose();
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
              "Monitoring, Quality and Lab Infrastructure",
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
                    no: 3,
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
                                question: "Are water supply assets (OHTs, WTPs, Pump Houses, etc.) geotagged?",
                                options: ["All", "Partially", "Not Done"],
                                selectedOption: assetsGeotagged,
                                onChanged: (val) => setState(() => assetsGeotagged = val),
                              ),
                              SizedBox(height: 12),
                              Customradiobttn(
                                question: "Does the district have an NABL-accredited lab or equivalent for water quality testing?",
                                options: ["Yes", "No"],
                                selectedOption: hasNablLab,
                                onChanged: (val) {
                                  setState(() {
                                    hasNablLab = val;
                                    if (val != "No") {
                                      testingManagedController.clear();
                                    }
                                  });
                                },
                              ),
                              if (hasNablLab == "No")
                                Customtxtfeild(
                                  label: "If no, how is testing managed?",
                                  controller: testingManagedController,
                                  maxLines: 2,
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
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => PartDoperationandmaintenance()),);

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
