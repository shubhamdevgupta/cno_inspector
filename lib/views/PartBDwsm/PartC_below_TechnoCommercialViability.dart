import 'package:cno_inspection/services/LocalStorageService.dart';
import 'package:cno_inspection/utils/AppConstants.dart';
import 'package:cno_inspection/views/PartBDwsm/PartEQualityAssuranceandCommissioning.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/AppStateProvider.dart';
import '../../provider/dwsmInfoProvider/DwsmProvider.dart';
import '../../utils/AppStyles.dart';
import '../../utils/LoaderUtils.dart';
import '../../utils/UserFeedback.dart';
import '../../utils/customtxtfeild.dart';
import '../../utils/toast_helper.dart';
import 'AboveDWSMCommonClass.dart';
import 'DashboardDWSM.dart';
import 'PartDOperationandMaintenance.dart';

class PartcBelowTechnocommercialviabilityP extends StatefulWidget {
  const PartcBelowTechnocommercialviabilityP({Key? key}) : super(key: key);

  @override
  _PartcBelowTechnocommercialviabilityP createState() =>
      _PartcBelowTechnocommercialviabilityP();
}

class _PartcBelowTechnocommercialviabilityP
    extends State<PartcBelowTechnocommercialviabilityP> {
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
        dwsmProvider.clearMonitoringFields();
        if (districtid != null) {
          dwsmProvider.setDistrictId(districtid);
        }
        if (stateId != null) {
          dwsmProvider.setStateId(stateId);
        }
         modeType = Provider.of<AppStateProvider>(context, listen: false).mode;

        dwsmProvider.fetchTecnoCommercial(
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
                "Techno-Commercial Viability",
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
              builder: (context, dwsmProvider, childe) {
                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 20, left: 6, right: 6, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Dwsmcommonclass(
                          no: 3,
                        ),
                        Card(
                          elevation: 5,
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.deepOrangeAccent, width: 1.4),
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
                                  //Below 10% scheme
                                  Column(
                                    children: [
                                      Customtxtfeild(
                                        label:
                                            "1. What will be the annual O&M cost of the scheme?",
                                        controller:
                                            dwsmProvider.onCostSchemeController,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Customtxtfeild(
                                        label:
                                            "2.	What shall be water user charges from the stakeholders?",
                                        controller: dwsmProvider
                                            .chargeStakeHolderController,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Customtxtfeild(
                                        label:
                                            "3. What is the State plan for meeting the remaining O&M expenses?",
                                        controller: dwsmProvider
                                            .remaningExpensesController,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Customtxtfeild(
                                        label:
                                            "4. Expected skilled manpower required for operations of the schemes?",
                                        controller: dwsmProvider
                                            .requiredOperationController,
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 10,
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
                                            backgroundColor: Colors.deepOrange,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  10), // Adjust the radius as needed
                                            ),
                                          ),
                                          onPressed: () async {

                                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => PartEQualityAssuranceCommissioning()),);
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
                                            backgroundColor: Colors.deepOrange,
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
                                                "Saving  Monitoring, Quality and Lab Infrastructure");

                                            await dwsmProvider.saveTecnoCommercialViabbility(
                                                userId:
                                                localStorageService.getInt(
                                                    AppConstants.prefUserId)!,
                                                stateId: dwsmProvider.stateId!,
                                                districtId:
                                                dwsmProvider.districtId!,
                                                requiredOperation: dwsmProvider
                                                    .requiredOperationController
                                                    .text,
                                                remaningExpenses: dwsmProvider
                                                    .remaningExpensesController
                                                    .text,
                                                chargeStakeHolder: dwsmProvider
                                                    .chargeStakeHolderController
                                                    .text,
                                                omCostScheme: dwsmProvider
                                                    .onCostSchemeController.text,
                                                modeType: modeType!.modeValue);
                                            if (dwsmProvider.status!) {
                                              ToastHelper.showToastMessage(
                                                  dwsmProvider.message!,
                                                  backgroundColor: Colors.green);
                                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => PartEQualityAssuranceCommissioning()),);
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

                                    ],
                                  )


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
