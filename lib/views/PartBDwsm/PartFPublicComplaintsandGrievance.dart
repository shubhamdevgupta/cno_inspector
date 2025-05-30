import 'package:cno_inspection/services/LocalStorageService.dart';
import 'package:cno_inspection/utils/AppConstants.dart';
import 'package:cno_inspection/utils/customradiobttn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/AppStateProvider.dart';
import '../../provider/dwsmInfoProvider/DwsmProvider.dart';
import '../../utils/AppStyles.dart';
import '../../utils/LoaderUtils.dart';
import '../../utils/MultiSelectionlist.dart';
import '../../utils/customtxtfeild.dart';
import '../../utils/toast_helper.dart';
import 'DWSMCommonClass.dart';
import 'DashboardDWSM.dart';

class PartFPublicCompliant extends StatefulWidget {
  const PartFPublicCompliant({Key? key}) : super(key: key);

  @override
  _PartFPublicCompliant createState() => _PartFPublicCompliant();
}

class _PartFPublicCompliant extends State<PartFPublicCompliant> {
  LocalStorageService localStorageService = LocalStorageService();
  ProjectMode? modeType;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      if (args != null) {
        final districtid = args['districtid'] as int?;
        final stateId = args['stateId'] as int?;
        final dwsmProvider = Provider.of<Dwsmprovider>(context, listen: false);
        dwsmProvider.clearfetchGrievanceRedressalData();
        if (districtid != null) {
          dwsmProvider.setDistrictId(districtid);
        }
        if (stateId != null) {
          dwsmProvider.setStateId(stateId);
        }
         modeType = Provider.of<AppStateProvider>(context, listen: false).mode;

        dwsmProvider.fetchGrievanceRedressalData(
            stateId.toString(),
            districtid.toString(),
            localStorageService.getInt(AppConstants.prefUserId).toString(),modeType!.modeValue);
      }
    });
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
              image: AssetImage('assets/icons/header_bg.png'),
              fit: BoxFit.cover),
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
            body: Consumer<Dwsmprovider>(
              builder: (context, dwsmProvider, child) {
                return SingleChildScrollView(
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
                                border: Border.all(
                                    color: Colors.deepPurpleAccent, width: 1.4),
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
                                    question:
                                        "1. Grievance Redressal mechanism available:",
                                    options:
                                        dwsmProvider.yesNoMap.keys.toList(),
                                    selectedOption: dwsmProvider
                                        .grievanceMechanismAvailable,
                                    onChanged: (val) => dwsmProvider
                                        .grievanceMechanismAvailable = val,
                                  ),
                                  CustomMultiSelectChipQuestion(
                                    question: '2. How grievances are registered by the villagers:',
                                    options:  dwsmProvider
                                        .grievanceRegistrationMethodsMap.keys
                                        .toList(),
                                    selectedValues: dwsmProvider.grievanceRegistrationMethods,
                                    onSelectionChanged: (val) {
                                      dwsmProvider.grievanceRegistrationMethods = val;
                                    },
                                  ),
                                  Customradiobttn(
                                    question:
                                        "3. Are complaints received from public regarding JJM schemes?",
                                    options:
                                        dwsmProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                        dwsmProvider.complaintsReceived,
                                    onChanged: (val) =>
                                        dwsmProvider.complaintsReceived = val,
                                  ),
                                  if (dwsmProvider.complaintsReceived ==
                                      "Yes") ...[
                                    const SizedBox(height: 10),
                                    CustomMultiSelectChipQuestion(
                                      question: '3.1 If yes, type of complaints (tick all applicable):',
                                      options: dwsmProvider.complaintTypeMap.keys.toList(),
                                      selectedValues: dwsmProvider.complaintTypes,
                                      onSelectionChanged: (val) {
                                        dwsmProvider.complaintTypes = val;
                                      },
                                    ),


                                    // Show text field if 'Others' is selected
                                    if (dwsmProvider.complaintTypes.contains("Others"))
                                      Customtxtfeild(
                                        label: "In Case of Other please provide details:",
                                        controller: dwsmProvider.othersComplaintController,
                                        maxLines: 2,
                                      ),
                                    const SizedBox(height: 10),
                                    Customtxtfeild(
                                      label:
                                          "3.2 What is the average time of resolution:",
                                      controller: dwsmProvider
                                          .avgResolutionTimeController,
                                      keyboardType: TextInputType.number,
                                    ),
                                    const SizedBox(height: 10),
                                    Customtxtfeild(
                                      label: "3.3 Action taken by department:",
                                      controller:
                                          dwsmProvider.actionTakenController,
                                      keyboardType: TextInputType.text,
                                    ),
                                  ],

                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: SizedBox(
                                      height: 35,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.deepPurpleAccent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10), // Adjust the radius as needed
                                          ),
                                        ),
                                        onPressed: () async {
                                          LoaderUtils.showLoadingWithMessage(
                                              context,
                                              isLoading: dwsmProvider.isLoading,
                                              message:
                                                  "Saving Public Complaints and Grievance Redressal");
                                          print('------------------- ${dwsmProvider.complaintTypesID}');
                                          await dwsmProvider.saveGrievanceRedressal(
                                              userId:
                                                  localStorageService.getInt(
                                                      AppConstants.prefUserId)!,
                                              stateId: dwsmProvider.stateId!,
                                              districtId:
                                                  dwsmProvider.districtId!,
                                              grievanceMechanismAvailable:
                                                  dwsmProvider
                                                      .grievanceMechanismAvailableID,
                                              howGrievancesRegistered: dwsmProvider
                                                  .selectedGrievanceRegistrationMethodsID,
                                              complaintsReceived: dwsmProvider
                                                  .complaintsReceivedID,
                                              typeOfComplaints:
                                                  dwsmProvider.complaintTypesID,
                                              otherComplaints: '',
                                              resolutionTime: dwsmProvider.avgResolutionTimeController.text.isEmpty ? 0:int.parse(dwsmProvider.avgResolutionTimeController.text),
                                              actionTakenByDepartment:
                                              dwsmProvider.actionTakenController.text.isEmpty ? 0:  int.parse(dwsmProvider
                                                      .actionTakenController
                                                      .text),
                                                modeType: modeType!.modeValue
                                          );

                                          if (dwsmProvider.status!) {
                                            ToastHelper.showToastMessage(
                                                dwsmProvider.message!,
                                                backgroundColor: Colors.green);
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      Dashboarddwsm()),
                                              (Route<dynamic> route) => false,
                                            );
                                          } else {
                                            ToastHelper.showToastMessage(
                                                dwsmProvider.message!,
                                                backgroundColor: Colors.red);
                                          }
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
                              )),
                        )
                      ],
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
}
