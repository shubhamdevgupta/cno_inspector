import 'package:cno_inspection/provider/vwscInfoProvider/VwscProvider.dart';
import 'package:cno_inspection/services/LocalStorageService.dart';
import 'package:cno_inspection/utils/LoaderUtils.dart';
import 'package:cno_inspection/utils/toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/AppConstants.dart';
import '../../utils/MultiSelectionlist.dart';
import '../../utils/customradiobttn.dart';
import '../../utils/customtxtfeild.dart';
import 'CommunityInvolvementPartB.dart';
import 'DashboardVWSC.dart';
import 'VWSCCommonClass.dart';

class PartaBelowWatersupply extends StatefulWidget {
  const PartaBelowWatersupply({Key? key}) : super(key: key);

  @override
  _PartaBelowWatersupply createState() => _PartaBelowWatersupply();
}

class _PartaBelowWatersupply extends State<PartaBelowWatersupply> {
  LocalStorageService _localStorageService = LocalStorageService();


  String? selectedOption1;
  String? selectedOption2;
  String? selectedOption3;
  String? selectedOption4;
  String? selectedOption5;
  String? selectedOption6;

  TextEditingController householdPercentageController = TextEditingController();
  TextEditingController reasonsController = TextEditingController();

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
        vwscProvider.clearValuesforqueA();
        if (villageId != null) {
          vwscProvider.setVillageId(villageId);
        }
        if (stateId != null) {
          vwscProvider.setStateId(stateId);
        }

        await vwscProvider.fetchWaterSupply(stateId.toString(), villageId.toString(), _localStorageService.getInt(AppConstants.prefUserId).toString());
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
                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 20, left: 6, right: 6, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Vwsccommonclass(
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

                                  // Question 1
                                  Customradiobttn(
                                    question: '1. Is there any piped water supply scheme in the village:',
                                    options: ['Yes', 'No'],
                                    selectedOption: selectedOption1,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedOption1 = value!;
                                      });
                                    },
                                    orientation: Axis.horizontal,
                                  ),

                                  // Question 2 - Part 1
                                  Customradiobttn(
                                    question: '2. What is the type of scheme presently commissioned:',
                                    options: [
                                      'JJM new',
                                      'JJM Retrofitted',
                                      'NRDWP',
                                      'State Scheme',
                                      'No scheme'
                                    ],
                                    selectedOption: selectedOption2,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedOption2 = value!;
                                      });
                                    },
                                    orientation: Axis.horizontal,
                                  ),

                                  // Question 2 - Part 2 (text field for households %)
                                  Customtxtfeild(
                                    label: 'If scheme is commissioned, how many households are being benefitted (%)',
                                    controller: householdPercentageController,
                                  ),

                                  // Question 3
                                  Customradiobttn(
                                    question: '3. What is the present status of water supply schemes:',
                                    options: [
                                      'Meeting daily needs throughout the year',
                                      'Meeting daily needs partly in the year',
                                      'Not able to meet daily needs'
                                    ],
                                    selectedOption: selectedOption3,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedOption3 = value!;
                                      });
                                    },
                                    orientation: Axis.vertical,
                                  ),

                                  // Question 4
                                  Customradiobttn(
                                    question: '4. Water supply frequency assured to villagers in the scheme:',
                                    options: [
                                      'Daily',
                                      'Once in two days',
                                      'Once in three days',
                                      'Irregular',
                                      'Not functional'
                                    ],
                                    selectedOption: selectedOption4,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedOption4 = value!;
                                      });
                                    },
                                    orientation: Axis.vertical,
                                  ),

                                  // Question 5 - Part 1
                                  Customradiobttn(
                                    question: '5. Whether remote/SC/ST/PVTG groups existing in command area of the scheme has been planned in scheme:',
                                    options: ['Yes', 'No'],
                                    selectedOption: selectedOption5,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedOption5 = value!;
                                      });
                                    },
                                    orientation: Axis.horizontal,
                                  ),

                                  // Question 5 - Part 2 (text field for reasons if no)
                                  Customtxtfeild(
                                    label: 'If no, please provide the reasons',
                                    controller: reasonsController,
                                  ),

                                  // Question 6
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

                                  setState(() {
                                    vwscProvider.selectedinstitutions = val;
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
                                            borderRadius: BorderRadius.circular(
                                                10), // Adjust the radius as needed
                                          ),
                                        ),
                                        onPressed: () async {
                                        /*  LoaderUtils.showLoadingWithMessage(context, isLoading: vwscProvider.isLoading, message: "Water Supply Functionality");


                                          await vwscProvider.saveVwscWaterSupply(
                                              userId: _localStorageService.getInt(
                                                  AppConstants.prefUserId)!,
                                              stateId: vwscProvider.stateId!,
                                              villageId: vwscProvider.villageId!,
                                              waterSupplyFrequency: vwscProvider
                                                  .selectedFTKTestingFrequencyId,
                                              adequateWaterToHH: vwscProvider
                                                  .selectedHouseholdWaterId,
                                              adequateWaterToRemote: vwscProvider
                                                  .selectedPvtgGroupsId,
                                              remoteReason: vwscProvider
                                                  .reasonRemoteGroupsController
                                                  .text,
                                              tailEndWaterReach:
                                              vwscProvider.selectedTailEndId,
                                              schemeOperationalStatus:
                                              vwscProvider
                                                  .selectedschemeStatusId,
                                              pwsReachInstitutions: vwscProvider
                                                  .selectedinstitutionsIds,
                                              createdBy:
                                              _localStorageService.getInt(
                                                  AppConstants.prefUserId)!);
                                          if (vwscProvider.status!) {
                                            ToastHelper.showToastMessage(
                                                vwscProvider.message!,
                                                backgroundColor: Colors.green);

                                            Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      CommunityInvolvementPartB()),
                                            );
                                          } else {
                                            ToastHelper.showToastMessage(
                                                vwscProvider.message!,
                                                backgroundColor: Colors.red);
                                          }*/
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
                              ,
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
