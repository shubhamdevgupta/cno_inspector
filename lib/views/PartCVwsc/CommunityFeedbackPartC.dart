import 'package:cno_inspection/provider/vwscInfoProvider/VwscProvider.dart';
import 'package:cno_inspection/utils/customradiobttn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/AppStateProvider.dart';
import '../../provider/vwscInfoProvider/VwscProvider.dart';
import '../../services/LocalStorageService.dart';
import '../../utils/AppConstants.dart';
import '../../utils/AppStyles.dart';
import '../../utils/CommonScreen.dart';
import '../../utils/CustomCheckBoxQuestion.dart';
import '../../utils/CustomRadioQuestion.dart';
import '../../utils/LoaderUtils.dart';
import '../../utils/MultiSelectionlist.dart';
import '../../utils/UserFeedback.dart';
import '../../utils/customcheckquestion.dart';
import '../../utils/customtxtfeild.dart';
import '../../utils/toast_helper.dart';
import 'BelowVWSCCommon.dart';
import 'CommunityInvolvementPartB.dart';
import 'DashboardVWSC.dart';
import 'AboveVWSCCommonClass.dart';
import 'WaterQualityPartD.dart';

class CommunityFeedbackPartC extends StatefulWidget {
  @override
  State<CommunityFeedbackPartC> createState() => _CommunityFeedbackPartC();
}

class _CommunityFeedbackPartC extends State<CommunityFeedbackPartC> {

  final LocalStorageService _localStorage = LocalStorageService();

  @override
  void initState() {
    super.initState();
    final  ModeType = Provider.of<AppStateProvider>(context, listen: false).mode;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;


      if (args != null) {
        final villageId = args['villageId'] as int?;
        final stateId = args['stateId'] as int?;

        // You can now use them, or set them in your provider

        final vwscProvider = Provider.of<Vwscprovider>(context, listen: false);
        vwscProvider.clearCommunityFeedback();
        if (villageId != null) {
          vwscProvider.setVillageId(villageId);
        }
        if (stateId != null) {
          vwscProvider.setStateId(stateId);
        }

        vwscProvider.fetchCommunityFeedback(
            stateId.toString(),
            villageId.toString(),
            _localStorage.getInt(AppConstants.prefUserId).toString(), ModeType!.modeValue);
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
              title: const Text(
                "Community feedback on quality of construction",
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
                return Stack(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Abovevwsccommonclass(no: 3),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 5,
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.deepOrangeAccent,
                                          width: 1.4),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Customradiobttn(
                                          question:
                                              "1. Any complaint by community on quality of construction:",
                                          options: vwscProvider
                                              .complainByCommunityOption,
                                          selectedOption: vwscProvider
                                              .selectedComplaintByCommunity,
                                          onChanged: (val) {
                                            vwscProvider
                                                    .selectedComplaintByCommunity =
                                                val;
                                            print(
                                                'selected---- ${vwscProvider.selectedComplaintByCommunity} : ${vwscProvider.selectedComplaintByCommunityId}');
                                          },
                                        ),

                                          CustomMultiSelectChipQuestion(
                                            question:
                                                "2 Type of complaint (select all that apply):",
                                            options: vwscProvider
                                                .typeOfComplaintMapOptions,
                                            selectedValues: vwscProvider
                                                .selectedTypeOfComplaint,
                                            onSelectionChanged: (val) {
                                              vwscProvider
                                                  .selectedTypeOfComplaint = val;
                                              print(
                                                  'selected2--- ${vwscProvider.selectedTypeOfComplaint} : ${vwscProvider.selectedTypeOfComplaintIds}');
                                            },
                                          ),

                                          // Show text field if 'Others' is selected
                                          if (vwscProvider.selectedTypeOfComplaint.contains("Others"))
                                            Customtxtfeild(
                                              label:
                                                  "Please specify other complaints:",
                                              controller: vwscProvider.othersComplaintController,
                                              maxLines: 2,
                                            ),

                                        Customradiobttn(
                                          question:
                                              "3. Whether complaint is addressed:",
                                          options: vwscProvider
                                              .whereComplaintAddressOpt,
                                          selectedOption: vwscProvider
                                              .selectedWhereComplaintAddress,
                                          onChanged: (val) {
                                            vwscProvider
                                                    .SetSelectedWhereComplaintAddress =
                                                val;
                                            print(
                                                'selected3------- ${vwscProvider.selectedWhereComplaintAddress} ; ${vwscProvider.selectedWhereComplaintAddressOptId}');
                                          },
                                        ),

                                        CustomObservationField(
                                          labelText: '* User Observation / Remarks:',
                                          controller:  vwscProvider.PartCVWSCuserObservationController,
                                        ),


                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            SizedBox(
                                              height: 35,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                  Colors.deepOrange,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(
                                                        10), // Adjust the radius as needed
                                                  ),
                                                ),
                                                onPressed: () async {

                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            WaterQualityPartD()),
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
                                                  backgroundColor:
                                                  Colors.deepOrange,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(
                                                        10), // Adjust the radius as needed
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  LoaderUtils.showLoadingWithMessage(context, isLoading: vwscProvider.isLoading, message: "Community feedback on quality of construction");

                                                  await vwscProvider.saveCommunityFeedback(
                                                    userId: _localStorage.getInt(AppConstants.prefUserId)!,
                                                    stateId: vwscProvider.stateId!,
                                                    villageId: vwscProvider.villageId!,
                                                    anyComplaintByCommunity: vwscProvider.selectedComplaintByCommunityId,
                                                    isComplaintAddressed: vwscProvider.selectedWhereComplaintAddressOptId,
                                                    complaintType: vwscProvider.selectedTypeOfComplaintIds,

                                                    typeComplaintOther: vwscProvider.othersComplaintController.text,
                                                    phyStatus:  mode.modeValue ,
                                                    observationCommunityFeedbackQualityConstruction: vwscProvider.PartCVWSCuserObservationController.text,
                                                    createdBy: _localStorage.getInt(AppConstants.prefUserId)!,
                                                  );

                                                  if (vwscProvider.status!) {
                                                    ToastHelper.showToastMessage(
                                                        vwscProvider.message!,
                                                        backgroundColor:
                                                        Colors.green);
                                                    Navigator.of(context)
                                                        .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              WaterQualityPartD()),
                                                    );
                                                  } else {
                                                    ToastHelper.showToastMessage(
                                                        vwscProvider.message!,
                                                        backgroundColor:
                                                        Colors.red);
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
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
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
