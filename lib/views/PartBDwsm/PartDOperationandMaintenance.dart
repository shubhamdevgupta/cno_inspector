import 'package:cno_inspection/services/LocalStorageService.dart';
import 'package:cno_inspection/utils/Utilityclass.dart';
import 'package:cno_inspection/utils/customradiobttn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/AppStateProvider.dart';
import '../../provider/dwsmInfoProvider/DwsmProvider.dart';
import '../../utils/AppConstants.dart';
import '../../utils/AppStyles.dart';
import '../../utils/LoaderUtils.dart';
import '../../utils/UserFeedback.dart';
import '../../utils/customtxtfeild.dart';
import '../../utils/toast_helper.dart';
import 'AboveDWSMCommonClass.dart';
import 'DashboardDWSM.dart';
import 'PartEQualityAssuranceandCommissioning.dart';

class PartDoperationandmaintenance extends StatefulWidget {
  const PartDoperationandmaintenance({Key? key}) : super(key: key);

  @override
  _PartDoperationandmaintenance createState() =>
      _PartDoperationandmaintenance();
}

class _PartDoperationandmaintenance
    extends State<PartDoperationandmaintenance> {
  LocalStorageService localStorageService = LocalStorageService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      final  modeType = Provider.of<AppStateProvider>(context, listen: false).mode;
      final args =
      ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      if (args != null) {
        final districtid = args['districtid'] as int?;
        final stateId = args['stateId'] as int?;
        final dwsmProvider = Provider.of<Dwsmprovider>(context, listen: false);
        if (districtid != null) {
          dwsmProvider.setDistrictId(districtid);
        }
        if (stateId != null) {
          dwsmProvider.setStateId(stateId);
        }


        dwsmProvider.fetchOperationMaintenanceData(stateId.toString(),districtid.toString(),localStorageService.getInt(AppConstants.prefUserId).toString(),modeType!.modeValue);
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
              "Operation & Maintenance (O&M)",
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
          body: Consumer<Dwsmprovider>(builder: (context,dwsmProvider,child){
            final  modeType = Provider.of<AppStateProvider>(context, listen: false).mode;
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                    top: 20, left: 6, right: 6, bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Dwsmcommonclass(
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
                          padding: EdgeInsets.all(5),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Column(
                            children: [
                              Customradiobttn(
                                question: "1. Is a protocol for handing over in-village infrastructure in place?",
                                options: dwsmProvider.handoverProtocolMap.keys.toList(),
                                selectedOption: dwsmProvider.handoverProtocol,
                                onChanged: (val) => dwsmProvider.handoverProtocol = val,
                              ),

                              const SizedBox(height: 10),

                              Customtxtfeild(
                                label: "1.1 Percentage of villages where trained multi-skilled manpower available for O&M",
                                controller: dwsmProvider.manpowerPercentController,
                                keyboardType: TextInputType.number,
                              ),

                              const SizedBox(height: 10),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("2. Is a Water charged from households?", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),),
                                  const SizedBox(height: 10),
                                  Customtxtfeild(
                                    label: "2.1. Water fee amount (₹/month or per connection)",
                                    controller: dwsmProvider.waterFeeController,
                                    keyboardType: TextInputType.number,
                                  ),
                                  const SizedBox(height: 10),
                                  Customradiobttn(
                                    question: "2.2 Is the fee uniform or based on consumption?",
                                    options: dwsmProvider.feeBasisMap.keys.toList(),
                                    selectedOption: dwsmProvider.feeBasis,
                                    onChanged: (val) => dwsmProvider.feeBasis = val,
                                  ),

                                ],
                              ),




                              Customtxtfeild(
                                label: "3. Percentage of villages where User Fee is being collected",
                                controller: dwsmProvider.userFeePercentController,
                                keyboardType: TextInputType.number,
                              ),

                            ],
                          ),



                              SizedBox(
                                height: 10,
                              ),


                              CustomObservationField(
                                labelText: '* Obseration on "Quality Assurance and Commissioning":',
                                controller:  dwsmProvider.observationOperationMaintencen,
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
                                        backgroundColor: Colors.lightGreen,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10), // Adjust the radius as needed
                                        ),
                                      ),
                                      onPressed: () async {

                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  PartEQualityAssuranceCommissioning()),
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

                                        LoaderUtils.showLoadingWithMessage(context,
                                            isLoading: dwsmProvider.isLoading,message: "Saving Operation & Maintenance (O&M)");

                                        await dwsmProvider.saveOperationMaintenance(userId: localStorageService.getInt(AppConstants.prefUserId)!, stateId: dwsmProvider.stateId!, districtId: dwsmProvider.districtId!,
                                        isProtocolInPlace: dwsmProvider.handoverProtocolID,
                                          percentVillagesWithManpower: Utilityclass.parseDoubleOrZero(dwsmProvider.manpowerPercentController.text),
                                          isWaterFeeCharged: -1, feeAmountPerMonth: Utilityclass.parseInt(dwsmProvider.waterFeeController.text),
                                            isUniformFee: dwsmProvider.feeBasisID,
                                            obserVationOperationMaintenance: dwsmProvider.observationOperationMaintencen.text,
                                        percentVillagesFeeCollected: Utilityclass.parseDoubleOrZero(dwsmProvider.userFeePercentController.text),modeType: modeType!.modeValue);
                                        if (dwsmProvider.status!) {
                                          ToastHelper.showToastMessage(
                                              dwsmProvider.message!,
                                              backgroundColor: Colors.green);
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    PartEQualityAssuranceCommissioning()),
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
                                ],
                              )


                            ],
                          )),
                    )
                  ],
                ),
              ),
            );
          },)
        ),
      ),
    );
  }
}
