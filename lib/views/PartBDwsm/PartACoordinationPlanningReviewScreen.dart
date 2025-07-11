import 'package:cno_inspection/provider/dwsmInfoProvider/DwsmProvider.dart';
import 'package:cno_inspection/services/LocalStorageService.dart';
import 'package:cno_inspection/utils/customradiobttn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/AppStateProvider.dart';
import '../../utils/AppConstants.dart';
import '../../utils/AppStyles.dart';
import '../../utils/LoaderUtils.dart';
import '../../utils/UserFeedback.dart';
import '../../utils/customtxtfeild.dart';
import '../../utils/toast_helper.dart';
import 'AboveDWSMCommonClass.dart';
import 'DashboardDWSM.dart';
import 'PartBSourceSustainabilityWaterConservation.dart';

class CoordinationPlanningReview extends StatefulWidget {
  const CoordinationPlanningReview({Key? key}) : super(key: key);

  @override
  _CoordinationPlanningReview createState() => _CoordinationPlanningReview();
}

class _CoordinationPlanningReview extends State<CoordinationPlanningReview> {
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
        dwsmProvider.clearCoordinationFields();
        if (districtid != null) {
          dwsmProvider.setDistrictId(districtid);
        }
        if (stateId != null) {
          dwsmProvider.setStateId(stateId);
        }
        modeType = Provider.of<AppStateProvider>(context, listen: false).mode;

        dwsmProvider.fetchCoordinationData(
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
                "Coordination, Planning & Review Mechanism",
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
            body:
                Consumer<Dwsmprovider>(builder: (context, dwsmProvider, child) {
                  return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 20, left: 6, right: 6, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Dwsmcommonclass(
                        no: 1,
                      ),
                      Card(
                        elevation: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.blue, width: 1.4),
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
                              Customtxtfeild(
                                label:
                                '1. Is there any audit (internal/ concurrent/ performance) observations and findings related to the JJM schemes for the district?',
                                controller:
                                dwsmProvider.auditInternalObservation,
                                keyboardType: TextInputType.text,
                              ),
                              Customradiobttn(
                                question:
                                    '2. Are monthly DWSM meetings on progress of JJM works being held?',
                                options: dwsmProvider.yesNoMap.keys.toList(),
                                selectedOption: dwsmProvider.selectedValueQ1,
                                onChanged: (value) {
                                  dwsmProvider.selectedValueQ1 = value;
                                },
                              ),

                              // Conditionally show subquestions
                              if (dwsmProvider.selectedValueQ1 == 'Yes') ...[
                                const SizedBox(height: 8),
                                Customtxtfeild(
                                  label:
                                      '2.1 How many meetings were held in the last six months?',
                                  controller:
                                      dwsmProvider.meetingsHeldController,
                                  keyboardType: TextInputType.number,
                                ),
                                const SizedBox(height: 8),
                                Customradiobttn(
                                  question:
                                      '2.2 Quality of Meeting and Record maintenance:',
                                  options: dwsmProvider.meetingQualityMap.keys
                                      .toList(),
                                  selectedOption:
                                      dwsmProvider.selectedMeetingQuality,
                                  onChanged: (value) {
                                    dwsmProvider.selectedMeetingQuality = value;
                                  },
                                ),
                              ],

                              const SizedBox(height: 16),

                              // Question 2
                              Customradiobttn(
                                question:
                                    '3. Are District Development Coordination and Monitoring Committee (DISHA) meetings being held regularly?',
                                options: dwsmProvider.yesNoMap.keys.toList(),
                                selectedOption: dwsmProvider.selectedDISHA,
                                onChanged: (value) {
                                  dwsmProvider.selectedDISHA = value;
                                },
                              ),

                              SizedBox(
                                height: 10,
                              ),

                              CustomObservationField(
                                labelText: '* Obseration on "Coordination, Planning & Review Mechanism":',
                                controller:  dwsmProvider.observationCoordination,
                              ),


                              SizedBox(
                                height: 10,
                              ),


                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [


                                  SizedBox(
                                    height: 35,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10), // Adjust the radius as needed
                                        ),
                                      ),
                                      onPressed: () async {

                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  SourceSustainablitiyWasterConservation()),
                                        );
                                      },
                                      child: Text(
                                        "SKIP",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 35,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
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
                                            "Saving Coordination, Planning & Review Mechanism");
                                        await dwsmProvider
                                            .saveCoordinationPlanningReview(
                                            userId:
                                            localStorageService
                                                .getInt(
                                                AppConstants
                                                    .prefUserId)!,
                                            stateId: dwsmProvider.stateId!,
                                            districtId: dwsmProvider
                                                .districtId!,
                                            auditInternalObservation:dwsmProvider.auditInternalObservation.text,
                                            areMonthlyMeetingsHeld:
                                            dwsmProvider
                                                .selectedValueQ1Id,
                                            numberOfMeetingsLast6Months: int.tryParse(dwsmProvider.meetingsHeldController.text)!,
                                            qualityOfMeeting: dwsmProvider
                                                .selectedMeetingQualityID,
                                            areCoordinationMeetingsRegular:
                                            dwsmProvider.selectedDISHAID,
                                            modeType: modeType!.modeValue,
                                            observationCoordination: dwsmProvider.observationCoordination.text);

                                        if (dwsmProvider.status!) {
                                          ToastHelper.showToastMessage(
                                              dwsmProvider.message!,
                                              backgroundColor: Colors.green);
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    SourceSustainablitiyWasterConservation()),
                                          );
                                        } else {
                                          ToastHelper.showToastMessage(
                                              dwsmProvider.message!,
                                              backgroundColor: Colors.red);
                                        }
                                      },
                                      child: Text(
                                        "SAVE ",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              )



                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            })),
      ),
    );
  }
}
