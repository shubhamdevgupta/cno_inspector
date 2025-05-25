import 'package:cno_inspection/provider/vwscInfoProvider/VwscProvider.dart';
import 'package:cno_inspection/services/LocalStorageService.dart';
import 'package:cno_inspection/utils/AppConstants.dart';
import 'package:cno_inspection/utils/LoaderUtils.dart';
import 'package:cno_inspection/utils/customradiobttn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../utils/AppStyles.dart';
import '../../utils/CommonScreen.dart';
import '../../utils/CustomRadioQuestion.dart';
import '../../utils/customtxtfeild.dart';
import '../../utils/toast_helper.dart';
import 'DashboardVWSC.dart';
import 'GrievancePartE.dart';
import 'VWSCCommonClass.dart';

class WaterQualityPartD extends StatefulWidget {
  @override
  State<WaterQualityPartD> createState() => _WaterQualityPartD();
}

class _WaterQualityPartD extends State<WaterQualityPartD> {
LocalStorageService _localStorageService =LocalStorageService();

  @override
  Widget build(BuildContext context) {
    return Container(
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
            "Water Quality Monitoring",
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
        body: Consumer<Vwscprovider>(builder: (context,vwscProvider,child){
          return SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NewScreenPoints(
                    no: 4,
                  ),


                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      elevation: 5,
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.lightGreen, width: 1.4),
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
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Customradiobttn(
                                question: "1. Availability of FTK:",
                                options: vwscProvider.yesNoMap.keys.toList(),
                                selectedOption: vwscProvider.selectedFTKAvailability,
                                onChanged: (val) => vwscProvider.selectedFTKAvailability = val,
                              ),

                              Customradiobttn(
                                question: "2. Water testing using FTKs:",
                                options: vwscProvider.ftkTestingFrequencyMap.keys.toList(),
                                selectedOption: vwscProvider.selectedFTKTestingFrequency,
                                onChanged: (val) =>  vwscProvider.selectedFTKTestingFrequency = val,
                              ),

                              Customtxtfeild(
                                label: "3. Number of women trained in water testing through FTKs:",
                                controller: vwscProvider.womenTrainedController,
                                keyboardType: TextInputType.number,
                              ),

                              Customtxtfeild(
                                label: "4. Who is doing the water quality testing through FTKs:",
                                controller: vwscProvider.testerNameController,
                              ),

                              Customradiobttn(
                                question: "5. Disinfection/chlorination done:",
                                options: vwscProvider.yesNoMap.keys.toList(),
                                selectedOption: vwscProvider.selectedDisinfectionDone,
                                onChanged: (val) => vwscProvider.selectedDisinfectionDone = val,
                              ),

                              Customradiobttn(
                                question: "6. Free Residual Chlorine Level (FRC) at tail ends:",
                                options: vwscProvider.frcLevelMap.keys.toList(),
                                selectedOption: vwscProvider.selectedFRCLevel,
                                onChanged: (val) => vwscProvider.selectedFRCLevel = val,
                              ),

                              Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  height: 35,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.lightGreen,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                                      ),
                                    ),
                                    onPressed: () async{
                                       LoaderUtils.showLoadingWithMessage(context, isLoading: vwscProvider.isLoading,message: "Saving Water Quality Monitoring");

                                      await vwscProvider.saveWaterQualityMonitoring(userId:_localStorageService.getInt(AppConstants.prefUserId)!, stateId: vwscProvider.stateId!,
                                          villageId: vwscProvider.villageId!, isFtkAvailable: vwscProvider.selectedFTKAvailabilityId,
                                          ftkTestingPeriod: vwscProvider.selectedFTKTestingFrequencyId, numberWomenTrainedFtk: int.parse(vwscProvider.womenTrainedController.text),
                                          whoTestFtk: vwscProvider.testerNameController.text, isChlorinationDone: vwscProvider.selectedDisinfectionDoneId,
                                          frcAvailableAtEnd: vwscProvider.selectedFRCLevelId, createdBy: _localStorageService.getInt(AppConstants.prefUserId)!);
                                      if(vwscProvider.status!){
                                        ToastHelper.showToastMessage( vwscProvider.message!,backgroundColor: Colors.green);
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  GrievancePartE()),
                                        );
                                      }else{
                                        ToastHelper.showToastMessage( vwscProvider.message!,backgroundColor: Colors.red);
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
                          )
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        )
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

  Widget buildTextFormField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blueGrey),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Color(0xFFF5F7FA),
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
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
    WidgetsBinding.instance.addPostFrameCallback((_){
      final vwscProvider = Provider.of<Vwscprovider>(context, listen: false);
      if (villageId != null) {
        vwscProvider.setVillageId(villageId);
      }
      if (stateId != null) {
        vwscProvider.setStateId(stateId);
      }
    });

  }
}
}
