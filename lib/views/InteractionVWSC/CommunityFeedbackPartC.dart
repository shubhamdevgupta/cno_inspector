import 'package:cno_inspection/provider/vwscInfoProvider/VwscProvider.dart';
import 'package:cno_inspection/utils/customradiobttn.dart';
import 'package:cno_inspection/views/InteractionVWSC/WaterQualityPartD.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/vwscInfoProvider/VwscProvider.dart';
import '../../utils/AppStyles.dart';
import '../../utils/CommonScreen.dart';
import '../../utils/CustomCheckBoxQuestion.dart';
import '../../utils/CustomRadioQuestion.dart';
import '../../utils/LoaderUtils.dart';
import '../../utils/MultiSelectionlist.dart';
import '../../utils/customcheckquestion.dart';
import '../../utils/customtxtfeild.dart';
import '../../utils/toast_helper.dart';
import 'CommunityInvolvementPartB.dart';
import 'DashboardVWSC.dart';
import 'VWSCCommonClass.dart';

class CommunityFeedbackPartC extends StatefulWidget {
  @override
  State<CommunityFeedbackPartC> createState() => _CommunityFeedbackPartC();
}

class _CommunityFeedbackPartC extends State<CommunityFeedbackPartC> {
  TextEditingController othersComplaintController = TextEditingController();

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
                return Stack(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        child: Column(
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
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.deepOrangeAccent,
                                          width: 1.4),
                                      borderRadius: BorderRadius.circular(14),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Colors.black12.withOpacity(0.06),
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
                                            print('selected---- ${vwscProvider.selectedComplaintByCommunity} : ${vwscProvider.selectedComplaintByCommunityId}');
                                          },
                                        ),
                                        if (vwscProvider
                                                .selectedComplaintByCommunity ==
                                            "Yes") ...[
                                          CustomMultiSelectChipQuestion(
                                            question:
                                                "2. Type of complaint (select all that apply):",
                                            options: vwscProvider
                                                .typeOfComplaintMapOptions,
                                            selectedValues: vwscProvider
                                                .selectedTypeOfComplaint,
                                            onSelectionChanged: (val) {
                                              vwscProvider
                                                      .selectedTypeOfComplaint =
                                                  val;
                                              print(
                                                  'selected2--- ${vwscProvider.selectedTypeOfComplaint} : ${vwscProvider.selectedTypeOfComplaintIds}');
                                            },
                                          ),

                                          // Show text field if 'Others' is selected
                                          if (vwscProvider
                                              .selectedTypeOfComplaint
                                              .contains("Others"))
                                            Customtxtfeild(
                                              label:
                                                  "Please specify other complaints:",
                                              controller:
                                                  othersComplaintController,
                                              maxLines: 2,
                                            ),
                                        ],
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
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: SizedBox(
                                            height: 35,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.deepOrange,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10), // Adjust the radius as needed
                                                ),
                                              ),
                                              onPressed: () async {
                                                LoaderUtils.showLoadingWithMessage(
                                                    context,
                                                    isLoading: true,
                                                    message:
                                                        "Community feedback on quality of construction");

                                                await vwscProvider.saveCommunityFeedback(
                                                    userId: 34483,
                                                    stateId: 32,
                                                    villageId: 503655,
                                                    anyComplaintByCommunity:
                                                        vwscProvider
                                                            .selectedComplaintByCommunityId,
                                                    isComplaintAddressed:
                                                        vwscProvider
                                                            .selectedWhereComplaintAddressOptId,
                                                    complaintType: vwscProvider
                                                        .selectedTypeOfComplaintIds,
                                                    createdBy: 34483);
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
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      final villageId = args['villageId'] as int?;
      final stateId = args['stateId'] as int?;

      // You can now use them, or set them in your provider
      final vwscProvider = Provider.of<Vwscprovider>(context, listen: false);
      if (villageId != null) {
        vwscProvider.setVillageId(villageId);
      }
      if (stateId != null) {
        vwscProvider.setStateId(stateId);
      }
    }
  }
}
