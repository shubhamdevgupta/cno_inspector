import 'package:cno_inspection/utils/customradiobttn.dart';
import 'package:cno_inspection/views/InteractionDWSM/PartEQualityAssuranceandCommissioning.dart';
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
import 'DashboardDWSM.dart';


class PartDoperationandmaintenance extends StatefulWidget {
  const PartDoperationandmaintenance({Key? key}) : super(key: key);

  @override
  _PartDoperationandmaintenance createState() => _PartDoperationandmaintenance();
}

class _PartDoperationandmaintenance extends State<PartDoperationandmaintenance> {
// State variables
  String? handoverProtocol; // "Yes", "No", "Partially"
  TextEditingController manpowerPercentController = TextEditingController();
  TextEditingController waterFeeController = TextEditingController();
  String? feeBasis; // "Uniform", "Volumetric"
  TextEditingController userFeePercentController = TextEditingController();

  @override
  void dispose() {
    manpowerPercentController.dispose();
    waterFeeController.dispose();
    userFeePercentController.dispose();
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
              "Operation & Maintenance (O&M)",
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
                      NewScreenPoints(
                        no: 4,
                      ),
                      Card(
                        elevation: 5,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.lightGreen, width: 1.4),
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

                                // Protocol for handing over infrastructure
                                Customradiobttn(
                                  question: "Is a protocol for handing over in-village infrastructure in place?",
                                  options: ["Yes", "No", "Partially"],
                                  selectedOption: handoverProtocol,
                                  onChanged: (val) => setState(() => handoverProtocol = val),
                                ),

                                const SizedBox(height: 10),

                                // Percentage of villages with trained manpower
                                Customtxtfeild(
                                  label: "Percentage of villages where trained multi-skilled manpower available for O&M",
                                  controller: manpowerPercentController,
                                  keyboardType: TextInputType.number,
                                ),

                                const SizedBox(height: 10),

                                // Water fee amount
                                Customtxtfeild(
                                  label: "Water fee amount (₹/month or per connection)",
                                  controller: waterFeeController,
                                  keyboardType: TextInputType.number,
                                ),

                                const SizedBox(height: 10),

                                // Fee basis: Uniform or Volumetric
                                Customradiobttn(
                                  question: "Is the fee uniform or based on consumption?",
                                  options: ["Uniform", "Volumetric"],
                                  selectedOption: feeBasis,
                                  onChanged: (val) => setState(() => feeBasis = val),
                                ),

                                const SizedBox(height: 10),

                                // User fee collection percentage
                                Customtxtfeild(
                                  label: "Percentage of villages where User Fee is being collected",
                                  controller: userFeePercentController,
                                  keyboardType: TextInputType.number,
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
                                        backgroundColor: Colors.lightGreen,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => PartEQualityAssuranceCommissioning()),);

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
