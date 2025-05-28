import 'package:cno_inspection/repository/dwsmRepo/DWSMRepositoy.dart';
import 'package:flutter/cupertino.dart';

import '../../model/dwsmPartB/CoordinationPlanningReviewPARTA.dart';
import '../../model/dwsmPartB/MonitoringQualityLabInfrastructurePARTC.dart';
import '../../model/dwsmPartB/OperationMaintenancePARTD.dart';
import '../../model/dwsmPartB/PublicComplaintsGrievanceRedressalPARTF.dart';
import '../../model/dwsmPartB/QualityAssuranceCommissioningPARTE.dart';
import '../../model/dwsmPartB/SourceSustainabilityWaterConservationPARTB.dart';
import '../../repository/dwsmRepo/fetchDwsmRepo.dart';
import '../../utils/GlobalExceptionHandler.dart';

class Dwsmprovider extends ChangeNotifier {
  final DWSMRepositoy _dwsmRepository = DWSMRepositoy();
  final Fetchdwsmrepo _fetchdwsmrepo = Fetchdwsmrepo();

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

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _message;

  String? get message => _message;

  bool? _status;

  bool? get status => _status;

  int? _districtId;

  int? get districtId => _districtId;

  void setDistrictId(int id) {
    _districtId = id;
    notifyListeners();
  }

  int? _stateId;

  int? get stateId => _stateId;

  void setStateId(int id) {
    _stateId = id;
    notifyListeners();
  }

  final Map<String, int> yesNoMap = {
    "Yes": 1,
    "No": 0,
  };

  //AAAAAAAAaaaaaaaaaa

  // Question 1: Are monthly meetings held?
  String? _selectedValueQ1;

  String? get selectedValueQ1 => _selectedValueQ1;

  set selectedValueQ1(String? val) {
    _selectedValueQ1 = val;
    notifyListeners();
  }

  int get selectedValueQ1Id => yesNoMap[_selectedValueQ1] ?? -1;

  // Controller for 1.1 How many meetings
  final TextEditingController meetingsHeldController = TextEditingController();

  final Map<String, int> meetingQualityMap = {
    'Proper Documentation with actionable decision': 1,
    'Partial Documentation': 2,
    'Not Documented': 3
  };

  // Question 1.2: Quality of meeting
  String? _selectedMeetingQuality;

  String? get selectedMeetingQuality => _selectedMeetingQuality;

  set selectedMeetingQuality(String? val) {
    _selectedMeetingQuality = val;
    notifyListeners();
  }

  int get selectedMeetingQualityID =>
      meetingQualityMap[_selectedMeetingQuality] ?? -1;

  // Question 2: DISHA meetings being held
  String? _selectedDISHA;

  String? get selectedDISHA => _selectedDISHA;

  set selectedDISHA(String? val) {
    _selectedDISHA = val;
    notifyListeners();
  }

  int get selectedDISHAID => yesNoMap[_selectedDISHA] ?? -1;

