import 'package:cno_inspection/views/InteractionVWSC/WaterQualityPartD.dart';
import 'package:flutter/material.dart';

import '../../utils/AppStyles.dart';
import '../../utils/CommonScreen.dart';
import '../../utils/CustomCheckBoxQuestion.dart';
import '../../utils/CustomRadioQuestion.dart';
import 'DashboardVWSC.dart';

class CommunityFeedbackPartC extends StatefulWidget {


  @override
  State<CommunityFeedbackPartC> createState() => _CommunityFeedbackPartC();
}

class _CommunityFeedbackPartC extends State<CommunityFeedbackPartC> {
  String? selectedValueQ1;
  List<String> selectedInstitutions = [];
  String? selectedFrequency;

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
              "Waster Supply",
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
                child: Container(
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NewScreenPoints(
                        no: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 5,
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(8),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Community feedback on quality of construction",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.orange),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  color: Colors.black38, // Color of the line
                                  height: 1.0,
                                  width: double.infinity, // Thickness of the line
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                CustomRadioQuestion(
                                  questionText: "1.	Any complaint by community on quality of construction: ",
                                  options: [
                                    'Yes',
                                    'No',
                                    'Not Known',
                                  ], // You can pass more options if needed
                                  selectedValue: selectedValueQ1,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedValueQ1 = val;
                                    });
                                  },
                                ),
                                CustomCheckboxQuestion(
                                  questionText:
                                  "2.	Type of complaint (select all that apply):",
                                  options: [
                                    'Substandard material ',
                                    'Poor workmanship ',
                                    'Leakages ',
                                    'Contamination',
                                    'Incomplete structures ',
                                    'No water ',
                                    'Water discoloration ',
                                    'Others '
                                  ],
                                  selectedValues: selectedInstitutions,
                                  onChanged: (newSelected) {
                                    setState(() {
                                      selectedInstitutions = newSelected;
                                    });
                                  },
                                ),
                                CustomRadioQuestion(
                                  questionText: "3.	Whether complaint is addressed",
                                  options: [
                                    'Yes',
                                    'No',
                                    'Partially',
                                  ], // You can pass more options if needed
                                  selectedValue: selectedValueQ1,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedValueQ1 = val;
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
                            ),
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
