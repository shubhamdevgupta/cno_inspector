import 'package:cno_inspection/provider/vwscInfoProvider/VwscProvider.dart';
import 'package:cno_inspection/services/LocalStorageService.dart';
import 'package:cno_inspection/utils/customradiobttn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../provider/AppStateProvider.dart';
import '../../utils/AppConstants.dart';
import '../../utils/AppStyles.dart';
import '../../utils/CommonScreen.dart';
import '../../utils/CustomRadioQuestion.dart';
import '../../utils/LoaderUtils.dart';
import '../../utils/MultiSelectionlist.dart';
import '../../utils/UserFeedback.dart';
import '../../utils/toast_helper.dart';
import 'BelowVWSCCommon.dart';
import 'DashboardVWSC.dart';
import 'AboveVWSCCommonClass.dart';

class GrievancePartE extends StatefulWidget {
  @override
  State<GrievancePartE> createState() => _GrievancePartE();
}

class _GrievancePartE extends State<GrievancePartE> {
  LocalStorageService _localStorageService = LocalStorageService();
  ProjectMode?ModeType;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;


      if (args != null) {
        final villageId = args['villageId'] as int?;
        final stateId = args['stateId'] as int?;

        final vwscProvider = Provider.of<Vwscprovider>(context, listen: false);
        vwscProvider.clearFetchGrievance();
        if (villageId != null) {
          vwscProvider.setVillageId(villageId);
        }
        if (stateId != null) {
          vwscProvider.setStateId(stateId);
        }

        ModeType = Provider.of<AppStateProvider>(context, listen: false).mode;
        vwscProvider.fetchVwscGrievance(
            stateId.toString(),
            villageId.toString(),
            _localStorageService.getInt(AppConstants.prefUserId).toString(), ModeType!.modeValue);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Replace the current route with a new one
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => Dashboardvwsc()),
        );
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
                "Grievance Redressal",
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
            body: Consumer<Vwscprovider>(
              builder: (context, vwscProvider, child) {
                final mode = Provider.of<AppStateProvider>(context, listen: false).mode;
                return SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mode == ProjectMode.below10? Belowvwsccommon(no: 4):  Abovevwsccommonclass(no: 5),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.green, width: 1.4),
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12.withOpacity(0.06),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // 1. Grievance redressal mechanism available
                                  Customradiobttn(
                                    question:
                                        "1. Grievance redressal mechanism available:",
                                    options: vwscProvider.yesNoMap.keys.toList(),
                                    selectedOption:
                                        vwscProvider.selectedGrievanceMechanism,
                                    onChanged: (val) => vwscProvider
                                        .selectedGrievanceMechanism = val,
                                  ),


                                  // 2. How grievances are registered by villagers (multi-select)
                                  CustomMultiSelectChipQuestion(
                                    question:
                                        "2. How grievances are registered by the villagers:",
                                    options: vwscProvider
                                        .grievanceRegistrationMethodMap.keys
                                        .toList(),
                                    selectedValues:
                                        vwscProvider.grievanceRegistrationMethods,
                                    onSelectionChanged: (val) {
                                      vwscProvider.grievanceRegistrationMethods =
                                          val;
                                      print(
                                          'Selected IDs: ${vwscProvider.selectedGrievanceMethodIds}');
                                    },
                                  ),



                                  // 3. Turn around time for grievance

                                  Customradiobttn(
                                    question:
                                        "3. Turn around time for grievance:",
                                    options: vwscProvider.turnAroundTimeMap.keys
                                        .toList(),
                                    selectedOption:
                                        vwscProvider.selectedTurnAroundTime,
                                    onChanged: (val) =>
                                        vwscProvider.selectedTurnAroundTime = val,
                                  ),



                                  CustomObservationField(
                                    labelText: '* Obseration on "Grievance Redressal" :',
                                    controller:  vwscProvider.PartEVWSCuserObservationController,
                                  ),


                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: SizedBox(
                                      height: 35,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10), // Adjust the radius as needed
                                          ),
                                        ),
                                        onPressed: () async {
                                          LoaderUtils.showLoadingWithMessage(
                                              context,
                                              isLoading: vwscProvider.isLoading,
                                              message: "Grievance Redressal");
                                          await vwscProvider.saveGrievanceRedressal(
                                            userId: _localStorageService.getInt(AppConstants.prefUserId)!,
                                            stateId: vwscProvider.stateId!,
                                            villageId: vwscProvider.villageId!,
                                            grievanceMechanismAvailable: vwscProvider.selectedGrievanceMechanismId,
                                            grievanceTurnAroundTime: vwscProvider.selectedTurnAroundTimeId,
                                            registrationTypes: vwscProvider.selectedGrievanceMethodIds,
                                            observationGrievanceRedressal: vwscProvider.PartEVWSCuserObservationController.text, // NEW
                                            phyStatus: mode.modeValue, // NEW

                                          );

                                          if (vwscProvider.status!) {
                                            ToastHelper.showToastMessage(
                                                vwscProvider.message!,
                                                backgroundColor: Colors.green);
                                            // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => Dashboardvwsc()),);

                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      Dashboardvwsc()),
                                              (Route<dynamic> route) => false,
                                            );
                                          } else {
                                            ToastHelper.showToastMessage(
                                                vwscProvider.message!,
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
                              ),
                            ),
                          ),
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