  Future<void> saveCoordinationPlanningReview({
    required int userId,
    required int stateId,
    required int districtId,
    required int areMonthlyMeetingsHeld,
    required int numberOfMeetingsLast6Months,
    required int qualityOfMeeting,
    required int areCoordinationMeetingsRegular,
    required int modeType,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _dwsmRepository.saveCoordinationPlanningReview(
        userId: userId,
        stateId: stateId,
        districtId: districtId,
        areMonthlyMeetingsHeld: areMonthlyMeetingsHeld,
        numberOfMeetingsLast6Months: numberOfMeetingsLast6Months,
        qualityOfMeeting: qualityOfMeeting,
        areCoordinationMeetingsRegular: areCoordinationMeetingsRegular,
        modeType: modeType,
      );

      _message = response.message;
      _status = response.status;
    } catch (e) {
      _message = 'Something went wrong';
      GlobalExceptionHandler.handleException(e as Exception);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //fetch for part a start

  List<CoordinationPlanningReview> coordinationData = [];

  Future<void> fetchCoordinationData(
      String stateId, String districtId, String userId,int modeType) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _fetchdwsmrepo.fetchCoordinationPlanningReview(
          stateId, districtId, userId,modeType);
      if (response.status) {
        coordinationData = response.result;
        if (coordinationData.isNotEmpty) {
          selectedValueQ1 = getRadiobuttonData(
              coordinationData.first.areMonthlyDwsmMeetingsOnProgressJjmWorks,
              yesNoMap);

          meetingsHeldController.text = coordinationData
              .first.ifYesNoOfDwsmMeetingsLast6Months
              .toString();
          selectedMeetingQuality = getRadiobuttonData(
              coordinationData.first.qualityOfMeetingAndRecordMaintenance,
              meetingQualityMap);
          selectedDISHA = getRadiobuttonData(
              coordinationData.first
                  .areDistDevelopCoordinatMonitorCommitteeMeetingRegularly,
              yesNoMap);
        }
        // Add any data processing here if needed
        _message = response.message;
        _status = response.status;
      } else {
        _message = response.message;
      }
    } catch (e) {
      GlobalExceptionHandler.handleException(e as Exception);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearCoordinationFields() {
    selectedValueQ1 = null;

    meetingsHeldController.clear();

    selectedMeetingQuality = null;
    selectedDISHA = null;

    // If you're using Provider or ChangeNotifier, optionally call:
    notifyListeners(); // <- only if inside a ChangeNotifier
  }

  //fetch for part a end

  //BBBBBBBBBBBBBBBBBBBBBBBBBBBBB

  // Question 1: Source sustainability promotion

  final Map<String, int> sourceSustainabilityMap = {
    "Actively": 1,
    "Limited": 2,
    "Not Promoted": 3,
  };

  String? _sourceSustainability;

  String? get sourceSustainability => _sourceSustainability;

  set sourceSustainability(String? value) {
    _sourceSustainability = value;
    notifyListeners();
  }

  int get sourceSustainabilityId =>
      sourceSustainabilityMap[_sourceSustainability] ?? -1;

  // Question 2: Groundwater protection
  final Map<String, int> groundwaterProtectionMap = {
    "Yes": 1,
    "Partially": 2,
    "No": 3,
  };
  String? _groundwaterProtection;

  String? get groundwaterProtection => _groundwaterProtection;

  set groundwaterProtection(String? value) {
    _groundwaterProtection = value;
    notifyListeners();
  }

  int get groundwaterProtectionId =>
      groundwaterProtectionMap[_groundwaterProtection] ?? -1;

  // Question 3: Recharge structure implementation
  final Map<String, int> rechargeStructureMap = {
    "Yes": 1,
    "In Progress": 2,
    "No": 3,
  };

  String? _rechargeStructureImplemented;

  String? get rechargeStructureImplemented => _rechargeStructureImplemented;

  set rechargeStructureImplemented(String? value) {
    _rechargeStructureImplemented = value;
    if (value != "No") {
      rechargeReasonController.clear();
    }
    notifyListeners();
  }

  int get rechargeStructureImplementedID =>
      rechargeStructureMap[_rechargeStructureImplemented] ?? -1;

  //
  // Does_district_NABL_accredited_lab_water_quality
  String? _accredited_lab_water_quality;

  String? get accreditedLabWaterQuality => _accredited_lab_water_quality;
  final TextEditingController testingManagedDataController =
      TextEditingController();

  set accreditedLabWaterQuality(String? value) {
    _accredited_lab_water_quality = value;
    if (value != "No") {
      testingManagedDataController.clear();
    }
    notifyListeners();
  }

  int get accreditedLabWaterQualityID =>
      yesNoMap[_accredited_lab_water_quality] ?? -1;

  //

  // Controller for recharge reason (if "No")
  final TextEditingController rechargeReasonController =
      TextEditingController();

  // Question 4: Impact studies conducted

  final Map<String, int> impactStudiesMap = {
    "Yes – Completed": 1,
    "Planned": 2,
    "No": 3,
  };

  String? _impactStudies;

  String? get impactStudies => _impactStudies;

  set impactStudies(String? value) {
    _impactStudies = value;
    notifyListeners();
  }

  int get impactStudiesID => impactStudiesMap[_impactStudies] ?? -1;

  Future<bool> saveSourceSustainability({
    required int userId,
    required int stateId,
    required int districtId,
    required int areSustainabilityMeasuresPromoted,
    required int areGWSourcesProtected,
    required int isRechargeStructureImplemented,
    required String reasonIfNotImplemented,
    required int areImpactStudiesConducted,
    required int accrediteLabWaterQuality,
    required String accrediteLabWaterQualityNoRemark,
    required int modeType,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _dwsmRepository.saveSourceSustainability(
          userId: userId,
          stateId: stateId,
          districtId: districtId,
          areSustainabilityMeasuresPromoted: areSustainabilityMeasuresPromoted,
          areGWSourcesProtected: areGWSourcesProtected,
          isRechargeStructureImplemented: isRechargeStructureImplemented,
          reasonIfNotImplemented: reasonIfNotImplemented,
          areImpactStudiesConducted: areImpactStudiesConducted,
          accrediteLabWaterQuality: accrediteLabWaterQuality,
          accrediteLabWaterQualityNoRemark: accrediteLabWaterQualityNoRemark,
          modeType: modeType);

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

  // fetch for dwsm part B start
  List<SourceSustainabilityWaterConservation> sustainabilityData = [];

  Future<void> fetchSustainabilityData(
      String stateId, String districtId, String userId, int modeType) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response =
          await _fetchdwsmrepo.fetchSourceSustainabilityWaterConservation(
              stateId, districtId, userId,modeType);
      if (response.status) {
        sustainabilityData = response.result;

        if (sustainabilityData.isNotEmpty) {
          sourceSustainability = getRadiobuttonData(
              sustainabilityData
                  .first.areSourceSustainabilityMeasuresBeingPromoted,
              sourceSustainabilityMap);
          groundwaterProtection = getRadiobuttonData(
              sustainabilityData
                  .first.arePipedWaterSchemesGwSourcesProtectedContamination,
              groundwaterProtectionMap);
          rechargeStructureImplemented = getRadiobuttonData(
              sustainabilityData
                  .first.isAtLeastOneRechargeStructureGwSourceImplemented,
              rechargeStructureMap);
          rechargeReasonController.text = sustainabilityData
              .first.ifNoLeastOneRechargeStructureGwSourceImplementedReson
              .toString();
          impactStudies = getRadiobuttonData(
              sustainabilityData.first
                  .areAnyImpactStudiesAssessmentsConductedSourceSustainEfforts,
              impactStudiesMap);
        }
        // Process sustainabilityData if needed
        _message = response.message;
        _status = response.status;
      } else {
        _message = response.message;
      }
    } catch (e) {
      GlobalExceptionHandler.handleException(e as Exception);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSustainabilityFields() {
    sourceSustainability = null;
    groundwaterProtection = null;
    rechargeStructureImplemented = null;
    rechargeReasonController.clear();
    impactStudies = null;
    testingManagedDataController.clear();
    accreditedLabWaterQuality = null;
    // If within a ChangeNotifier or Provider, uncomment:
    // notifyListeners();
  }

  // fetch for dwsm part B end

  //CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC

// Geotagging of water supply assets

  final Map<String, int> assetsGeotaggedMap = {
    "All": 1,
    "Partially": 2,
    "Not Done": 3,
  };

  String? _assetsGeotagged;

  String? get assetsGeotagged => _assetsGeotagged;

  set assetsGeotagged(String? value) {
    _assetsGeotagged = value;
    notifyListeners();
  }

  int get assetsGeotaggedID => assetsGeotaggedMap[_assetsGeotagged] ?? -1;

// NABL-accredited lab availability
  String? _hasNablLab;

  String? get hasNablLab => _hasNablLab;

  set hasNablLab(String? value) {
    _hasNablLab = value;
    notifyListeners();
  }

  int get hasNablLabID => yesNoMap[_hasNablLab] ?? -1;

// Testing management (if no NABL lab)
  final TextEditingController testingManagedController =
      TextEditingController();

  Future<void> saveMonitoringQualityLab(
      {required int userId,
      required int stateId,
      required int districtId,
      required int areAssetsGeotagged,
      required int hasNABLLab,
      required String testingManagementDescription,
      required int modeType}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _dwsmRepository.saveMonitoringQualityLab(
          userId: userId,
          stateId: stateId,
          districtId: districtId,
          areAssetsGeotagged: areAssetsGeotagged,
          hasNABLLab: hasNABLLab,
          testingManagementDescription: testingManagementDescription,
          modeType: modeType);

      _message = response.message;
      _status = response.status;
    } catch (e) {
      GlobalExceptionHandler.handleException(e as Exception);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // techno  commercial viablity

  TextEditingController onCostSchemeController = TextEditingController();
  TextEditingController chargeStakeHolderController = TextEditingController();
  TextEditingController remaningExpensesController = TextEditingController();
  TextEditingController requiredOperationController = TextEditingController();



  Future<void> saveTecnoCommercialViabbility({
    required int userId,
    required int stateId,
    required int districtId,
    required String omCostScheme,
    required String chargeStakeHolder,
    required String remaningExpenses,
    required String requiredOperation,
    required int modeType,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _dwsmRepository.saveTecnoCommercialViabbility(
          userId: userId,
          stateId: stateId,
          districtId: districtId,
          chargeStakeHolder: chargeStakeHolder,
          omCostScheme: omCostScheme,
          remaningExpenses: remaningExpenses,
          requiredOperation: requiredOperation,
          modeType: modeType);

      _message = response.message;
      _status = response.status;
    } catch (e) {
      GlobalExceptionHandler.handleException(e as Exception);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // fetch for dwsm part C start

  List<MonitoringQualityLabInfrastructure> monitoringData = [];

  Future<void> fetchMonitoringLabData(
      String stateId, String districtId, String userId, int modeType) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _fetchdwsmrepo
          .fetchMonitoringQualityLabInfrastructure(stateId, districtId, userId,modeType);
      if (response.status) {
        monitoringData = response.result;

        if (monitoringData.isNotEmpty) {
          assetsGeotagged = getRadiobuttonData(
              monitoringData.first.areWaterSupplyAssetsGeotagged,
              assetsGeotaggedMap);
          hasNablLab = getRadiobuttonData(
              monitoringData.first.doesDistrictHaveNablAccreditedLabEquivalent,
              yesNoMap);
          testingManagedController.text =
              monitoringData.first.ifNoHowIsTestingManagedDescription;
        }

        _message = response.message;
        _status = response.status;
      } else {
        _message = response.message;
      }
    } catch (e) {
      GlobalExceptionHandler.handleException(e as Exception);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearMonitoringFields() {
    assetsGeotagged = null;
    hasNablLab = null;
    testingManagedController.clear();

    // If using ChangeNotifier or similar:
    // notifyListeners();
  }

  // fetch for dwsm part C end

  //DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD

  // 1. Handover Protocol
  final Map<String, int> handoverProtocolMap = {
    "Yes": 1,
    "No": 2,
    "Partially": 3,
  };

  String? _handoverProtocol;

  String? get handoverProtocol => _handoverProtocol;

  set handoverProtocol(String? value) {
    _handoverProtocol = value;
    notifyListeners();
  }

  int get handoverProtocolID => handoverProtocolMap[_handoverProtocol] ?? -1;

// 2. Manpower Percentage Controller
  final TextEditingController manpowerPercentController =
      TextEditingController();

// 3. Water Fee Controller
  final TextEditingController waterFeeController = TextEditingController();

// 4. Fee Basis (Uniform or Volumetric)
  final Map<String, int> feeBasisMap = {
    "Uniform": 1,
    "Volumetric": 2,
  };
  String? _feeBasis;

  String? get feeBasis => _feeBasis;

  set feeBasis(String? value) {
    _feeBasis = value;
    notifyListeners();
  }

  int get feeBasisID => feeBasisMap[_feeBasis] ?? -1;

// 5. User Fee Collection Percentage
  final TextEditingController userFeePercentController =
      TextEditingController();

  Future<void> saveOperationMaintenance({
    required int userId,
    required int stateId,
    required int districtId,
    required int isProtocolInPlace,
    required double percentVillagesWithManpower,
    required int isWaterFeeCharged,
    required int feeAmountPerMonth,
    required int isUniformFee,
    required double percentVillagesFeeCollected,
    required int modeType
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _dwsmRepository.saveOperationMaintenance(
        userId: userId,
        stateId: stateId,
        districtId: districtId,
        isProtocolInPlace: isProtocolInPlace,
        percentVillagesWithManpower: percentVillagesWithManpower,
        isWaterFeeCharged: isWaterFeeCharged,
        feeAmountPerMonth: feeAmountPerMonth,
        isUniformFee: isUniformFee,
        percentVillagesFeeCollected: percentVillagesFeeCollected,
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

  // fetch for dwsm part D start

  List<OperationMaintenance> operationMaintenanceData = [];

  Future<void> fetchOperationMaintenanceData(
      String stateId, String districtId, String userId, int modeType) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _fetchdwsmrepo.fetchOperationMaintenance(
          stateId, districtId, userId,modeType);
      if (response.status) {
        operationMaintenanceData = response.result;
        // Example: you can extract data to UI controllers here
        _message = response.message;
        _status = response.status;

        handoverProtocol = getRadiobuttonData(
            operationMaintenanceData
                .first.isAProtocolHandingInVillageInfrastructurePlace,
            handoverProtocolMap);
        print('handoverProtocol: $handoverProtocol');

        manpowerPercentController.text = operationMaintenanceData
            .first.perOfVillagesWhereTrainedMultiSkilledManpowerAvailable
            .toString();
        print('manpowerPercentController: ${manpowerPercentController.text}');

        waterFeeController.text = operationMaintenanceData
            .first.isWaterFeeChargedFromHouseholds
            .toString();
        print('waterFeeController: ${waterFeeController.text}');

        feeBasis = getRadiobuttonData(
            operationMaintenanceData.first.feeAmountPerMonth, feeBasisMap);
        print('feeBasis: $feeBasis');

        userFeePercentController.text = operationMaintenanceData
            .first.perOfVillagesWhereUserFeeCollected
            .toString();
        print('userFeePercentController: ${userFeePercentController.text}');
      } else {
        _message = response.message;
      }
    } catch (e) {
      GlobalExceptionHandler.handleException(e as Exception);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearfetchOperationMaintenanceData() {
    handoverProtocol = null;
    feeBasis = null;

    manpowerPercentController.clear();
    waterFeeController.clear();
    waterFeeController.clear();
    notifyListeners();
  }

  // fetch for dwsm part D end

  //EEEEEEEEEEEEEEEEEEEEEEE

  // 1. Authorized Inspectors - Multi Select

  final Map<String, int> authorizedInspectorsMap = {
    "PHED Engineer": 1,
    "PMC/PMU": 2,
    "TPIA": 3,
    "VWSC": 4,
    "Contractor Representative": 5,
    "Others": 6
  };

  String? _authorizedInspectors;

  String? get authorizedInspectors => _authorizedInspectors;

  set authorizedInspectors(String? value) {
    _authorizedInspectors = value;
    notifyListeners();
  }

  int get authorizedInspectorID =>
      authorizedInspectorsMap[_authorizedInspectors] ?? -1;

// 2. Commissioning Protocol Followed - Radio
  String? _commissioningProtocolFollowed;

  String? get commissioningProtocolFollowed => _commissioningProtocolFollowed;

  set commissioningProtocolFollowed(String? value) {
    _commissioningProtocolFollowed = value;
    notifyListeners();
  }

  int get commissioningProtocolFollowedID =>
      yesNoMap[_commissioningProtocolFollowed] ?? -1;

// 3. Commissioning Presence - Multi Select

  final Map<String, int> commissioningPresenceMap = {
    "PHED": 1,
    "VWSC Members": 2,
    "PRI Representatives": 3,
    "ISA": 4,
    "TPIA": 5,
    "Community Members": 6
  };
  String? _commissioningPresence;

  String? get commissioningPresence => _commissioningPresence;

  set commissioningPresence(String? value) {
    _commissioningPresence = value;
    notifyListeners();
  }

  int get commissioningPresenceID =>
      commissioningPresenceMap[_commissioningPresence] ?? -1;

// 4. Third Party Assessment - Radio
  final Map<String, int> thirdPartyAssessmentMap = {
    "Yes – Regularly": 1,
    "Occasionally": 2,
    "Not Done": 3
  };

  String? _thirdPartyAssessment;

  String? get thirdPartyAssessment => _thirdPartyAssessment;

  set thirdPartyAssessment(String? value) {
    _thirdPartyAssessment = value;
    notifyListeners();
  }

  int get thirdPartyAssessmentID =>
      thirdPartyAssessmentMap[_thirdPartyAssessment] ?? -1;


  String? _thirdPartyInspectionAgency;
  String? get thirdPartyInspectionAgency => _thirdPartyInspectionAgency;

  set thirdPartyInspectionAgency(String? value){
    _thirdPartyInspectionAgency = value;
    notifyListeners();
  }

  int get thirdPartyInspectionAgencyID =>
      yesNoMap[_thirdPartyInspectionAgency] ?? -1;

  Future<void> saveQualityAssurance({
    required int userId,
    required int stateId,
    required int districtId,
    required int inspectionAuthority,
    required int isCommissioningProtocolFollowed,
    required int schemesPresentDuringCommissioning,
    required int districtAssessmentAgencies,
    required int districtHiredAgencies,
    required int modeType,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _dwsmRepository.saveQualityAssurance(
        userId: userId,
        stateId: stateId,
        districtId: districtId,
        inspectionAuthority: inspectionAuthority,
        isCommissioningProtocolFollowed: isCommissioningProtocolFollowed,
        schemesPresentDuringCommissioning: schemesPresentDuringCommissioning,
        districtAssessmentAgencies: districtAssessmentAgencies,
        districtHiredAgencies: districtHiredAgencies,
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

  // fetch for dwsm part E start

  List<QualityAssuranceCommissioning> qualityAssuranceData = [];

  Future<void> fetchQualityAssuranceData(
      String stateId, String districtId, String userId, int modeType) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _fetchdwsmrepo.fetchQualityAssuranceCommissioning(
          stateId, districtId, userId,modeType);
      if (response.status) {
        qualityAssuranceData = response.result;
        _message = response.message;
        _status = response.status;

        authorizedInspectors = getRadiobuttonData(
            qualityAssuranceData
                .first.whoAuthorizedInspectMeasureFieldInspection,
            authorizedInspectorsMap);
        print('authorizedInspectors: $authorizedInspectors');

        commissioningProtocolFollowed = getRadiobuttonData(
            qualityAssuranceData.first.isCommissioningProtocolFollowed,
            yesNoMap);
        print('commissioningProtocolFollowed: $commissioningProtocolFollowed');

        commissioningPresence = getRadiobuttonData(
            qualityAssuranceData.first.duringCommissioningSchemesPresent,
            commissioningPresenceMap);
        print('commissioningPresence: $commissioningPresence');

        thirdPartyAssessment = getRadiobuttonData(
            qualityAssuranceData
                .first.hasDistrictUndertakenAssessmentInspectionAgencies,
            thirdPartyAssessmentMap);
        print('thirdPartyAssessment: $thirdPartyAssessment');
      } else {
        _message = response.message;
      }
    } catch (e) {
      GlobalExceptionHandler.handleException(e as Exception);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearfetchQualityAssuranceData() {
    authorizedInspectors = null;
    commissioningProtocolFollowed = null;
    commissioningPresence = null;
    thirdPartyAssessment = null;
  }

  // fetch for dwsm part E end

  ///FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF

  // 1. Grievance Mechanism Available - Radio
  String? _grievanceMechanismAvailable;

  String? get grievanceMechanismAvailable => _grievanceMechanismAvailable;

  set grievanceMechanismAvailable(String? value) {
    _grievanceMechanismAvailable = value;
    notifyListeners();
  }

  int get grievanceMechanismAvailableID =>
      yesNoMap[_grievanceMechanismAvailable] ?? -1;

// 2. Grievance Registration Methods - Multi Select

  final Map<String, int> grievanceRegistrationMethodsMap = {
    "Toll free number": 1,
    "Web based portal": 2,
    "Mobile application": 3,
    "Public grievance registration center": 4,
    "Directly calling to PHED/Contractor/O&M agency": 5
  };

  String? _grievanceRegistrationMethods;

  String? get grievanceRegistrationMethods => _grievanceRegistrationMethods;

  set grievanceRegistrationMethods(String? value) {
    _grievanceRegistrationMethods = value;
    notifyListeners();
  }

  int get grievanceRegistrationMethodsID =>
      grievanceRegistrationMethodsMap[_grievanceRegistrationMethods] ?? -1;

// 3. Complaints Received - Radio
  String? _complaintsReceived;

  String? get complaintsReceived => _complaintsReceived;

  set complaintsReceived(String? value) {
    _complaintsReceived = value;
    notifyListeners();
  }

  int get complaintsReceivedID => yesNoMap[_complaintsReceived] ?? -1;

// 3.1 Type of Complaints - Multi Select
  final Map<String, int> complaintTypeMap = {
    "Poor water quality": 1,
    "Incomplete connections": 2,
    "Delay in commissioning": 3,
    "No water supply": 4,
    "Faulty construction": 5,
    "Others": 6,
  };

  String? _complaintTypes;

  String? get complaintTypes => _complaintTypes;

  set complaintTypes(String? value) {
    _complaintTypes = value;
    notifyListeners();
  }

  int get complaintTypesID => complaintTypeMap[_complaintTypes] ?? -1;

  TextEditingController avgResolutionTimeController = TextEditingController();
  TextEditingController actionTakenController = TextEditingController();

  Future<void> saveGrievanceRedressal({
    required int userId,
    required int stateId,
    required int districtId,
    required int grievanceMechanismAvailable,
    required int howGrievancesRegistered,
    required int complaintsReceived,
    required int typeOfComplaints,
    required String otherComplaints,
    required int resolutionTime,
    required int actionTakenByDepartment,
    required int modeType,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _dwsmRepository.saveGrievanceRedressal(
        userId: userId,
        stateId: stateId,
        districtId: districtId,
        grievanceMechanismAvailable: grievanceMechanismAvailable,
        howGrievancesRegistered: howGrievancesRegistered,
        complaintsReceived: complaintsReceived,
        typeOfComplaints: typeOfComplaints,
        otherComplaints: otherComplaints,
        resolutionTime: resolutionTime,
        actionTakenByDepartment: actionTakenByDepartment,
        modeType: modeType
      );

      _message = response.message;
      _status = response.status;
    } catch (e) {
      _message = 'Something went wrong';
      GlobalExceptionHandler.handleException(e as Exception);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

// fetch for dwsm part F start

  List<PublicComplaintsGrievanceRedressal> grievanceData = [];

  Future<void> fetchGrievanceRedressalData(
      String stateId, String districtId, String userId,modeType) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _fetchdwsmrepo
          .fetchPublicComplaintsGrievanceRedressal(stateId, districtId, userId,modeType);
      if (response.status) {
        grievanceData = response.result;
        _message = response.message;
        _status = response.status;

        grievanceMechanismAvailable = getRadiobuttonData(
            grievanceData.first.grievanceRedressalMechanismAvailable, yesNoMap);
        print('grievanceMechanismAvailable: $grievanceMechanismAvailable');

        grievanceRegistrationMethods = getRadiobuttonData(
            grievanceData.first.howGrievancesRegisteredVillagers,
            grievanceRegistrationMethodsMap);
        print('grievanceRegistrationMethods: $grievanceRegistrationMethods');

        complaintsReceived = getRadiobuttonData(
            grievanceData.first.areComplaintsReceivedPublicRegardingSchemes,
            yesNoMap);
        print('complaintsReceived: $complaintsReceived');

        complaintTypes = getRadiobuttonData(
            grievanceData.first.yesTypeComplaints, complaintTypeMap);
        print('complaintTypes: $complaintTypes');

        avgResolutionTimeController.text = grievanceData
            .first.yesTypeComplaintsOthersAverageTimeResolution
            .toString();
        print(
            'avgResolutionTimeController: ${avgResolutionTimeController.text}');

        actionTakenController.text =
            grievanceData.first.yesTypeComplaintsOthersActionTakenDepartment;
        print('actionTakenController: ${actionTakenController.text}');
      } else {
        _message = response.message;
      }
    } catch (e) {
      GlobalExceptionHandler.handleException(e as Exception);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearfetchGrievanceRedressalData() {
    grievanceMechanismAvailable = null;
    grievanceRegistrationMethods = null;
    complaintsReceived = null;
    complaintTypes = null;

    avgResolutionTimeController.clear();
    actionTakenController.clear();
  }

// fetch for dwsm part F end

////Below 10%

//part D

//Q1
  final Map<String, int> fieldinspectionMap = {
    "PHED Engineer": 1,
    "PMC/PMU": 2,
    "TPIA": 3,
    "VWSC": 4,
    "Contractor Representative ": 5,
    "others": 6,
  };

  String? _fieldinspection;

  String? get fieldinspection => _fieldinspection;

  set fieldinspection(String? value) {
    _fieldinspection = value;
    notifyListeners();
  }

  int get fieldinspectionID => fieldinspectionMap[_fieldinspection] ?? -1;

  //Q2
  String? _commisionprotocol;

  String? get commisionprotocol => _commisionprotocol;

  set commisionprotocol(String? value) {
    _commisionprotocol = value;
    notifyListeners();
  }

  int get commisionprotocolID => yesNoMap[_commisionprotocol] ?? -1;

  //Q3
  String? _inspectionagencies;

  String? get inspectionagencies => _inspectionagencies;

  set inspectionagencies(String? value) {
    _inspectionagencies = value;
    notifyListeners();
  }

  int get inspectionagenciesID => yesNoMap[_inspectionagencies] ?? -1;

  // Part E

//Q1

  String? _GrievanceRedressalmechanism;

  String? get GrievanceRedressalmechanism => _GrievanceRedressalmechanism;

  set GrievanceRedressalmechanism(String? value) {
    _GrievanceRedressalmechanism = value;
    notifyListeners();
  }

  int get GrievanceRedressalmechanismID =>
      yesNoMap[_GrievanceRedressalmechanism] ?? -1;
}
