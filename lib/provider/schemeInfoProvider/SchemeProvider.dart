import 'package:cno_inspection/repository/schemeInfoRepo/SchemeRepository.dart';
import 'package:flutter/cupertino.dart';

import '../../model/schemePartA/AdditionalInfoRetrofitResponsePartC.dart';
import '../../model/schemePartA/SchemeImplementationModelPartD.dart';
import '../../model/schemePartA/SchemePlanningResponsePartB.dart';
import '../../model/schemePartA/SchemeVisualInspectionModelPartE.dart';
import '../../model/schemePartA/SourceSurveyResponsePartA.dart';
import '../../repository/schemeInfoRepo/fetchSchemeRepo.dart';
import '../../utils/GlobalExceptionHandler.dart';
import '../../views/tabLayout/DashboardTabView.dart';

class Schemeprovider extends ChangeNotifier {
  final SchemeRepositoy _schemeRepositoy = SchemeRepositoy();
  final Fetchschemeinfo _fetchschemeinfo = Fetchschemeinfo();

  String errorMsg = '';


  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _message;

  String? get message => _message;

  bool? _status;

  bool? get status => _status;

  final Map<String, int> yesNoMap = {
    "Yes": 1,
    "No": 2,
  };

  // Private variables to hold selected values
  String? _selectedValueQ1;
  String? _selectedValueQ2;
  String? _selectedValueQ3;

  // Getter for Q1
  String? get selectedValueQ1 => _selectedValueQ1;

  // Setter for Q1
  set selectedValueQ1(String? value) {
    _selectedValueQ1 = value;
    notifyListeners();
  }

  // Getter for Q2
  String? get selectedValueQ2 => _selectedValueQ2;

  // Setter for Q2
  set selectedValueQ2(String? value) {
    _selectedValueQ2 = value;
    notifyListeners();
  }

  // Getter for Q3
  String? get selectedValueQ3 => _selectedValueQ3;

  // Setter for Q2
  set selectedValueQ3(String? value) {
    _selectedValueQ3 = value;
    notifyListeners();
  }

  int get selectedValueQ3Id => yesNoMap[_selectedValueQ3] ?? 0;

  int get selectedValueQ2Id => yesNoMap[_selectedValueQ2] ?? 0;

  int get selectedValueQ1Id => yesNoMap[_selectedValueQ1] ?? 0;

  final TextEditingController safeController = TextEditingController();
  final TextEditingController criticalController = TextEditingController();
  final TextEditingController semiCriticalController = TextEditingController();
  final TextEditingController waterAllocationController =
      TextEditingController();

  int? _schemeId;

  int? get schemeId => _schemeId;

  void setSchemeId(int id) {
    _schemeId = id;
    notifyListeners();
  }

  int? _stateId;

  int? get stateId => _stateId;

  void setStateId(int id) {
    _stateId = id;
    notifyListeners();
  }

  String getRadiobuttonData(int id, Map<String, int> labelMap) {
    return labelMap.entries
        .firstWhere((entry) => entry.value == id,
            orElse: () => const MapEntry('', 0))
        .key;
  }

  List<String> getCheckBoxData(List<int> ids, Map<String, int> labelMap) {
    return labelMap.entries
        .where((entry) => ids.contains(entry.value))
        .map((entry) => entry.key)
        .toList();
  }

  ///// Below 10 % work Started here

  final TextEditingController sourceFindingRepresentativesConsulted_Controller =
      TextEditingController();
  final TextEditingController alternativeSourcesAvailable_Controller =
      TextEditingController();

  ///// Below 10 % work End here

