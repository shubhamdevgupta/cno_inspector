import 'package:cno_inspection/provider/vwscInfoProvider/VwscProvider.dart';
import 'package:cno_inspection/services/LocalStorageService.dart';
import 'package:cno_inspection/utils/LoaderUtils.dart';
import 'package:cno_inspection/utils/toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/AppStateProvider.dart';
import '../../utils/AppConstants.dart';
import '../../utils/MultiSelectionlist.dart';
import '../../utils/UserFeedback.dart';
import '../../utils/customradiobttn.dart';
import '../../utils/customtxtfeild.dart';
import 'CommunityInvolvementPartB.dart';
import 'DashboardVWSC.dart';
import 'AboveVWSCCommonClass.dart';

class WaterSupplyPartA extends StatefulWidget {
  const WaterSupplyPartA({Key? key}) : super(key: key);

  @override
  _WaterSupplyPartA createState() => _WaterSupplyPartA();
}

class _WaterSupplyPartA extends State<WaterSupplyPartA> {
  LocalStorageService _localStorageService = LocalStorageService();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final  ModeType = Provider.of<AppStateProvider>(context, listen: false).mode;

      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      if (args != null) {
        final villageId = args['villageId'] as int?;
        final stateId = args['stateId'] as int?;

        final vwscProvider = Provider.of<Vwscprovider>(context, listen: false);
        vwscProvider.clearValuesforqueA();
        if (villageId != null) {
          vwscProvider.setVillageId(villageId);
        }
        if (stateId != null) {
          vwscProvider.setStateId(stateId);
        }
        await vwscProvider.fetchWaterSupply(stateId.toString(), villageId.toString(), _localStorageService.getInt(AppConstants.prefUserId).toString(),ModeType!.modeValue );
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
                "Water Supply Functionality",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
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

                final  mode = Provider.of<AppStateProvider>(context, listen: false).mode;
                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 20, left: 6, right: 6, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Abovevwsccommonclass(
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
                            padding: EdgeInsets.all(8),
                            width: double.infinity,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Customradiobttn(
                                    question: "1. Water supply frequency:",
                                    options: vwscProvider.FrequencyLabelOption,
                                    selectedOption:
                                        vwscProvider.selectedFrequency,
                                    onChanged: (val) {
                                      vwscProvider.selectedFrequency = val;
                                      print(
                                          '-------selectedFrequencyID ${vwscProvider.selectedFrequencyID}');
                                    },
                                  ),
                                  Customradiobttn(
                                    question:
                                        "2. Is adequate water quantity reaching all the households?",
                                    options: vwscProvider.yesNoOptions,
                                    selectedOption:
                                        vwscProvider.selectedHouseholdWater,
                                    onChanged: (val) {
                                      vwscProvider.selectedHouseholdWater = val;
                                      print(
                                          'selectedHouseholdWater------- ${vwscProvider.selectedHouseholdWaterId}');
                                    },
                                  ),
                                  Customradiobttn(
                                    question:
                                        "3. Is adequate water quantity reaching to remote/SC/ST/PVTG groups?",
                                    options: vwscProvider.yesNoOptions,
                                    selectedOption:
                                        vwscProvider.selectedPvtgGroups,
                                    onChanged: (val) {
                                      vwscProvider.selectedPvtgGroups = val;
                                      print(
                                          'selectedPvtgGroups------- ${vwscProvider.selectedPvtgGroupsId}');
                                    },
                                  ),
                                  if (vwscProvider.selectedPvtgGroups == "No")
                                    Customtxtfeild(
                                      label: "If no, please provide the reasons",
                                      controller: vwscProvider
                                          .reasonRemoteGroupsController,
                                    ),
                                  Customradiobttn(
                                    question:
                                        "4. Whether water reaches tail-end households:",
                                    options: vwscProvider.tailEndOptions,
                                    selectedOption: vwscProvider.selectedTailEnd,
                                    onChanged: (val) {
                                      vwscProvider.selectedTailEnd = val;
                                      print(
                                          'selectedTailEnd------- ${vwscProvider.selectedTailEndId}');
                                    },
                                  ),
                                  Customradiobttn(
                                      question:
                                          "5. Scheme operational status since commissioning:",
                                      options: vwscProvider.schemeStatusOptions,
                                      selectedOption:
                                          vwscProvider.selectedschemeStatus,
                                      onChanged: (val) {
                                        vwscProvider.selectedschemeStatus = val;
                                        print(
                                            'selectedTailEnd------- ${vwscProvider.selectedschemeStatusId}');
                                      }),
                                  CustomMultiSelectChipQuestion(
                                    question:
                                        "6. Whether piped water supply services available at institutions:",
                                    options: vwscProvider.institutionsOptions,
                                    selectedValues:
                                        vwscProvider.selectedinstitutions,
                                    onSelectionChanged: (val) {
                                      vwscProvider.selectedinstitutions = val;
                                      print(
                                          'selectedinstitutionsselectedinstitutions------- ${vwscProvider.selectedinstitutions}');


                                    },
                                  ),


                                  CustomObservationField(
                                    labelText: '* User Observation / Remarks:',
                                    controller:  vwscProvider.PartAVWSCuserObservationController,
                                  ),


                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      SizedBox(
                                        height: 35,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xffb0D6EFD),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  10), // Adjust the radius as needed
                                            ),
                                          ),
                                          onPressed: () async {
                                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => CommunityInvolvementPartB()),);

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
                                            backgroundColor: Color(0xffb0D6EFD),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  10), // Adjust the radius as needed
                                            ),
                                          ),
                                          onPressed: () async {
                                            LoaderUtils.showLoadingWithMessage(context, isLoading: vwscProvider.isLoading, message: "Water Supply Functionality");


                                            await vwscProvider.saveVwscWaterSupply(
                                              userId: _localStorageService.getInt(AppConstants.prefUserId)!,
                                              stateId: vwscProvider.stateId!,
                                              villageId: vwscProvider.villageId!,
                                              waterSupplyFrequency: vwscProvider.selectedFTKTestingFrequencyId,
                                              adequateWaterToHH: vwscProvider.selectedHouseholdWaterId,
                                              adequateWaterToRemote: vwscProvider.selectedPvtgGroupsId,
                                              remoteReason: vwscProvider.reasonRemoteGroupsController.text,
                                              tailEndWaterReach: vwscProvider.selectedTailEndId,
                                              schemeOperationalStatus: vwscProvider.selectedschemeStatusId,
                                              pwsReachInstitutions: vwscProvider.selectedinstitutionsIds,


                                              // New parameters
                                              phyStatus: mode.modeValue ,
                                              isPipedWaterSupplyScheme:-1,
                                              typeOfSchemeCommissioned: 0,
                                              schemeBeneficiaryHouseholds:"",
                                              presentStatusOfWaterSupplySchemes: 0,
                                              waterSupplyFrequencyAssured: 0,
                                              remoteGroupsPlanned: -1,
                                              remoteGroupsPlannedDetails: "",
                                              //TODO feedback
                                              observationWaterSupplyFunctionality: vwscProvider.PartAVWSCuserObservationController.text,



                                            );
                                            if (vwscProvider.status!) {ToastHelper.showToastMessage(vwscProvider.message!, backgroundColor: Colors.green);
                                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => CommunityInvolvementPartB()),);
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
                                    ],
                                  )


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
}
