import 'package:cno_inspection/views/PartASchemeInfo/Dashboardschemeinfo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/AppStateProvider.dart';
import '../../provider/schemeInfoProvider/SchemeProvider.dart';
import '../../services/LocalStorageService.dart';
import '../../utils/AppConstants.dart';
import '../../utils/AppStyles.dart';
import '../../utils/LoaderUtils.dart';
import '../../utils/MultiSelectionlist.dart';
import '../../utils/UserFeedback.dart';
import '../../utils/customradiobttn.dart';
import '../../utils/customtxtfeild.dart';
import '../../utils/toast_helper.dart';
import 'PartASchemeInfoUserobservation.dart';
import 'PartBSchemePlanningScreen.dart';
import 'PartEVisual Inspection.dart';
import 'SchemeInfoCommonScreen.dart';

class SchemeImplementationScreen extends StatefulWidget {
  const SchemeImplementationScreen({Key? key}) : super(key: key);

  @override
  _SchemeImplementationScreen createState() => _SchemeImplementationScreen();
}

class _SchemeImplementationScreen extends State<SchemeImplementationScreen> {
  LocalStorageService _localStorageService = LocalStorageService();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        final schemeId = args['schemeId'] as int?;
        final stateId = args['stateId'] as int?;

        final schemeProvider =
            Provider.of<Schemeprovider>(context, listen: false);
        schemeProvider.clearSchemeImplementationData();
        if (schemeId != null) {
          schemeProvider.setSchemeId(schemeId);
        }
        if (stateId != null) {
          schemeProvider.setStateId(stateId);
        }
      final  modeType = Provider.of<AppStateProvider>(context, listen: false).mode;

