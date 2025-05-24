import 'package:cno_inspection/repository/schemeInfoRepo/SchemeRepository.dart';
import 'package:flutter/cupertino.dart';

class Schemeprovider extends ChangeNotifier {
  final SchemeRepositoy _schemeRepositoy = SchemeRepositoy();

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
  final TextEditingController waterAllocationController = TextEditingController();

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

  Future<bool> saveSourceSurvey({
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
      );

      _message = response.message;
      _status = response.status;
      return _status ?? false;
    } catch (e) {
      _message = 'Something went wrong';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

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
  final TextEditingController rockyPipeMaterialController = TextEditingController();
  final TextEditingController soilPipeMaterialController = TextEditingController();

  // --------------------
  // 5. On-Spot Excavation Check (Radio + Conditional Text)
  String? _onSpotExcavation;
  String? get onSpotExcavation => _onSpotExcavation;
  set onSpotExcavation(String? value) {
    _onSpotExcavation = value;
    notifyListeners();
  }
  int get onSpotExcavationID => yesNoMap[_onSpotExcavation] ?? 0;


  final TextEditingController deviationReasonController = TextEditingController();

  Future<bool> saveSchemePlanning({
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
      );

      _message = response.message;
      _status = response.status;
      return _status ?? false;
    } catch (e) {
      _message = 'Something went wrong';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  // Radio 1: Legacy Infrastructure Assessment
  String? _legacyInfraAssessment;
  String? get legacyInfraAssessment => _legacyInfraAssessment;
  set legacyInfraAssessment(String? value) {
    _legacyInfraAssessment = value;
    notifyListeners();
  }
  int get selectedLegacyInfraAssessmentId => yesNoMap[_legacyInfraAssessment] ?? 0;

  // TextField Controllers: Legacy Infrastructure Usage
  final TextEditingController transmissionPipelineKmController = TextEditingController();
  final TextEditingController distributionPipelineKmController = TextEditingController();
  final TextEditingController wtpCapacityMldController = TextEditingController();
  final TextEditingController storageStructureDetailsController = TextEditingController();

  // Radio 2: As-built Drawing Availability
  String? _asBuiltDrawingAvailability;
  String? get asBuiltDrawingAvailability => _asBuiltDrawingAvailability;
  set asBuiltDrawingAvailability(String? value) {
    _asBuiltDrawingAvailability = value;
    notifyListeners();
  }

  int get asBuiltDrawingAvailabilityID => yesNoMap[_asBuiltDrawingAvailability] ?? 0;

  // Radio 3: Has it been digitized and uploaded on PM Gatishakti?
  String? _onPmGatishakti;
  String? get onPmGatiShakti => _onPmGatishakti;
  set onPmGatiShakti(String? value) {
    _onPmGatishakti = value;
    notifyListeners();
  }
  int get onPmGatishaktiID => yesNoMap[_onPmGatishakti] ?? 0;
  final TextEditingController reasonController = TextEditingController();


  Future<bool> saveRetrofitAdditionalInfo({
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
      );

      _message = response.message;
      _status = response.status;
      return _status ?? false;
    } catch (e) {
      _message = 'Something went wrong';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }






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
  List<int> get selectedDelayReasonsID => _selectedDelayReasons.map((e) => delayReasons[e] ?? 0).toList();

  // Q2: Cost overrun (single choice)
  String? _selectedCostOverrun;
  String? get selectedCostOverrun => _selectedCostOverrun;
  set selectedCostOverrun(String? value) {
    _selectedCostOverrun = value;
    notifyListeners();
  }

  final Map<String, int> costOverrun = {
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
  List<int> get selectedcostOverrunReasonsID => _selectedcostOverrunReasons.map((e) => ReasonsOptions[e] ?? 0).toList();


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

  int get selectedincreaseInCostID => increaseInCostID[_selectedincreaseInCost] ?? 0;


  //
  int get selectedrevisedCostApprovedID => yesNoMap[_selectedrevisedCostApproved] ?? 0;

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

  // Map for component IDs
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


  // Constructor
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
    // Initialize TextEditingControllers for cost fields
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

  /// Example: update logic when cost field changes
  void updateAdmissibleCost(String component, String val) {
    // Parse value as integer if needed for numeric updates
    int? numValue = int.tryParse(val);

    switch (component) {
      case 'Intake/Tubewell':
        intakeTubeWellNum = numValue ?? 0;
        break;
      case 'Electromechanical components':
        electroMechanicalNum = numValue ?? 0;
        break;
      case 'WTP':
        wtpNum = numValue ?? 0;
        break;
      case 'MBR':
        mbrNum = numValue ?? 0;
        break;
      case 'Transmission pipeline':
        transmissionPipelineNum = numValue ?? 0;
        break;
      case 'Distribution pipeline':
        distributionPipelineNum = numValue ?? 0;
        break;
      case 'OHSR/ESR/OHT/GSR':
        ohtNum = numValue ?? 0;
        break;
      case 'Disinfection unit':
        disinfectionUnitNum = numValue ?? 0;
        break;
      case 'IoT/SCADA':
        iotNum = numValue ?? 0;
        break;
      case 'Road Restoration':
        roadRestorationNum = numValue ?? 0;
        break;
      case 'Solar components':
        solarComponentNum = numValue ?? 0;
        break;
      case 'Others (DG sets, HH storage)':
        otherComponentsNum = numValue ?? 0;
        break;
      default:
      // Component not recognized
        break;
    }
  }

  /// Optionally, dispose all controllers when done
  void dispose() {
    for (var controller in costControllers.values) {
      controller.dispose();
    }
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
    'costControllers': costControllers.map((key, value) => MapEntry(key, value.text)),
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
  List<int> get selectedrevisionReasonsID => _selectedrevisionReasons.map((e) => revisionReasonsID[e] ?? 0).toList();


  Future<bool> saveSchemeImplementation({
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
      );

      _message = response.message;
      _status = response.status;
      return _status ?? false;
    } catch (e) {
      _message = 'Something went wrong';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> saveVisualInspection({
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
      return _status ?? false;
    } catch (e) {
      _message = 'Something went wrong';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }



}