  Future<void> saveSourceSurvey({
    required int userId,
    required int stateId,
    required int schemeId,
    required int isRecommendShiftToSurface,
    required int studyAccessGroundBeforeSurface,
    required int safeZoneVillages,
    required int criticalZoneVillages,
    required int semiCriticalZoneVillages,
    required int groundWaterAnalysisConducted,
    required int waterAllocationFromWRD,
    required String alterNativeSource,
    required String repressFindinCommitte,
    required int modeType,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _schemeRepositoy.saveSourceSurvey(
        userId: userId,
        stateId: stateId,
        schemeId: schemeId,
        isRecommendShiftToSurface: isRecommendShiftToSurface,
        studyAccessGroundBeforeSurface: studyAccessGroundBeforeSurface,
        safeZoneVillages: safeZoneVillages,
        criticalZoneVillages: criticalZoneVillages,
        semiCriticalZoneVillages: semiCriticalZoneVillages,
        groundWaterAnalysisConducted: groundWaterAnalysisConducted,
        waterAllocationFromWRD: waterAllocationFromWRD,
        alterNativeSource: alterNativeSource,
        repressFindinCommitte: repressFindinCommitte,
        modeType: modeType
      );

      _message = response.message;
      _status = response.status;
    } catch (e) {
      GlobalExceptionHandler.handleException(e as Exception);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //**** fetch api Part A start here ***///

  List<SourceSurveyItem> sourceSurveyData = [];

  Future<void> fetchSourceSurvey(
      String stateId, String schemeId, String userId, int modeType) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response =
          await _fetchschemeinfo.fetchSourceSurvey(stateId, schemeId, userId,modeType);
      if (response.status) {
        sourceSurveyData = response.result;
        _message = '';

        selectedValueQ1 = getRadiobuttonData(
            sourceSurveyData.first.isRcmndShiftToSurfaceWtr, yesNoMap);
        print('selectedValueQ1: $selectedValueQ1');

        selectedValueQ2 = getRadiobuttonData(
            sourceSurveyData.first.anyStudyAccessGwBeforeSw, yesNoMap);
        print('selectedValueQ2: $selectedValueQ2');

        safeController.text =
            sourceSurveyData.first.noVillagesSafeZone.toString();
        print('safeController: ${safeController.text}');

        criticalController.text =
            sourceSurveyData.first.noVillagesCriticalZone.toString();
        print('criticalController: ${criticalController.text}');

        semiCriticalController.text =
            sourceSurveyData.first.noVillagesSemiCriticalZone.toString();
        print('semiCriticalController: ${semiCriticalController.text}');

        selectedValueQ3 = getRadiobuttonData(
            sourceSurveyData.first.incaseGwContAnyAnalysisConduct, yesNoMap);
        print('selectedValueQ3: $selectedValueQ3');

        waterAllocationController.text =
            sourceSurveyData.first.wtrAllocationFrmStateWRDIDFrmSw.toString();
        print('waterAllocationController: ${waterAllocationController.text}');
        //
       sourceFindingRepresentativesConsulted_Controller.text = sourceSurveyData.first.represe_of_ource_finding_committee;
       alternativeSourcesAvailable_Controller.text=sourceSurveyData.first.cost_effective_alternative_sources;

        //  Remarks_Source;
      } else {
        _message = response.message;
      }
    } catch (e) {
      _message = 'Failed to fetch Source Survey data.';
      debugPrint('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearfetchSourceSurvey() {
    // Clear selected radio button values
    selectedValueQ1 = null;
    selectedValueQ2 = null;
    selectedValueQ3 = null;

    // Clear frequency text field
    safeController.clear();
    criticalController.clear();
    semiCriticalController.clear();
    waterAllocationController.clear();
    sourceFindingRepresentativesConsulted_Controller.clear();
    alternativeSourcesAvailable_Controller.clear();

    notifyListeners();
  }

  //**** fetch api Part B start here ***///

  // --------------------
  // 1. Survey Questions (Checkbox Questions)
  String? _topoSurvey;
  String? _gpsSurvey;
  String? _googleEarthSurvey;
  String? _noSurvey;

  String? get topoSurvey => _topoSurvey;

  set topoSurvey(String? value) {
    _topoSurvey = value;
    notifyListeners();
  }

  String? get gpsSurvey => _gpsSurvey;

  set gpsSurvey(String? value) {
    _gpsSurvey = value;
    notifyListeners();
  }

  String? get googleEarthSurvey => _googleEarthSurvey;

  set googleEarthSurvey(String? value) {
    _googleEarthSurvey = value;
    notifyListeners();
  }

  String? get noSurvey => _noSurvey;

  set noSurvey(String? value) {
    _noSurvey = value;
    notifyListeners();
  }

  int get topoSurveyID => yesNoMap[_topoSurvey] ?? 0;

  int get gpsSurveyID => yesNoMap[_gpsSurvey] ?? 0;

  int get googleEarthSurveyID => yesNoMap[_googleEarthSurvey] ?? 0;

  int get noSurveyID => yesNoMap[_noSurvey] ?? 0;

  // --------------------
  // 2. WTP Design Hours (Text Field)
  final TextEditingController wtpHoursController = TextEditingController();

  // --------------------
  // 3. Retention Time (Text Fields)
  final TextEditingController ohsrTimeController = TextEditingController();
  final TextEditingController mbrTimeController = TextEditingController();

  // --------------------
  // 4. Pipe Material Selection (Text Fields)
  final TextEditingController rockyPipeMaterialController =
      TextEditingController();
  final TextEditingController soilPipeMaterialController =
      TextEditingController();

  // --------------------
  // 5. On-Spot Excavation Check (Radio + Conditional Text)
  String? _onSpotExcavation;

  String? get onSpotExcavation => _onSpotExcavation;

  set onSpotExcavation(String? value) {
    _onSpotExcavation = value;
    notifyListeners();
  }

  int get onSpotExcavationID => yesNoMap[_onSpotExcavation] ?? 0;

  final TextEditingController deviationReasonController =
      TextEditingController();

  //// Below 10 % work Started here PArt B
  final TextEditingController schemePlanning_Question1Controller = TextEditingController();
  final TextEditingController schemePlanning_Question2Controller = TextEditingController();
  final TextEditingController schemePlanning_Question5Controller = TextEditingController();
  final TextEditingController schemePlanning_Question6Controller = TextEditingController();
  //// Below 10 % work Ended here

  Future<void> saveSchemePlanning({
    required int userId,
    required int stateId,
    required int schemeId,
    required int topoSurvey,
    required int gpsSurvey,
    required int googleSurvey,
    required int numberOfSurveys,
    required int designRunningHours,
    required int retentionTimeOHT,
    required int retentionTimeMBR,
    required String terrainRocky,
    required String terrainSoil,
    required int foundAsPerDPR,
    required String deviation,

    required String reason_not_awarded_scheme_planning,
    required String work_awarded_no_physical_progress,
    required String multiple_schemes_sanctioned_justify_detial,
    required String desgined_conjunctive_detail,
    required int phy_status ,

  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _schemeRepositoy.saveSchemePlanning(
        userId: userId,
        stateId: stateId,
        schemeId: schemeId,
        topoSurvey: topoSurvey,
        gpsSurvey: gpsSurvey,
        googleSurvey: googleSurvey,
        numberOfSurveys: numberOfSurveys,
        designRunningHours: designRunningHours,
        retentionTimeOHT: retentionTimeOHT,
        retentionTimeMBR: retentionTimeMBR,
        terrainRocky: terrainRocky,
        terrainSoil: terrainSoil,
        foundAsPerDPR: foundAsPerDPR,
        deviation: deviation,


        reason_not_awarded_scheme_planning:reason_not_awarded_scheme_planning,
        work_awarded_no_physical_progress:work_awarded_no_physical_progress,
        multiple_schemes_sanctioned_justify_detial:multiple_schemes_sanctioned_justify_detial,
        desgined_conjunctive_detail:desgined_conjunctive_detail,
        phy_status: phy_status ,
      );

      _message = response.message;
      _status = response.status;
    } catch (e) {
      GlobalExceptionHandler.handleException(e as Exception);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //**** fetch api Part B start here ***///

  List<SchemePlanningItem> schemePlanningData = [];

  Future<void> fetchSchemePlanning(
      String stateId, String schemeId, String userId, int modeType) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response =
          await _fetchschemeinfo.fetchSchemePlanning(stateId, schemeId, userId,modeType);
      if (response.status) {
        schemePlanningData = response.result;
        _message = '';

        topoSurvey = getRadiobuttonData(
            schemePlanningData.first.isTopographicalSurvey, yesNoMap);
        print('topoSurvey: $topoSurvey');

        gpsSurvey = getRadiobuttonData(
            schemePlanningData.first.isGpsPhysicalSurvey, yesNoMap);
        print('gpsSurvey: $gpsSurvey');

        googleEarthSurvey = getRadiobuttonData(
            schemePlanningData.first.isGoogleEarthSurvey, yesNoMap);
        print('googleEarthSurvey: $googleEarthSurvey');

        noSurvey =
            getRadiobuttonData(schemePlanningData.first.noSurvey, yesNoMap);
        print('noSurvey: $noSurvey');

        wtpHoursController.text = schemePlanningData
            .first.runningHrsDesignTransmissionMain
            .toString();
        print('wtpHoursController: ${wtpHoursController.text}');

        ohsrTimeController.text =
            schemePlanningData.first.retentionTimeOSHR.toString();
        print('ohsrTimeController: ${ohsrTimeController.text}');

        mbrTimeController.text =
            schemePlanningData.first.retentionTimeMBR.toString();
        print('mbrTimeController: ${mbrTimeController.text}');

        rockyPipeMaterialController.text = schemePlanningData
            .first.distributionNetwrkTerrianTypeRockyStrata
            .toString();
        print(
            'rockyPipeMaterialController: ${rockyPipeMaterialController.text}');

        soilPipeMaterialController.text = schemePlanningData
            .first.distributionNetwrkTerrianTypeSoilStrata
            .toString();
        print('soilPipeMaterialController: ${soilPipeMaterialController.text}');

        onSpotExcavation = getRadiobuttonData(
            schemePlanningData.first.foundAsPerDPR, yesNoMap);
        print('onSpotExcavation: $onSpotExcavation');

        deviationReasonController.text =
            schemePlanningData.first.divationIfAny.toString();
        print('deviationReasonController: ${deviationReasonController.text}');
        //
        schemePlanning_Question1Controller.text  =schemePlanningData.first.txtreason_not_awarded_scheme_planning;
        schemePlanning_Question2Controller .text  =schemePlanningData.first.txtwork_awarded_no_physical_progress;
        schemePlanning_Question5Controller .text =schemePlanningData.first.txtmultiple_schemes_sanctioned_justify_detial;
        schemePlanning_Question6Controller .text  =schemePlanningData.first.txtdesgined_conjunctive_detail;
        //       =schemePlanningData.first.scheme_planning_Remarks;
        //
      } else {
        _message = response.message;
      }
    } catch (e) {
      _message = 'Failed to fetch Scheme Planning data.';
      debugPrint('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearfetchSchemePlanning() {
    // Clear selected radio button values
    topoSurvey = null;
    gpsSurvey = null;
    googleEarthSurvey = null;
    noSurvey = null;
    onSpotExcavation = null;

    // Clear frequency text field
    wtpHoursController.clear();
    ohsrTimeController.clear();
    mbrTimeController.clear();
    waterAllocationController.clear();
    rockyPipeMaterialController.clear();
    soilPipeMaterialController.clear();
    deviationReasonController.clear();


    schemePlanning_Question1Controller.clear() ;
    schemePlanning_Question2Controller.clear() ;
    schemePlanning_Question5Controller.clear();
    schemePlanning_Question6Controller.clear();

    notifyListeners();
  }

  //**** fetch api Part B end here ***///
  // Radio 1: Legacy Infrastructure Assessment
  String? _legacyInfraAssessment;

  String? get legacyInfraAssessment => _legacyInfraAssessment;

  set legacyInfraAssessment(String? value) {
    _legacyInfraAssessment = value;
    notifyListeners();
  }

  int get selectedLegacyInfraAssessmentId =>
      yesNoMap[_legacyInfraAssessment] ?? 0;

  // TextField Controllers: Legacy Infrastructure Usage
  final TextEditingController transmissionPipelineKmController =
      TextEditingController();
  final TextEditingController distributionPipelineKmController =
      TextEditingController();
  final TextEditingController wtpCapacityMldController =
      TextEditingController();

  final TextEditingController storageStructureDetailsController =
      TextEditingController();

  // Radio 2: As-built Drawing Availability
  String? _asBuiltDrawingAvailability;

  String? get asBuiltDrawingAvailability => _asBuiltDrawingAvailability;

  set asBuiltDrawingAvailability(String? value) {
    _asBuiltDrawingAvailability = value;
    notifyListeners();
  }

  int get asBuiltDrawingAvailabilityID =>
      yesNoMap[_asBuiltDrawingAvailability] ?? 0;

  // Radio 3: Has it been digitized and uploaded on PM Gatishakti?
  String? _onPmGatishakti;

  String? get onPmGatiShakti => _onPmGatishakti;

  set onPmGatiShakti(String? value) {
    _onPmGatishakti = value;
    notifyListeners();
  }

  int get onPmGatishaktiID => yesNoMap[_onPmGatishakti] ?? 0;
  final TextEditingController reasonController = TextEditingController();




  Future<void> saveRetrofitAdditionalInfo({
    required int userId,
    required int stateId,
    required int schemeId,
    required int isAssessmentDone,
    required String assessmentMethod,
    required String assessmentReason,
    required double pipelineKms,
    required double distributionKms,
    required double wtpCapacity,
    required int structureNos,
    required double structureCapacity,
    required int buildDrawingAvailable,
    required int onPMGati,
    required String noReason,
    required int phyStatus,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _schemeRepositoy.saveRetrofitAdditionalInfo(
        userId: userId,
        stateId: stateId,
        schemeId: schemeId,
        isAssessmentDone: isAssessmentDone,
        assessmentMethod: assessmentMethod,
        assessmentReason: assessmentReason,
        pipelineKms: pipelineKms,
        distributionKms: distributionKms,
        wtpCapacity: wtpCapacity,
        structureNos: structureNos,
        structureCapacity: structureCapacity,
        buildDrawingAvailable: buildDrawingAvailable,
        onPMGati: onPMGati,
        noReason: noReason,
        phy_status: phyStatus
      );

      _message = response.message;
      _status = response.status;
    } catch (e) {
      GlobalExceptionHandler.handleException(e as Exception);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //**** fetch api Part C start here ***///

  List<AdditionalInfoRetrofitItem> retrofitInfoData = [];

  Future<void> fetchAdditionalInfoRetrofit(
      String stateId, String schemeId, String userId,int modeType) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _fetchschemeinfo.fetchAdditionalInfoRetrofit(
          stateId, schemeId, userId,modeType);
      if (response.status) {
        retrofitInfoData = response.result;
        _message = '';

        legacyInfraAssessment = getRadiobuttonData(
            retrofitInfoData.first.whetherAssesmentLegacyDone, yesNoMap);
        print('legacyInfraAssessment: $legacyInfraAssessment');

        transmissionPipelineKmController.text = retrofitInfoData
            .first.legacyInfrastructureTransmissionPipelineKms
            .toString();
        print(
            'transmissionPipelineKmController: ${transmissionPipelineKmController.text}');

        distributionPipelineKmController.text = retrofitInfoData
            .first.legacyInfrastructureDistributionPipelineKms
            .toString();
        print(
            'distributionPipelineKmController: ${distributionPipelineKmController.text}');

        wtpCapacityMldController.text = retrofitInfoData
            .first.legacyInfrastructureWtpCapacityMld
            .toString();
        print('wtpCapacityMldController: ${wtpCapacityMldController.text}');

        storageStructureDetailsController.text = retrofitInfoData
            .first.legacyInfrastructureStorageStrCapacityKl
            .toString();
        print(
            'storageStructureDetailsController: ${storageStructureDetailsController.text}');

        asBuiltDrawingAvailability = getRadiobuttonData(
            retrofitInfoData.first.buildDrawingInfrAvailable, yesNoMap);
        print('legacyInfraAssessment: $asBuiltDrawingAvailability');

        onPmGatiShakti = getRadiobuttonData(
            retrofitInfoData.first.ifYesIsItOnPMGati, yesNoMap);
        print('onPmGatiShakti: $onPmGatiShakti');

        reasonController.text = retrofitInfoData.first.ifNoReason.toString();

      //  additionalRemarkController retrofitInfoData.first.AdditionalInfo_Remarks.toString();
        print('reasonController: ${reasonController.text}');
      } else {
        _message = response.message;
      }
    } catch (e) {
      _message = 'Failed to fetch Retrofit Info data.';
      debugPrint('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearfetchAdditionalInfoRetrofit() {
    // Clear selected radio button values
    legacyInfraAssessment = null;
    asBuiltDrawingAvailability = null;
    onPmGatiShakti = null;

    // Clear frequency text field
    transmissionPipelineKmController.clear();
    distributionPipelineKmController.clear();
    wtpCapacityMldController.clear();
    storageStructureDetailsController.clear();
    reasonController.clear();

    notifyListeners();
  }

  //**** fetch api Part C end here ***///

  // Q1: Delay reasons
  List<String> _selectedDelayReasons = [];

  List<String> get selectedDelayReasons => _selectedDelayReasons;

  set selectedDelayReasons(List<String> value) {
    _selectedDelayReasons = value;
    notifyListeners();
  }

  final Map<String, int> delayReasons = {
    "Delay in DPR approval": 1,
    "Contractor delay": 2,
    "Design changes during execution": 3,
    "Material shortage": 4,
    "Land/site issues": 5,
    "Weather/natural calamities": 6,
    "Inter-departmental coordination": 7,
    "Others": 8,
    "Clearances from Highway/Forest/Railways etc.": 9,
  };

  List<String> get delayReasonsOptions => delayReasons.keys.toList();

  List<int> get selectedDelayReasonsID =>
      _selectedDelayReasons.map((e) => delayReasons[e] ?? 0).toList();

  // Q2: Cost overrun (single choice)
  String? _selectedCostOverrun;

  String? get selectedCostOverrun => _selectedCostOverrun;

  set selectedCostOverrun(String? value) {
    _selectedCostOverrun = value;
    notifyListeners();
  }

  Map<String, int> costOverrun = {
    "<10%": 1,
    "10–25%": 2,
    ">25%": 3,
    "No overrun": 4,
  };

  int get selectedCostOverrunID => costOverrun[_selectedCostOverrun] ?? 0;

  // Q3: Reason(s) for cost overrun (multi-select)
  List<String> _selectedcostOverrunReasons = [];

  List<String> get selectedcostOverrunReasons => _selectedcostOverrunReasons;

  set selectedcostOverrunReasons(List<String> value) {
    _selectedcostOverrunReasons = value;
    notifyListeners();
  }

  final Map<String, int> ReasonsOptions = {
    "Price escalation of materials": 1,
    "Additional scope of work added post-DPR": 2,
    "Delay in project execution leading to cost inflation": 3,
    "Revision in technical design/specifications": 4,
    "Change in site conditions or unforeseen site challenges": 5,
    "Contractor claim settlement/additional payments": 6,
    "Logistic/transportation constraints": 7,
    "Poor estimation at DPR stage": 8,
    "Others": 9,
  };

  List<String> get ReasonsOptionsOptions => ReasonsOptions.keys.toList();

  List<int> get selectedcostOverrunReasonsID =>
      _selectedcostOverrunReasons.map((e) => ReasonsOptions[e] ?? 0).toList();

  // Q4: Revised cost approved before award (yes/no)
  String? _selectedrevisedCostApproved; // Yes / No

  String? get selectedrevisedCostApproved => _selectedrevisedCostApproved;

  set selectedrevisedCostApproved(String? value) {
    _selectedrevisedCostApproved = value;
    notifyListeners();
  }

  // Q5: Cost overrun (single choice)
  String? _selectedincreaseInCost;

  String? get selectedincreaseInCost => _selectedincreaseInCost;

  set selectedincreaseInCost(String? value) {
    _selectedincreaseInCost = value;
    notifyListeners();
  }

  final Map<String, int> increaseInCostID = {
    "<10%": 1,
    "10–25%": 2,
    ">25%": 3,
    "No overrun": 4,
  };

  int get selectedincreaseInCostID =>
      increaseInCostID[_selectedincreaseInCost] ?? 0;

  //
  int get selectedrevisedCostApprovedID =>
      yesNoMap[_selectedrevisedCostApproved] ?? 0;

  // Q5.1: Increase in cost (single choice)
  String? _increaseInCost;

  String? get increaseInCost => _increaseInCost;

  set increaseInCost(String? value) {
    _increaseInCost = value;
    notifyListeners();
  }

  // Q5.2: Date of SLSSC approval (text)
  String? _dateApproval;

  String? get dateApproval => _dateApproval;

  set dateApproval(String? value) {
    _dateApproval = value;
    notifyListeners();
  }

  // Q6: Reason(s) for cost overrun (multi-select)
  List<String> _selectedrevisionReasons = [];

  List<String> get selectedrevisionReasons => _selectedrevisionReasons;

  set selectedrevisionReasons(List<String> value) {
    _selectedrevisionReasons = value;
    notifyListeners();
  }

  //Q7
  Map<String, TextEditingController> costControllers = {};

  // Fields for component counts
  int intakeTubeWellNum;
  int electroMechanicalNum;
  int wtpNum;
  int mbrNum;
  int transmissionPipelineNum;
  int distributionPipelineNum;
  int ohtNum;
  int disinfectionUnitNum;
  int iotNum;
  int roadRestorationNum;
  int solarComponentNum;
  int otherComponentsNum;

  Schemeprovider({
    this.intakeTubeWellNum = 0,
    this.electroMechanicalNum = 0,
    this.wtpNum = 0,
    this.mbrNum = 0,
    this.transmissionPipelineNum = 0,
    this.distributionPipelineNum = 0,
    this.ohtNum = 0,
    this.disinfectionUnitNum = 0,
    this.iotNum = 0,
    this.roadRestorationNum = 0,
    this.solarComponentNum = 0,
    this.otherComponentsNum = 0,
  }) {
    _initCostControllers();
  }

  void _initCostControllers() {
    costControllers = {
      'Intake/Tubewell': TextEditingController(),
      'Electromechanical components': TextEditingController(),
      'WTP': TextEditingController(),
      'MBR': TextEditingController(),
      'Transmission pipeline': TextEditingController(),
      'Distribution pipeline': TextEditingController(),
      'OHSR/ESR/OHT/GSR': TextEditingController(),
      'Disinfection unit': TextEditingController(),
      'IoT/SCADA': TextEditingController(),
      'Road Restoration': TextEditingController(),
      'Solar components': TextEditingController(),
      'Others (DG sets, HH storage)': TextEditingController(),
    };
  }

  /// Optional: convert data to JSON
  Map<String, dynamic> toJson() => {
        'intakeTubeWellNum': intakeTubeWellNum,
        'electroMechanicalNum': electroMechanicalNum,
        'wtpNum': wtpNum,
        'mbrNum': mbrNum,
        'transmissionPipelineNum': transmissionPipelineNum,
        'distributionPipelineNum': distributionPipelineNum,
        'ohtNum': ohtNum,
        'disinfectionUnitNum': disinfectionUnitNum,
        'iotNum': iotNum,
        'roadRestorationNum': roadRestorationNum,
        'solarComponentNum': solarComponentNum,
        'otherComponentsNum': otherComponentsNum,
        'costControllers':
            costControllers.map((key, value) => MapEntry(key, value.text)),
      };

  //Q8.1
  String? _selectedWTP; // Yes / No

  String? get selectedWTP => _selectedWTP;

  set selectedWTP(String? value) {
    _selectedWTP = value;
    notifyListeners();
  }

  //
  int get selectedWTPID => yesNoMap[_selectedWTP] ?? 0;

  //Q8.2
  String? _selectedOHSR; // Yes / No

  String? get selectedOHSR => _selectedOHSR;

  set selectedOHSR(String? value) {
    _selectedOHSR = value;
    notifyListeners();
  }

  //
  int get selectedOHSRID => yesNoMap[_selectedOHSR] ?? 0;

  //Q8.3
  String? _selecteSource; // Yes / No

  String? get selecteSource => _selecteSource;

  set selecteSource(String? value) {
    _selecteSource = value;
    notifyListeners();
  }

  //
  int get selecteSourceID => yesNoMap[_selecteSource] ?? 0;

  //Q8.4
  String? _selectedPipeline; // Yes / No

  String? get selectedPipeline => _selectedPipeline;

  set selectedPipeline(String? value) {
    _selectedPipeline = value;
    notifyListeners();
  }

  //
  int get selectedPipelineID => yesNoMap[_selectedPipeline] ?? 0;

  // List to store entered [id, value] pairs
  List<Map<String, dynamic>> admissibleCostsList = [];

  // Initialize the controllers
  void initializeCostControllers(List<List<String>> rows) {
    for (var row in rows) {
      final component = row[0];
      costControllers[component] = TextEditingController();
    }
    notifyListeners();
  }

  final Map<String, int> revisionReasonsID = {
    "Price rise of materials": 1,
    "Additional scope of work ": 2,
    "Change in site conditions ": 3,
    "Others": 4,
  };

  List<String> get revisionReasonsIDOptions => revisionReasonsID.keys.toList();

  List<int> get selectedrevisionReasonsID =>
      _selectedrevisionReasons.map((e) => revisionReasonsID[e] ?? 0).toList();


  // Below 10% content
  final TextEditingController below10PartD_ques8_Controller = TextEditingController();



  Future<void> saveSchemeImplementation({
    required int userId,
    required int stateId,
    required int schemeId,
    required int costOverrun,
    required int costRevisedBeforeWork,
    required int revisedCostPercentage,
    required String slsscDate,
    required int intakeTubeWellNum,
    required double intakeTubeWellCost,
    required int electroMechanicalNum,
    required double electroMechanicalCost,
    required int wtpNum,
    required double wtpCost,
    required int mbrNum,
    required double mbrCost,
    required int transmissionPipelineNum,
    required double transmissionPipelineCost,
    required int distributionPipelineNum,
    required double distributionPipelineCost,
    required int disinfectionUnitNum,
    required double disinfectionUnitCost,
    required int ohtNum,
    required double ohtCost,
    required int iotNum,
    required double iotCost,
    required int roadRestorationNum,
    required double roadRestorationCost,
    required int solarComponentNum,
    required double solarComponentCost,
    required int otherComponentsNum,
    required double otherComponentsCost,
    required int plannedPTGatiShaktiWTP,
    required int plannedPTGatiShaktiOHT,
    required int plannedPTGatiShaktiSource,
    required int plannedPTGatiShaktiPipeline,
    required List<int> delayReasons,
    required List<int> costOverrunReasons,
    required List<int> costRevisionReasons,


    required double txtcost_levelzed_cost_cr,
    required int    is_tpia_engaged_value,
    required int    concurrent_supervission_scope_value,
    required String txtpws_status_under_scheme,
    required int    phy_status,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _schemeRepositoy.saveSchemeImplementation(
        userId: userId,
        stateId: stateId,
        schemeId: schemeId,
        costOverrun: costOverrun,
        costRevisedBeforeWork: costRevisedBeforeWork,
        revisedCostPercentage: revisedCostPercentage,
        slsscDate: slsscDate,
        intakeTubeWellNum: intakeTubeWellNum,
        intakeTubeWellCost: intakeTubeWellCost,
        electroMechanicalNum: electroMechanicalNum,
        electroMechanicalCost: electroMechanicalCost,
        wtpNum: wtpNum,
        wtpCost: wtpCost,
        mbrNum: mbrNum,
        mbrCost: mbrCost,
        transmissionPipelineNum: transmissionPipelineNum,
        transmissionPipelineCost: transmissionPipelineCost,
        distributionPipelineNum: distributionPipelineNum,
        distributionPipelineCost: distributionPipelineCost,
        disinfectionUnitNum: disinfectionUnitNum,
        disinfectionUnitCost: disinfectionUnitCost,
        ohtNum: ohtNum,
        ohtCost: ohtCost,
        iotNum: iotNum,
        iotCost: iotCost,
        roadRestorationNum: roadRestorationNum,
        roadRestorationCost: roadRestorationCost,
        solarComponentNum: solarComponentNum,
        solarComponentCost: solarComponentCost,
        otherComponentsNum: otherComponentsNum,
        otherComponentsCost: otherComponentsCost,
        plannedPTGatiShaktiWTP: plannedPTGatiShaktiWTP,
        plannedPTGatiShaktiOHT: plannedPTGatiShaktiOHT,
        plannedPTGatiShaktiSource: plannedPTGatiShaktiSource,
        plannedPTGatiShaktiPipeline: plannedPTGatiShaktiPipeline,
        delayReasons: delayReasons,
        costOverrunReasons: costOverrunReasons,
        costRevisionReasons: costRevisionReasons,


        txtcost_levelzed_cost_cr:txtcost_levelzed_cost_cr,
        is_tpia_engaged_value:is_tpia_engaged_value,
        concurrent_supervission_scope_value:concurrent_supervission_scope_value,
        txtpws_status_under_scheme:txtpws_status_under_scheme,
        phy_status:phy_status,
      );

      _message = response.message;
      _status = response.status;
    } catch (e) {
      GlobalExceptionHandler.handleException(e as Exception);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSchemeImplementationData() {
    schemeImplementationData = [];

    // Reset checkbox and radio selections
    selectedDelayReasons = [];
    selectedCostOverrun = null;
    selectedcostOverrunReasons = [];
    selectedrevisedCostApproved = null;
    selectedincreaseInCost = null;
    selectedrevisionReasons = [];

    // Reset date
    dateApproval = '';

    // Reset table numbers
    intakeTubeWellNum = 0;
    electroMechanicalNum = 0;
    wtpNum = 0;
    mbrNum = 0;
    transmissionPipelineNum = 0;
    distributionPipelineNum = 0;
    ohtNum = 0;
    disinfectionUnitNum = 0;
    iotNum = 0;
    roadRestorationNum = 0;
    solarComponentNum = 0;
    otherComponentsNum = 0;

    // Reset planned component radio buttons
    selectedWTP = null;
    selectedOHSR = null;
    selecteSource = null;
    selectedPipeline = null;



    setQuesPartE5=null;
    setQuesPartE7=null;;
  below10PartD_ques8_Controller.clear();


    notifyListeners(); // if inside a provider
  }

  //**** fetch api Part D start here ***///

  List<SchemeImplementationModel> schemeImplementationData = [];

  Future<void> fetchSchemeImplementationData(
      String stateId, String schemeId, String userId,int modeType) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _fetchschemeinfo.fetchSchemeImplementation(
          stateId, schemeId, userId,modeType);
      if (response.status) {
        _message = '';
        schemeImplementationData = response.result;

        selectedDelayReasons = getCheckBoxData(
            schemeImplementationData.first.delayWorkReason, delayReasons);
        print('selectedDelayReasons: $selectedDelayReasons');

        selectedCostOverrun = getRadiobuttonData(
            schemeImplementationData.first.costOverrun, costOverrun);
        print('selectedCostOverrun: $selectedCostOverrun');

        selectedcostOverrunReasons = getCheckBoxData(
            schemeImplementationData.first.costOverrunReason, ReasonsOptions);
        print('selectedcostOverrunReasons: $selectedcostOverrunReasons');

        selectedrevisedCostApproved = getRadiobuttonData(
            schemeImplementationData.first.hasSchemeCostRevisedBeforeWork,
            yesNoMap);
        print('selectedrevisedCostApproved: $selectedrevisedCostApproved');

        selectedincreaseInCost = getRadiobuttonData(
            schemeImplementationData.first.schemeCostRevisedBeforeWorkYesPer,
            increaseInCostID);
        print('selectedincreaseInCost: $selectedincreaseInCost');
        //TODO
        dateApproval =
            schemeImplementationData.first.slsscDateForRevisedEstimate;
        print('dateApproval: $dateApproval');

        selectedrevisionReasons = getCheckBoxData(
            schemeImplementationData.first.costOverrunReason,
            revisionReasonsID);
        print('selectedrevisionReasons: $selectedrevisionReasons');

        selectedrevisionReasons = getCheckBoxData(
            schemeImplementationData.first.costOverrunReason,
            revisionReasonsID);
        print('selectedrevisionReasons: $selectedrevisionReasons');

        //table
        intakeTubeWellNum = schemeImplementationData.first.numIntakeTubeWell;
        print('intakeTubeWellNum: $intakeTubeWellNum');
        electroMechanicalNum =
            schemeImplementationData.first.numElectroMechanicalInclPump;
        print('electroMechanicalNum: $electroMechanicalNum');
        wtpNum = schemeImplementationData.first.numWtp;
        print('wtpNum: $wtpNum');
        mbrNum = schemeImplementationData.first.numMbr;
        print('mbrNum: $mbrNum');
        transmissionPipelineNum =
            schemeImplementationData.first.numTransmissionPipeline;
        print('transmissionPipelineNum: $transmissionPipelineNum');
        distributionPipelineNum =
            schemeImplementationData.first.numDistributionPipeline;
        print('distributionPipelineNum: $intakeTubeWellNum');
        ohtNum = schemeImplementationData.first.numOshrEsrOhtGsr;
        print('ohtNum: $intakeTubeWellNum');
        disinfectionUnitNum =
            schemeImplementationData.first.numDisinfectionUnit;
        print('disinfectionUnitNum: $intakeTubeWellNum');
        iotNum = schemeImplementationData.first.numIoTScada;
        print('iotNum: $intakeTubeWellNum');
        roadRestorationNum = schemeImplementationData.first.numRoadRestoration;
        print('roadRestorationNum: $intakeTubeWellNum');
        solarComponentNum = schemeImplementationData.first.numSolarComponents;
        print('solarComponentNum: $intakeTubeWellNum');
        otherComponentsNum =
            schemeImplementationData.first.numOtherDgSetHhStorageTanksEtc;
        print('iotNum: $otherComponentsNum');

        selectedWTP = getRadiobuttonData(
            schemeImplementationData.first.isComponentPlannedWtp, yesNoMap);
        print('selectedWTP: $selectedWTP');

        selectedOHSR = getRadiobuttonData(
            schemeImplementationData.first.isComponentPlannedOshrEsrOhtGsr,
            yesNoMap);
        print('selectedOHSR: $selectedOHSR');

        selecteSource = getRadiobuttonData(
            schemeImplementationData.first.isComponentPlannedSource, yesNoMap);
        print('selecteSource: $selecteSource');

        selectedPipeline = getRadiobuttonData(
            schemeImplementationData.first.isComponentPlannedPipeline,
            yesNoMap);
        print('selectedPipeline: $selectedPipeline');
      } else {
        _message = response.message;
      }
    } catch (e) {
      _message = 'Failed to fetch Scheme Implementation data.';
      debugPrint('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void ClearfetchSchemeImplementationData() {
    selectedDelayReasons = [];
    selectedCostOverrun = null;
    selectedcostOverrunReasons = [];
    selectedrevisedCostApproved = null;
    selectedincreaseInCost = null;
    dateApproval = null;
    selectedrevisionReasons = [];
    selectedWTP = null;
    selectedOHSR = null;
    selecteSource = null;
    selectedPipeline = null;
    costControllers.clear();
    notifyListeners();
  }

  //**** fetch api Part E end here ***///

  Future<void> saveVisualInspection({
    required int userId,
    required int stateId,
    required int schemeId,
    required int costOverrun,
    required int spalling,
    required int cracks,
    required int rustMarks,
    required int swollenConcrete,
    required int trappedJute,
    required int rustedBars,
    required int dampness,
    required int whiteMarks,
    required int stoneAggregates,
    required int verticalAlignment,
    required int sagSlabBeam,
    required int highVibrationPumps,
    required int reservoirLeakage,
    required int highLeakagePumps,
    required int pipelineLeakageTransmission,
    required int pipelineLeakageDistribution,
    required int wetPatches,
    required int verifyPipeQuality,
    required int pipesAsPerDPR,
    required int complaintsOnPipelineDesign,
    required int isTPIAEngaged,
    required int sampleChecks,
    required int concurrentSupervision,
    required int tpiaStageChecks,
    required int tpiaReports,
    required int actionOnTPIA,
    required int tpiaVerifyMB,
    required int hydroTestingDone,
    required int testReportsProvided,
    required int deptQualityChecks,
    required int deptMeasurementVerification,
    required int schemeCommissioned,
    required int commissioningProofAvailable,
    required List<int> tpiaIssueTypes,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _schemeRepositoy.saveVisualInspection(
        userId: userId,
        stateId: stateId,
        schemeId: schemeId,
        costOverrun: costOverrun,
        spalling: spalling,
        cracks: cracks,
        rustMarks: rustMarks,
        swollenConcrete: swollenConcrete,
        trappedJute: trappedJute,
        rustedBars: rustedBars,
        dampness: dampness,
        whiteMarks: whiteMarks,
        stoneAggregates: stoneAggregates,
        verticalAlignment: verticalAlignment,
        sagSlabBeam: sagSlabBeam,
        highVibrationPumps: highVibrationPumps,
        reservoirLeakage: reservoirLeakage,
        highLeakagePumps: highLeakagePumps,
        pipelineLeakageTransmission: pipelineLeakageTransmission,
        pipelineLeakageDistribution: pipelineLeakageDistribution,
        wetPatches: wetPatches,
        verifyPipeQuality: verifyPipeQuality,
        pipesAsPerDPR: pipesAsPerDPR,
        complaintsOnPipelineDesign: complaintsOnPipelineDesign,
        isTPIAEngaged: isTPIAEngaged,
        sampleChecks: sampleChecks,
        concurrentSupervision: concurrentSupervision,
        tpiaStageChecks: tpiaStageChecks,
        tpiaReports: tpiaReports,
        actionOnTPIA: actionOnTPIA,
        tpiaVerifyMB: tpiaVerifyMB,
        hydroTestingDone: hydroTestingDone,
        testReportsProvided: testReportsProvided,
        deptQualityChecks: deptQualityChecks,
        deptMeasurementVerification: deptMeasurementVerification,
        schemeCommissioned: schemeCommissioned,
        commissioningProofAvailable: commissioningProofAvailable,
        tpiaIssueTypes: tpiaIssueTypes,
      );

      _message = response.message;
      _status = response.status;
    } catch (e) {
      GlobalExceptionHandler.handleException(e as Exception);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //**** fetch api Part E start here ***///

  List<SchemeVisualInspectionModel> schemeVisualInspectionData = [];

  Future<void> fetchSchemeVisualInspectionData(
      String stateId, String schemeId, String userId,int modeType) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _fetchschemeinfo.fetchSchemeVisualInspection(
          stateId, schemeId, userId,modeType);

      if (response.status) {
        schemeVisualInspectionData = response.result;

        if (schemeVisualInspectionData.isNotEmpty) {
          mapAllWidgets(schemeVisualInspectionData.first);
        }

        _message = response.message;
      } else {
        _message = response.message;
      }
    } catch (e) {
      _message = 'Failed to fetch Scheme Visual Inspection data.';
      debugPrint('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void mapAllWidgets(SchemeVisualInspectionModel schemeVisualInspectionModel) {
    setQuesPartEa1 = getRadiobuttonData(
        schemeVisualInspectionModel.isInspectOfSpallingPeelingOffSurface,
        yesNoMap);
    setQuesPartEa2 = getRadiobuttonData(
        schemeVisualInspectionModel.isInspectOfCracks, yesNoMap);
    setQuesPartEa3 = getRadiobuttonData(
        schemeVisualInspectionModel.isInspectOfRedBrownRustMarks, yesNoMap);
    setQuesPartEa4 = getRadiobuttonData(
        schemeVisualInspectionModel.isInspectOfSwollenConcrete, yesNoMap);
    setQuesPartEa5 = getRadiobuttonData(
        schemeVisualInspectionModel.isInspectOfTrappedJutePlasticBags,
        yesNoMap);
    setQuesPartEa6 = getRadiobuttonData(
        schemeVisualInspectionModel
            .isInspectOfProtrudingRustedReinforcementBars,
        yesNoMap);
    setQuesPartEa7 = getRadiobuttonData(
        schemeVisualInspectionModel.isInspectOfSpallingPeelingOffSurface,
        yesNoMap);
    setQuesPartEa8 = getRadiobuttonData(
        schemeVisualInspectionModel.isInspectOfDampnessOfConcreteSurfaces,
        yesNoMap);
    setQuesPartEa9 = getRadiobuttonData(
        schemeVisualInspectionModel.isInspectOfVisibleWhiteMarks, yesNoMap);
    setQuesPartEa10 = getRadiobuttonData(
        schemeVisualInspectionModel.isInspectOfVisibleStoneAggregates,
        yesNoMap);
    setQuesPartEa11 = getRadiobuttonData(
        schemeVisualInspectionModel
            .isInspectOfStructuresMissingVerticalAlignment,
        yesNoMap);
    setQuesPartEa12 = getRadiobuttonData(
        schemeVisualInspectionModel.isInspectOfVisibleSagInTheSlabBeam,
        yesNoMap);
    setQuesPartEa13 = getRadiobuttonData(
        schemeVisualInspectionModel.isInspectOfHighVibrationObservedInThePumps,
        yesNoMap);
    setQuesPartEa14 = getRadiobuttonData(
        schemeVisualInspectionModel.isInspectOfLeakagesInReservoirs, yesNoMap);
    setQuesPartEa15 = getRadiobuttonData(
        schemeVisualInspectionModel.isInspectOfHighLeakagesFromThePumps,
        yesNoMap);

    setQuesPartEb1 = getRadiobuttonData(
        schemeVisualInspectionModel.isInspectOfPipelinesLeakagesInTransmission,
        yesNoMap);
    setQuesPartEb2 = getRadiobuttonData(
        schemeVisualInspectionModel.isInspectOfPipelinesLeakagesInDistribution,
        yesNoMap);
    setQuesPartEb3 = getRadiobuttonData(
        schemeVisualInspectionModel.isInspectOfPipelinesWetPatchesPoolOfWater,
        yesNoMap);

    setQuesPartE2 = getRadiobuttonData(
        schemeVisualInspectionModel
            .whetherQualityVerifyOfManufacturePipeThirdParty,
        yesNoMap);
    setQuesPartE3 = getRadiobuttonData(
        schemeVisualInspectionModel
            .areThePipesAsMentionInTheDPRImplementOnGround,
        yesNoMap);
    setQuesPartE4 = getRadiobuttonData(
        schemeVisualInspectionModel
            .areThereAnyComplaintsRegardingPipelineDesignDPR,
        yesNoMap);
    setQuesPartE5 = getRadiobuttonData(
        schemeVisualInspectionModel.isTpiaEngagedForThisScheme, yesNoMap);
    setQuesPartE6 = getRadiobuttonData(
        schemeVisualInspectionModel
            .areSampleBasedQualityChecksPipesCivilKeyComponents,
        yesNoMap);
    setQuesPartE7 = getRadiobuttonData(
        schemeVisualInspectionModel.isConcurrentSupervisionInTheScopeOfTPIA,
        yesNoMap);
    setQuesPartE8 = getRadiobuttonData(
        schemeVisualInspectionModel
            .hasTpiaConductedQualityChecksAtDifferentStages,
        yesNoMap);
    setQuesPartE9 = getRadiobuttonData(
        schemeVisualInspectionModel.areThereRecordsOfInspectReportsIssuedByTpia,
        yesNoMap);

    //selectedPartE10 = getCheckBoxData(schemeVisualInspectionModel.typeOfIssuesTpias., question10Map);  // list

    selectedPartE11 = getRadiobuttonData(
        schemeVisualInspectionModel.hasAnyActionBeenTakenBasedOnTpiaObservation,
        question11Map);
    selectedPartE12 = getRadiobuttonData(
        schemeVisualInspectionModel.doesTpiaVerifyMeasurementBooks,
        question12Map);

    selectedPartE13a = getRadiobuttonData(
        schemeVisualInspectionModel.isHydrotestingPipelinesDone, yesNoMap);
    //quesPartE13b = getRadiobuttonData(schemeVisualInspectionModel.isInspectOfPipelinesLeakagesInTransmission, yesNoMap);

    quesPartE14 = getRadiobuttonData(
        schemeVisualInspectionModel.isTestReportsProvidedSamples,
        question14Map);
    quesPartE15 = getRadiobuttonData(
        schemeVisualInspectionModel.whetherDeptEngineersDoQualityChecks,
        question15Map);
    quesPartE16 = getRadiobuttonData(
        schemeVisualInspectionModel
            .whetherDeptEngVerifyMeasureConstructionWorks,
        question16Map);
    quesPartE17 = getRadiobuttonData(
        schemeVisualInspectionModel.schemeCommissionedAsPerProtocol,
        question17Map);
    quesPartE18 = getRadiobuttonData(
        schemeVisualInspectionModel.documentAsProofOfCommissioningAvailable,
        question18Map);
  }

  void clearVisualInspectionAnswers() {
    // Part EA questions
    setQuesPartEa1 = null;
    setQuesPartEa2 = null;
    setQuesPartEa3 = null;
    setQuesPartEa4 = null;
    setQuesPartEa5 = null;
    setQuesPartEa6 = null;
    setQuesPartEa7 = null;
    setQuesPartEa8 = null;
    setQuesPartEa9 = null;
    setQuesPartEa10 = null;
    setQuesPartEa11 = null;
    setQuesPartEa12 = null;
    setQuesPartEa13 = null;
    setQuesPartEa14 = null;
    setQuesPartEa15 = null;

    // Part EB questions
    setQuesPartEb1 = null;
    setQuesPartEb2 = null;
    setQuesPartEb3 = null;

    // Part E questions
    setQuesPartE2 = null;
    setQuesPartE3 = null;
    setQuesPartE4 = null;
    setQuesPartE5 = null;
    setQuesPartE6 = null;
    setQuesPartE7 = null;
    setQuesPartE8 = null;
    setQuesPartE9 = null;

    // Multi-select (checkbox)
    selectedPartE10 = [];

    // Radio buttons with custom maps
    selectedPartE11 = null;
    selectedPartE12 = null;

    selectedPartE13a = null;
    quesPartE13b = null;

    quesPartE14 = null;
    quesPartE15 = null;
    quesPartE16 = null;
    quesPartE17 = null;
    quesPartE18 = null;

    // Trigger UI update if inside ChangeNotifier
    notifyListeners(); // Optional - if you're using Provider
  }

  //**** fetch api Part E end here ***///

  String? _quesPartEa1;
  String? _quesPartEa2;
  String? _quesPartEa3;
  String? _quesPartEa4;
  String? _quesPartEa5;
  String? _quesPartEa6;
  String? _quesPartEa7;
  String? _quesPartEa8;
  String? _quesPartEa9;
  String? _quesPartEa10;
  String? _quesPartEa11;
  String? _quesPartEa12;
  String? _quesPartEa13;
  String? _quesPartEa14;
  String? _quesPartEa15;

  String? _quesPartEb1;
  String? _quesPartEb2;
  String? _quesPartEb3;

  String? _quesPartE2;
  String? _quesPartE3;
  String? _quesPartE4;
  String? _quesPartE5;
  String? _quesPartE6;
  String? _quesPartE7;
  String? _quesPartE8;
  String? _quesPartE9;

  String? get getSelectedPartEa1 => _quesPartEa1;

  String? get getSelectedPartEa2 => _quesPartEa2;

  String? get getSelectedPartEa3 => _quesPartEa3;

  String? get getSelectedPartEa4 => _quesPartEa4;

  String? get getSelectedPartEa5 => _quesPartEa5;

  String? get getSelectedPartEa6 => _quesPartEa6;

  String? get getSelectedPartEa7 => _quesPartEa7;

  String? get getSelectedPartEa8 => _quesPartEa8;

  String? get getSelectedPartEa9 => _quesPartEa9;

  String? get getSelectedPartEa10 => _quesPartEa10;

  String? get getSelectedPartEa11 => _quesPartEa11;

  String? get getSelectedPartEa12 => _quesPartEa12;

  String? get getSelectedPartEa13 => _quesPartEa13;

  String? get getSelectedPartEa14 => _quesPartEa14;

  String? get getSelectedPartEa15 => _quesPartEa15;

  String? get getSelectedPartEb1 => _quesPartEb1;

  String? get getSelectedPartEb2 => _quesPartEb2;

  String? get getSelectedPartEb3 => _quesPartEb3;

  String? get getSelectedPartE2 => _quesPartE2;

  String? get getSelectedPartE3 => _quesPartE3;

  String? get getSelectedPartE4 => _quesPartE4;

  String? get getSelectedPartE5 => _quesPartE5;

  String? get getSelectedPartE6 => _quesPartE6;

  String? get getSelectedPartE7 => _quesPartE7;

  String? get getSelectedPartE8 => _quesPartE8;

  String? get getSelectedPartE9 => _quesPartE9;

  set setQuesPartEa1(String? value) {
    _quesPartEa1 = value;
    notifyListeners();
  }

  set setQuesPartEa2(String? value) {
    _quesPartEa2 = value;
    notifyListeners();
  }

  set setQuesPartEa3(String? value) {
    _quesPartEa3 = value;
    notifyListeners();
  }

  set setQuesPartEa4(String? value) {
    _quesPartEa4 = value;
    notifyListeners();
  }

  set setQuesPartEa5(String? value) {
    _quesPartEa5 = value;
    notifyListeners();
  }

  set setQuesPartEa6(String? value) {
    _quesPartEa6 = value;
    notifyListeners();
  }

  set setQuesPartEa7(String? value) {
    _quesPartEa7 = value;
    notifyListeners();
  }

  set setQuesPartEa8(String? value) {
    _quesPartEa8 = value;
    notifyListeners();
  }

  set setQuesPartEa9(String? value) {
    _quesPartEa9 = value;
    notifyListeners();
  }

  set setQuesPartEa10(String? value) {
    _quesPartEa10 = value;
    notifyListeners();
  }

  set setQuesPartEa11(String? value) {
    _quesPartEa11 = value;
    notifyListeners();
  }

  set setQuesPartEa12(String? value) {
    _quesPartEa12 = value;
    notifyListeners();
  }

  set setQuesPartEa13(String? value) {
    _quesPartEa13 = value;
    notifyListeners();
  }

  set setQuesPartEa14(String? value) {
    _quesPartEa14 = value;
    notifyListeners();
  }

  set setQuesPartEa15(String? value) {
    _quesPartEa15 = value;
    notifyListeners();
  }

  set setQuesPartEb1(String? value) {
    _quesPartEb1 = value;
    notifyListeners();
  }

  set setQuesPartEb2(String? value) {
    _quesPartEb2 = value;
    notifyListeners();
  }

  set setQuesPartEb3(String? value) {
    _quesPartEb3 = value;
    notifyListeners();
  }

  set setQuesPartE2(String? value) {
    _quesPartE2 = value;
    notifyListeners();
  }

  set setQuesPartE3(String? value) {
    _quesPartE3 = value;
    notifyListeners();
  }

  set setQuesPartE4(String? value) {
    _quesPartE4 = value;
    notifyListeners();
  }

  set setQuesPartE5(String? value) {
    _quesPartE5 = value;
    notifyListeners();
  }

  set setQuesPartE6(String? value) {
    _quesPartE6 = value;
    notifyListeners();
  }

  set setQuesPartE7(String? value) {
    _quesPartE7 = value;
    notifyListeners();
  }

  set setQuesPartE8(String? value) {
    _quesPartE8 = value;
    notifyListeners();
  }

  set setQuesPartE9(String? value) {
    _quesPartE9 = value;
    notifyListeners();
  }

  int get selectedId_partEa1 => yesNoMap[_quesPartEa1] ?? 0;

  int get selectedId_partEa2 => yesNoMap[_quesPartEa2] ?? 0;

  int get selectedId_partEa3 => yesNoMap[_quesPartEa3] ?? 0;

  int get selectedId_partEa4 => yesNoMap[_quesPartEa4] ?? 0;

  int get selectedId_partEa5 => yesNoMap[_quesPartEa5] ?? 0;

  int get selectedId_partEa6 => yesNoMap[_quesPartEa6] ?? 0;

  int get selectedId_partEa7 => yesNoMap[_quesPartEa7] ?? 0;

  int get selectedId_partEa8 => yesNoMap[_quesPartEa8] ?? 0;

  int get selectedId_partEa9 => yesNoMap[_quesPartEa9] ?? 0;

  int get selectedId_partEa10 => yesNoMap[_quesPartEa10] ?? 0;

  int get selectedId_partEa11 => yesNoMap[_quesPartEa11] ?? 0;

  int get selectedId_partEa12 => yesNoMap[_quesPartEa12] ?? 0;

  int get selectedId_partEa13 => yesNoMap[_quesPartEa13] ?? 0;

  int get selectedId_partEa14 => yesNoMap[_quesPartEa14] ?? 0;

  int get selectedId_partEa15 => yesNoMap[_quesPartEa15] ?? 0;

  int get selectedId_partEb1 => yesNoMap[_quesPartEb1] ?? 0;

  int get selectedId_partEb2 => yesNoMap[_quesPartEb2] ?? 0;

  int get selectedId_partEb3 => yesNoMap[_quesPartEb3] ?? 0;

  int get selectedId_partE2 => yesNoMap[_quesPartE2] ?? 0;

  int get selectedId_partE3 => yesNoMap[_quesPartE3] ?? 0;

  int get selectedId_partE4 => yesNoMap[_quesPartE4] ?? 0;

  int get selectedId_partE5 => yesNoMap[_quesPartE5] ?? 0;  // this is in D part of Below 10 % too

  int get selectedId_partE6 => yesNoMap[_quesPartE6] ?? 0;

  int get selectedId_partE7 => yesNoMap[_quesPartE7] ?? 0; // this is in D part of Below 10 % too

  int get selectedId_partE8 => yesNoMap[_quesPartE8] ?? 0;

  int get selectedId_partE9 => yesNoMap[_quesPartE9] ?? 0;

  final Map<String, int> question10Map = {
    "Pipelines without proper depth": 1,
    "Pipelines leaking": 2,
    "OHT leaking": 3,
    "Cracks in RCC works": 4,
    "Water connections in drains": 5,
    "Others": 6
  };
  List<String> _quesPartE10 = [];

  List<String> get getSelectedPartE10 => _quesPartE10;

  set selectedPartE10(List<String> value) {
    _quesPartE10 = value;
    notifyListeners();
  }

  List<int> get selectedId_partE10 =>
      _quesPartE10.map((e) => question10Map[e] ?? 0).toList();

  final Map<String, int> question11Map = {
    "Rectification/Demolition Done": 1,
    "Partial Action": 2,
    "No Action": 3,
    "Not Known": 4
  };
  String? _quesPartE11;

  String? get getSelectedPartE11 => _quesPartE11;

  set selectedPartE11(String? value) {
    _quesPartE11 = value;
    notifyListeners();
  }

  int get selectedId_partE11 => question11Map[_quesPartE11] ?? 0;

  final Map<String, int> question12Map = {
    "Regularly": 1,
    "Occasionally": 2,
    "No": 3,
    "Not Known": 4
  };

  String? _quesPartE12;

  String? get getSelectedPartE12 => _quesPartE12;

  set selectedPartE12(String? value) {
    _quesPartE12 = value;
    notifyListeners();
  }

  int get selectedId_partE12 => question12Map[_quesPartE12] ?? 0;

  String? _quesPartE13a;

  String? get getSelectedPartE13a => _quesPartE13a;

  set selectedPartE13a(String? value) {
    _quesPartE13a = value;
    notifyListeners();
  }

  int get selectedId_partE13a => yesNoMap[_quesPartE13a] ?? 0;

  //

  String? _quesPartE13b;

  String? get quesPartE13b => _quesPartE13b;

  set quesPartE13b(String? value) {
    _quesPartE13b = value;
    notifyListeners();
  }

  int get selectedId_partE13b => yesNoMap[_quesPartE13b] ?? 0;

  final Map<String, int> question14Map = {
    "Hydrotesting reports": 1,
    "Construction material quality reports ": 2,
    "Not Provided": 3,
  };

  String? _quesPartE14;

  String? get quesPartE14 => _quesPartE14;

  set quesPartE14(String? value) {
    _quesPartE14 = value;
    notifyListeners();
  }

  int get selectedId_partE14 => question14Map[_quesPartE14] ?? 0;

  final Map<String, int> question15Map = {
    "Frequently ": 1,
    "Stage-wise ": 2,
    "Before payment ": 3,
    "Never": 4,
  };

  String? _quesPartE15;

  String? get quesPartE15 => _quesPartE15;

  set quesPartE15(String? value) {
    _quesPartE15 = value;
    notifyListeners();
  }

  int get selectedId_partE15 => question15Map[_quesPartE15] ?? 0;

  ////
  final Map<String, int> question16Map = {
    "Frequently ": 1,
    "Stage-wise ": 2,
    "Before payment ": 3,
    "Never": 4,
  };

  String? _quesPartE16;

  String? get quesPartE16 => _quesPartE16;

  set quesPartE16(String? value) {
    _quesPartE16 = value;
    notifyListeners();
  }

  int get selectedId_partE16 => question16Map[_quesPartE16] ?? 0;

  ////
  final Map<String, int> question17Map = {
    "Yes": 1,
    "No": 2,
    "Partially": 3,
    "Not Verified": 4,
    "Work is in progress": 5
  };

  String? _quesPartE17;

  String? get quesPartE17 => _quesPartE17;

  set quesPartE17(String? value) {
    _quesPartE17 = value;
    notifyListeners();
  }

  int get selectedId_partE17 => question17Map[_quesPartE17] ?? 0;

  ////
  final Map<String, int> question18Map = {"Yes": 1, "No": 2, "NA": 3};

  String? _quesPartE18;

  String? get quesPartE18 => _quesPartE18;

  set quesPartE18(String? value) {
    _quesPartE18 = value;
    notifyListeners();
  }

  int get selectedId_partE18 => question18Map[_quesPartE18] ?? 0;
}
