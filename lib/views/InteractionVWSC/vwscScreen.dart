import 'package:flutter/material.dart';

import '../../utils/CustomRadioQuestion.dart';

class SWMQuestions extends StatefulWidget {
  const SWMQuestions({Key? key}) : super(key: key);

  @override
  _SWMQuestions createState() => _SWMQuestions();
}

class _SWMQuestions extends State<SWMQuestions> {
  String _selectedValue = 'yes'; // Default selected value
  String? selectedValueQ1;

  final List<String> _dropdownOptions = [
    'Atleast once in 7 days',
    'Atleast once in 15 days',
    'Atleast once in more than 15 days'
  ];
  String? SetFreq;

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
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            'SWM',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Color(0xffb2B4E71),
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
                    Card(
                      elevation: 5,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Water Supply Functionality",
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
                              questionText: "1.	Water supply frequency?",
                              options: ['Daily', 'Once in two days',' Once in three days ','Irregular','Not functional'], // You can pass more options if needed
                              selectedValue: selectedValueQ1,
                              onChanged: (val) {
                                setState(() {
                                  selectedValueQ1 = val;
                                });
                              },
                            ),

                            CustomRadioQuestion(
                              questionText: "2.	Is adequate water quantity reaching all the households: ",
                              options: ['Yes', 'No'], // You can pass more options if needed
                              selectedValue: selectedValueQ1,
                              onChanged: (val) {
                                setState(() {
                                  selectedValueQ1 = val;
                                });
                              },
                            ),
                            CustomRadioQuestion(
                              questionText: "3.	Is adequate water quantity reaching to remote/SC/ST/PVTG groups: ",
                              options: ['Yes', 'No'], // You can pass more options if needed
                              selectedValue: selectedValueQ1,
                              onChanged: (val) {
                                setState(() {
                                  selectedValueQ1 = val;
                                });
                              },
                            ),
                            CustomRadioQuestion(
                              questionText: "4.	Whether water reaches tail-end households: ",
                              options: ['Yes – Consistently', 'Occasionally','No','Not Verified'], // You can pass more options if needed
                              selectedValue: selectedValueQ1,
                              onChanged: (val) {
                                setState(() {
                                  selectedValueQ1 = val;
                                });
                              },
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "A 1.3 Does village have exclusive or shared vehicles for collection & transportation of waste ?",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 1.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          title: const Text(
                                              'Yes,exclusive vehicle'),
                                          leading: Radio<String>(
                                            value: 'Yes',
                                            groupValue: _selectedValue,
                                            onChanged: (String? value) {
                                              setState(() {
                                                _selectedValue = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          title:
                                              const Text('Yes, shared vehicle'),
                                          leading: Radio<String>(
                                            value: 'Yes, shared vehicle',
                                            groupValue: _selectedValue,
                                            onChanged: (String? value) {
                                              setState(() {
                                                _selectedValue = value!;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "A 1.6 What is the frequency of collection?",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  SizedBox(height: 5),
                                  Container(
                                      width: 400,
                                      margin: const EdgeInsets.all(5.0),
                                      padding: const EdgeInsets.only(
                                          left: 5.0, right: 10.0),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: DropdownButton<String>(
                                        value: SetFreq,
                                        hint: Text('Select Frequency'),
                                        items: _dropdownOptions
                                            .map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            SetFreq = newValue;
                                          });
                                        },
                                      )),
                                  SizedBox(height: 20),
                                  Text(
                                    "A 1.8 Does the village have a collection and segregation shed for solid waste management?",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 1.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: ListTile(
                                            contentPadding: EdgeInsets.zero,
                                            title: const Text('Yes'),
                                            leading: Radio<String>(
                                              value: 'yes',
                                              groupValue: _selectedValue,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _selectedValue = value!;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: ListTile(
                                            contentPadding: EdgeInsets.zero,
                                            title: const Text('No'),
                                            leading: Radio<String>(
                                              value: 'no',
                                              groupValue: _selectedValue,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _selectedValue = value!;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: SizedBox(
                                      height: 35,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xffb0D6EFD),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10), // Adjust the radius as needed
                                          ),
                                        ),
                                        onPressed: () {
/*
                                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => GWMQuestions()),);
*/
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
                            )
                          ],
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
    );
  }
}
