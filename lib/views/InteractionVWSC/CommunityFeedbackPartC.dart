import 'package:cno_inspection/utils/customradiobttn.dart';
import 'package:cno_inspection/views/InteractionVWSC/WaterQualityPartD.dart';
import 'package:flutter/material.dart';

import '../../utils/AppStyles.dart';
import '../../utils/CommonScreen.dart';
import '../../utils/CustomCheckBoxQuestion.dart';
import '../../utils/CustomRadioQuestion.dart';
import '../../utils/MultiSelectionlist.dart';
import '../../utils/customcheckquestion.dart';
import '../../utils/customtxtfeild.dart';
import 'DashboardVWSC.dart';
import 'VWSCCommonClass.dart';

class CommunityFeedbackPartC extends StatefulWidget {


  @override
  State<CommunityFeedbackPartC> createState() => _CommunityFeedbackPartC();
}

class _CommunityFeedbackPartC extends State<CommunityFeedbackPartC> {
  String? selectedComplaintByCommunity; // Yes / No / Not Known
  List<String> selectedComplaintTypes = []; // multiple select options
  TextEditingController othersComplaintController = TextEditingController();
  String? selectedComplaintAddressed; // Yes / No / Partially

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
              "Community feedback on quality of construction",
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
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Vwsccommonclass(
                        no: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
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
                            padding: EdgeInsets.all(8),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Customradiobttn(
                                  question: "1. Any complaint by community on quality of construction:",
                                  options: ["Yes", "No", "Not Known"],
                                  selectedOption: selectedComplaintByCommunity,
                                  onChanged: (val) => setState(() => selectedComplaintByCommunity = val),
                                ),

                                if (selectedComplaintByCommunity == "Yes") ...[
                                  CustomMultiSelectChipQuestion(
                                    question: "2. Type of complaint (select all that apply):",
                                    options: [
                                      "Substandard material",
                                      "Poor workmanship",
                                      "Leakages",
                                      "Contamination",
                                      "Incomplete structures",
                                      "No water",
                                      "Water discoloration",
                                      "Others"
                                    ],
                                    selectedValues: selectedComplaintTypes,
                                    onSelectionChanged: (valList) => setState(() => selectedComplaintTypes = valList),
                                  ),

                                  // Show text field if 'Others' is selected
                                  if (selectedComplaintTypes.contains("Others"))
                                    Customtxtfeild(
                                      label: "Please specify other complaints:",
                                      controller: othersComplaintController,
                                      maxLines: 2,
                                    ),
                                ],

                                Customradiobttn(
                                  question: "3. Whether complaint is addressed:",
                                  options: ["Yes", "No", "Partially"],
                                  selectedOption: selectedComplaintAddressed,
                                  onChanged: (val) => setState(() => selectedComplaintAddressed = val),
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
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => WaterQualityPartD()),);

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
}