        schemeProvider.fetchSchemeImplementationData(
            stateId.toString(),
            schemeId.toString(),
            _localStorageService.getInt(AppConstants.prefUserId).toString(),modeType!.modeValue);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Replace the current route with a new one
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => Dashboardschemeinfo()),
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
              "Scheme implementation",
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
                    MaterialPageRoute(
                        builder: (context) => Dashboardschemeinfo()),
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
          body: Consumer<Schemeprovider>(
              builder: (context, schemeProvider, child) {
                final modeType = Provider.of<AppStateProvider>(context, listen: false).mode;
                return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                    top: 20, left: 6, right: 6, bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Schemeinfocommonscreen(
                      no: 4,
                    ),
                    Card(
                      elevation: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.lightGreen, width: 1.4),
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
            // Above 10 % Start
                            Visibility(
                                 visible: modeType==ProjectMode.above10,
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Q1: Reason(s) for delay
                                      CustomMultiSelectChipQuestion(
                                        question: '1. What are the reason(s) for delay after award of work Please select that are relatable:',
                                        options: schemeProvider.delayReasonsOptions,
                                        selectedValues: schemeProvider.selectedDelayReasons,
                                        onSelectionChanged: (val) {
                                          schemeProvider.selectedDelayReasons = val;
                                          print('SelecteddelayReasons: ${schemeProvider.selectedDelayReasons} : ${schemeProvider.selectedDelayReasonsID}');
                                        },
                                      ),

                                       // Show text field if 'Others' is selected
                                      if (schemeProvider.selectedDelayReasons.contains("Others"))
                                        Customtxtfeild(
                                          label: "In Case of Other please provide details:",
                                          controller: schemeProvider.PartDQ1othersComplaintController,
                                          maxLines: 2,
                                        ),

                                      const SizedBox(height: 10),

                                      // Q2: Cost overrun
                                      Customradiobttn(
                                        question: '2. Cost overrun:',
                                        options:
                                        schemeProvider.costOverrun.keys.toList(),
                                        selectedOption:
                                        schemeProvider.selectedCostOverrun,
                                        onChanged: (value) {
                                          schemeProvider.selectedCostOverrun = value;
                                          print(
                                              'selectedCostOverrunID: ${schemeProvider.selectedCostOverrunID} }');
                                        },
                                      ),

                                      // Q3: Reason(s) for cost overrun
                                      CustomMultiSelectChipQuestion(
                                        question: '3. Reason(s) for cost overrun:',
                                        options: schemeProvider.ReasonsOptionsOptions,
                                        selectedValues: schemeProvider.selectedcostOverrunReasons,
                                        onSelectionChanged: (values) {
                                          schemeProvider.selectedcostOverrunReasons =
                                              values;
                                          print(
                                              'selectedcostOverrunReasons:  ${schemeProvider.selectedcostOverrunReasonsID}');
                                        },
                                      ),


                                      // Show text field if 'Others' is selected
                                      if (schemeProvider.selectedcostOverrunReasons.contains("Others"))
                                        Customtxtfeild(
                                          label: "In Case of Other please provide details:",
                                          controller: schemeProvider.PartDQ3othersComplaintController,
                                          maxLines: 2,
                                        ),



                                      // Q4: Revised cost approval
                                      Customradiobttn(
                                        question:
                                        '4. Has the scheme approved cost been revised before award of work:',
                                        options:
                                        schemeProvider.yesNoMap.keys.toList(),
                                        selectedOption: schemeProvider
                                            .selectedrevisedCostApproved,
                                        onChanged: (value) {
                                          schemeProvider.selectedrevisedCostApproved =
                                              value;

                                          print('selectedrevisedCostApproved:  ${schemeProvider.selectedrevisedCostApprovedID}');
                                        },
                                      ),
                                      const SizedBox(height: 10),

                                      // Q5: Revised cost by SLSSC
                                      Customradiobttn(
                                        question:
                                        "5. Whether revised cost has been approved by SLSSC?",
                                        options:
                                        schemeProvider.yesNoMap.keys.toList(),
                                        selectedOption:
                                        schemeProvider.getSelectedPartE5,
                                        onChanged: (val) {
                                          schemeProvider.setQuesPartE5 = val;
                                        },
                                      ),

                                      Visibility(
                                        visible: schemeProvider.selectedId_partE5==1,

                                        child: Column(
                                          children: [
                                            Customradiobttn(
                                              question: '5.1 If yes, increase in cost:',
                                              options: schemeProvider.increaseInCostID.keys
                                                  .toList(),
                                              selectedOption:
                                              schemeProvider.selectedincreaseInCost,
                                              onChanged: (value) {
                                                schemeProvider.selectedincreaseInCost = value;

                                                print(
                                                    'selectedincreaseInCost:  ${schemeProvider.selectedincreaseInCostID}');
                                              },
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                DateTime? pickedDate = await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime(2100),
                                                );

                                                if (pickedDate != null) {
                                                  // Format the picked date as "dd-mm-yyyy"
                                                  String formattedDate =
                                                      "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
                                                  schemeProvider.dateApproval =
                                                      formattedDate;
                                                }
                                              },
                                              child: AbsorbPointer(
                                                // Prevents typing
                                                child: Customtxtfeild(
                                                  label:
                                                  '5.2 Date of SLSSC approval in seriatim for revised estimate?',
                                                  controller: TextEditingController(
                                                      text: schemeProvider.dateApproval ??
                                                          ''),
                                                  keyboardType: TextInputType.datetime,
                                                  hintText: 'dd-mm-yyyy',
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),

                                      CustomMultiSelectChipQuestion(
                                        question: '6. Reason(s) for revision:',
                                        options:
                                        schemeProvider.revisionReasonsIDOptions,
                                        selectedValues:
                                        schemeProvider.selectedrevisionReasons,
                                        onSelectionChanged: (values) {
                                          setState(() => schemeProvider
                                              .selectedrevisionReasons = values);
                                          print(
                                              ' schemeProvider.selectedrevisionReasons  ${schemeProvider.selectedrevisionReasonsID}');
                                        },
                                      ),

                                      if (schemeProvider.selectedrevisionReasons.contains("Others"))
                                        Customtxtfeild(
                                          label: '6.1 Reason',
                                          controller:
                                          schemeProvider.PartDQ4reasonController,
                                          keyboardType: TextInputType.text,
                                        ),


                                      const SizedBox(height: 10),
                                      const Text(
                                        '7. What is the admissible cost of the components (CAPEX) in the scheme?',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(height: 6),

                                      _buildAdmissibleCostTable(
                                          context, schemeProvider,modeType),

                                      const SizedBox(height: 20),
                                      const Text(
                                        '8. Components of scheme planned or mapped on the PM-Gati Shakti?',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(height: 6),

                                      Customradiobttn(
                                        question: '8.1 WTP',
                                        options:
                                        schemeProvider.yesNoMap.keys.toList(),
                                        selectedOption: schemeProvider.selectedWTP,
                                        onChanged: (value) {
                                          schemeProvider.selectedWTP = value;

                                          print(
                                              'selectedWTPID:  ${schemeProvider.selectedWTPID}');
                                        },
                                      ),
                                      Customradiobttn(
                                        question: '8.2 OHSR/GSR/OHT/ESR/MBR',
                                        options:
                                        schemeProvider.yesNoMap.keys.toList(),
                                        selectedOption: schemeProvider.selectedOHSR,
                                        onChanged: (value) {
                                          schemeProvider.selectedOHSR = value;

                                          print(
                                              'selectedOHSR:  ${schemeProvider.selectedOHSRID}');
                                        },
                                      ),
                                      Customradiobttn(
                                        question: '8.3 Source',
                                        options:
                                        schemeProvider.yesNoMap.keys.toList(),
                                        selectedOption: schemeProvider.selecteSource,
                                        onChanged: (value) {
                                          schemeProvider.selecteSource = value;

                                          print(
                                              'selecteSource:  ${schemeProvider.selecteSourceID}');
                                        },
                                      ),
                                      Customradiobttn(
                                        question: '8.4 Pipeline',
                                        options:
                                        schemeProvider.yesNoMap.keys.toList(),
                                        selectedOption:
                                        schemeProvider.selectedPipeline,
                                        onChanged: (value) {
                                          schemeProvider.selectedPipeline = value;

                                          print(
                                              'selectedPipeline:  ${schemeProvider.selectedPipelineID}');
                                        },
                                      ),
                                    ]
                                )),
            // Above 10% End
                            // Below 10 % Start
                            Visibility(
                                visible: modeType==ProjectMode.below10,
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomMultiSelectChipQuestion(
                                        question: '1. What are the reason(s) for delay after award of work Please select that are relatable:',
                                        options: schemeProvider.belowdelayReasonsOptions,
                                        selectedValues: schemeProvider.belowselectedDelayReasons,
                                        onSelectionChanged: (val) {
                                          schemeProvider.belowselectedDelayReasons = val;
                                          print('belowselectedDelayReasonsID: ${schemeProvider.selectedDelayReasons} : ${schemeProvider.belowselectedDelayReasonsID}');
                                        },
                                      ),

                                      // Show text field if 'Others' is selected
                                      if (schemeProvider.belowselectedDelayReasons.contains("Others"))
                                        Customtxtfeild(
                                          label: "In case of Other, please provide details:",
                                          controller: schemeProvider.PartDQ1othersComplaintController,
                                          maxLines: 2,
                                        ),
                                      const SizedBox(height: 10),

                                      // Q4: Revised cost approval
                                      Customradiobttn(
                                        question:
                                        '2. Has the scheme approved cost been revised before award of work:',
                                        options:
                                        schemeProvider.yesNoMap.keys.toList(),
                                        selectedOption: schemeProvider
                                            .selectedrevisedCostApproved,
                                        onChanged: (value) {
                                          schemeProvider.selectedrevisedCostApproved =
                                              value;

                                          print(
                                              'selectedrevisedCostApproved:  ${schemeProvider.selectedrevisedCostApprovedID}');
                                        },
                                      ),


                                      Customradiobttn(
                                        question:
                                        "3. Whether revised cost has been approved by SLSSC?",
                                        options:
                                        schemeProvider.yesNoMap.keys.toList(),
                                        selectedOption:
                                        schemeProvider.getSelectedPartE5,
                                        onChanged: (val) {
                                          schemeProvider.setQuesPartE5 = val;
                                        },
                                      ),

                                      SizedBox(
                                        height: 10,
                                      ),


                                      Visibility(
                                        visible: schemeProvider.selectedId_partE5==1,
                                        child: Column(
                                          children: [

                                            Customradiobttn(
                                            question: '3.1 If yes, increase in cost:',
                                            options: schemeProvider.increaseInCostID.keys
                                                .toList(),
                                            selectedOption:
                                            schemeProvider.selectslsscapp,
                                            onChanged: (value) {
                                              schemeProvider.selectslsscapp =
                                                  value;

                                              print('selectslsscappID:  ${schemeProvider.selectslsscappID}');
                                            },
                                          ),

                                            GestureDetector(
                                              onTap: () async {
                                                DateTime? pickedDate = await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime(2100),
                                                );

                                                if (pickedDate != null) {
                                                  // Format the picked date as "dd-mm-yyyy"
                                                  String formattedDate =
                                                      "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
                                                  schemeProvider.dateApproval =
                                                      formattedDate;
                                                }
                                              },
                                              child: AbsorbPointer(
                                                // Prevents typing
                                                child: Customtxtfeild(
                                                  label:
                                                  '3.2 Date of SLSSC approval in seriatim for revised estimate?',
                                                  controller: TextEditingController(
                                                      text: schemeProvider.dateApproval ??
                                                          ''),
                                                  keyboardType: TextInputType.datetime,
                                                  hintText: 'dd-mm-yyyy',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      CustomMultiSelectChipQuestion(
                                        question: '4. Reason(s) for revision:',
                                        options: schemeProvider.revisionReasonsIDOptions,
                                        selectedValues: schemeProvider.selectedrevisionReasons,
                                        onSelectionChanged: (values) {
                                          setState(() => schemeProvider
                                              .selectedrevisionReasons = values);
                                          print(
                                              ' schemeProvider.selectedrevisionReasons  ${schemeProvider.selectedrevisionReasonsID}');
                                        },
                                      ),

                                      if (schemeProvider.selectedrevisionReasons.contains("Others"))
                                        Customtxtfeild(
                                          label: '4.1 Reason',
                                          controller:
                                          schemeProvider.PartDQ4reasonController,
                                          keyboardType: TextInputType.text,
                                        ),

                                      const SizedBox(height: 10),
                                      const Text(
                                        '5. What is the admissible cost of the components (CAPEX) in the scheme?',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),


                                      const SizedBox(height: 6),

                                      _buildAdmissibleCostTable(
                                          context, schemeProvider,modeType),

                                      const SizedBox(height: 20),


                                      Customradiobttn(
                                        question:
                                        "6. Is TPIA engaged for this scheme?",
                                        options:
                                        schemeProvider.yesNoMap.keys.toList(),
                                        selectedOption:
                                        schemeProvider.getSelectedPartE6,
                                        onChanged: (val) {
                                          schemeProvider.setQuesPartE5 = val;
                                        },
                                      ),



                                      Customradiobttn(
                                        question:
                                        "7.	Is concurrent supervision in the scope of TPIA? ",
                                        options:
                                        schemeProvider.yesNoMap.keys.toList(),
                                        selectedOption:
                                        schemeProvider.getSelectedPartE7,
                                        onChanged: (val) {
                                          schemeProvider.setQuesPartE7 = val;
                                        },
                                      ),

                                      const SizedBox(height: 8),
                                      Customtxtfeild(
                                        label: '8. What is the status of Water supply in the villages which are covered under this scheme?',
                                        controller: schemeProvider.below10PartD_ques8_Controller,
                                        keyboardType: TextInputType.text,
                                      ),
                                    ]
                                )
                            ),

                            SizedBox(height: 10,),

                            CustomObservationField(
                              labelText: '* Obseration on "Scheme implementation" :',
                              controller:  schemeProvider.PartDUserObservation,
                            ),

                            const SizedBox(height: 20),


                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 35,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.lightGreen,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10), // Adjust the radius as needed
                                      ),
                                    ),
                                    onPressed: () async {
                                      modeType == ProjectMode.below10?

                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                Partaschemeinfouserobservation()),
                                      ):   Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                VisualInspectionScreen()),
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
                                      backgroundColor: Colors.lightGreen,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10), // Adjust the radius as needed
                                      ),
                                    ),
                                    onPressed: () async {
                                      LoaderUtils.showLoadingWithMessage(
                                          context,
                                          isLoading: schemeProvider.isLoading,
                                          message:
                                          "Saving Scheme implementation...");

                                      await schemeProvider.saveSchemeImplementation(
                                        userId: _localStorageService.getInt(AppConstants.prefUserId) ?? 0,
                                        stateId: schemeProvider.stateId ?? 0,
                                        schemeId: schemeProvider.schemeId ?? 0,
                                        costOverrun: schemeProvider.selectedCostOverrunID,
                                        costRevisedBeforeWork: schemeProvider.selectedrevisedCostApprovedID ,
                                        revisedCostPercentage: schemeProvider.selectedincreaseInCostID ,
                                        slsscDate: schemeProvider.dateApproval ?? '',
                                        intakeTubeWellNum: schemeProvider.intakeTubeWellNum ?? 0,
                                        intakeTubeWellCost: double.tryParse(schemeProvider.costControllers['Intake/Tubewell']?.text ?? '') ?? 0.0,
                                        electroMechanicalNum: schemeProvider.electroMechanicalNum ?? 0,
                                        electroMechanicalCost: double.tryParse(schemeProvider.costControllers['Electromechanical components']?.text ?? '') ?? 0.0,
                                        wtpNum: 1,
                                        wtpCost: double.tryParse(schemeProvider.costControllers['WTP']?.text ?? '') ?? 0.0,
                                        mbrNum: 2,
                                        mbrCost: double.tryParse(schemeProvider.costControllers['MBR']?.text ?? '') ?? 0.0,
                                        transmissionPipelineNum: 3,
                                        transmissionPipelineCost: double.tryParse(schemeProvider.costControllers['Transmission pipeline']?.text ?? '') ?? 0.0,
                                        distributionPipelineNum: 4,
                                        distributionPipelineCost: double.tryParse(schemeProvider.costControllers['Distribution pipeline']?.text ?? '') ?? 0.0,
                                        disinfectionUnitNum: 5,
                                        disinfectionUnitCost: double.tryParse(schemeProvider.costControllers['OHSR/ESR/OHT/GSR']?.text ?? '') ?? 0.0,
                                        ohtNum: 6,
                                        ohtCost: double.tryParse(schemeProvider.costControllers['Disinfection unit']?.text ?? '') ?? 0.0,
                                        iotNum: 7,
                                        iotCost: double.tryParse(schemeProvider.costControllers['IoT/SCADA']?.text ?? '') ?? 0.0,
                                        roadRestorationNum: 8,
                                        roadRestorationCost: double.tryParse(schemeProvider.costControllers['Road Restoration']?.text ?? '') ?? 0.0,
                                        solarComponentNum: 9,
                                        solarComponentCost: double.tryParse(schemeProvider.costControllers['Solar components']?.text ?? '') ?? 0.0,
                                        otherComponentsNum: 10,
                                        otherComponentsCost: double.tryParse(schemeProvider.costControllers['Others (DG sets, HH storage)']?.text ?? '') ?? 0.0,
                                        plannedPTGatiShaktiWTP: schemeProvider.selectedWTPID,
                                        plannedPTGatiShaktiOHT: schemeProvider.selectedOHSRID,
                                        plannedPTGatiShaktiSource: schemeProvider.selecteSourceID,
                                        plannedPTGatiShaktiPipeline: schemeProvider.selectedPipelineID,
                                        delayReasons: modeType == ProjectMode.below10
                                            ? schemeProvider.belowselectedDelayReasonsID
                                            : schemeProvider.selectedDelayReasonsID,
                                        costOverrunReasons: schemeProvider.selectedcostOverrunReasonsID,
                                        costRevisionReasons: schemeProvider.selectedrevisionReasonsID,
                                        txtcost_levelzed_cost_cr: 0.00,
                                        is_tpia_engaged_value: schemeProvider.selectedId_partE5,
                                        concurrent_supervission_scope_value: schemeProvider.selectedId_partE7,
                                        txtpws_status_under_scheme: schemeProvider.below10PartD_ques8_Controller.text.trim().isEmpty
                                            ? ''
                                            : schemeProvider.below10PartD_ques8_Controller.text.trim(),
                                        phy_status: modeType.modeValue,
                                        user_remark: schemeProvider.PartDUserObservation.text.trim().isEmpty
                                            ? ''
                                            : schemeProvider.PartDUserObservation.text.trim(),
                                        Resion_for_delay_after_aword_other: schemeProvider.PartDQ1othersComplaintController.text.trim().isEmpty
                                            ? ''
                                            : schemeProvider.PartDQ1othersComplaintController.text.trim(),
                                        Reason_for_revision: schemeProvider.PartDQ4reasonController.text.trim().isEmpty
                                            ? ''
                                            : schemeProvider.PartDQ4reasonController.text.trim(),
                                        Reason_for_cost_overrun: schemeProvider.PartDQ3othersComplaintController.text.trim().isEmpty
                                            ? ''
                                            : schemeProvider.PartDQ3othersComplaintController.text.trim(),
                                      );


                                      if (schemeProvider.status!) {
                                        ToastHelper.showToastMessage(
                                            schemeProvider.message!,
                                            backgroundColor: Colors.green);

                                        if(modeType == ProjectMode.below10){
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    Partaschemeinfouserobservation()),
                                          );

                                        }
                                        else
                                          {
                                            Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      VisualInspectionScreen()),
                                            );
                                          }


                                      } else {
                                        ToastHelper.showToastMessage(
                                            schemeProvider.message!,
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
                            ),


                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildAdmissibleCostTable(
      BuildContext context, Schemeprovider schemeProvider, ProjectMode? modeType) {
    final columns = ['Components', 'Unit', 'Capacity', 'Cost (in cr.)'];

    final rows = [
      ['Intake/Tubewell', 'Nos.', 'In LPM', ''],
      ['Electromechanical components', 'Nos.', 'Head and discharge', ''],
      ['WTP', 'Nos.', 'In KLD', ''],
      ['MBR', 'Nos.', 'In KL', ''],
      ['Transmission pipeline', 'Dia of pipe', 'Length in Kms', ''],
      ['Distribution pipeline', 'Dia of pipe', 'Length in Kms', ''],
      ['OHSR/ESR/OHT/GSR', 'Nos.', 'In KL', ''],
      ['Disinfection unit', 'Nos.', 'In KLD', ''],
      ['IoT/SCADA', 'Nos.', '-', ''],
      ['Road Restoration', 'Nos.', 'Length in Kms', ''],
      ['Solar components', 'Nos.', '-', ''],
      ['Others (DG sets, HH storage)', 'Nos.', '-', ''],
      if (modeType == ProjectMode.below10)
        ['Levelized cost per FHTC (considering conjunctive scheme, if any)', '-', '-', ''],
    ];

    return Table(
      border: TableBorder.all(color: Colors.grey),
      columnWidths: const {
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(3),
        3: FlexColumnWidth(2),
      },
      children: [
        // Header row
        TableRow(
          decoration: BoxDecoration(color: Colors.grey[300]),
          children: columns
              .map((col) => Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              col,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ))
              .toList(),
        ),
        // Data rows
        ...rows.map((row) {
          final component = row[0];

          // Ensure row has exactly 4 items
          final safeRow = List<String>.from(row);
          while (safeRow.length < 4) {
            safeRow.add('');
          }

          return TableRow(
            children: safeRow.map((cell) {
              if (cell == '') {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    controller: schemeProvider.costControllers[component],
                    keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (val) {
                      print("Component: $component, Value: $val");
                    },
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(cell),
                );
              }
            }).toList(),
          );
        }),
      ],
    );
  }

}
