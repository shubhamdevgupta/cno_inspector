import 'package:cno_inspection/repository/dwsmRepo/DWSMRepositoy.dart';
import 'package:flutter/cupertino.dart';

class Dwsmprovider extends ChangeNotifier {
  final DWSMRepositoy _dwsmRepository = DWSMRepositoy();

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
    "No": 2,
  };

  //AAAAAAAAaaaaaaaaaa

  // Question 1: Are monthly meetings held?
  String? _selectedValueQ1;

  String? get selectedValueQ1 => _selectedValueQ1;

  set selectedValueQ1(String? val) {
    _selectedValueQ1 = val;
    notifyListeners();
  }

  int get selectedValueQ1Id => yesNoMap[_selectedValueQ1] ?? 0;

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

  int get selectedMeetingQualityID => meetingQualityMap[_selectedMeetingQuality] ?? 0;

  // Question 2: DISHA meetings being held
  String? _selectedDISHA;

  String? get selectedDISHA => _selectedDISHA;
  set selectedDISHA(String? val) {
    _selectedDISHA = val;
    notifyListeners();
  }

  int get selectedDISHAID => yesNoMap[_selectedDISHA] ?? 0;


  Future<bool> saveCoordinationPlanningReview({
    required int userId,
    required int stateId,
    required int districtId,
    required int areMonthlyMeetingsHeld,
    required int numberOfMeetingsLast6Months,
    required int qualityOfMeeting,
    required int areCoordinationMeetingsRegular,
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

  int get sourceSustainabilityId => sourceSustainabilityMap[_sourceSustainability] ?? 0;



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
  int get groundwaterProtectionId => groundwaterProtectionMap[_groundwaterProtection] ?? 0;

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

  int get rechargeStructureImplementedID => rechargeStructureMap[_rechargeStructureImplemented] ?? 0;



  // Controller for recharge reason (if "No")
  final TextEditingController rechargeReasonController = TextEditingController();

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
  int get impactStudiesID => impactStudiesMap[_impactStudies] ?? 0;

  Future<bool> saveSourceSustainability({
    required int userId,
    required int stateId,
    required int districtId,
    required int areSustainabilityMeasuresPromoted,
    required int areGWSourcesProtected,
    required int isRechargeStructureImplemented,
    required String reasonIfNotImplemented,
    required int areImpactStudiesConducted,
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
  int get assetsGeotaggedID => assetsGeotaggedMap[_assetsGeotagged] ?? 0;

// NABL-accredited lab availability
  String? _hasNablLab;
  String? get hasNablLab => _hasNablLab;
  set hasNablLab(String? value) {
    _hasNablLab = value;
    notifyListeners();
  }
  int get hasNablLabID => yesNoMap[_hasNablLab] ?? 0;

// Testing management (if no NABL lab)
  final TextEditingController testingManagedController = TextEditingController();


  Future<bool> saveMonitoringQualityLab({
    required int userId,
    required int stateId,
    required int districtId,
    required int areAssetsGeotagged,
    required int hasNABLLab,
    required String testingManagementDescription,
  }) async {
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

  int get handoverProtocolID => handoverProtocolMap[_handoverProtocol] ?? 0;

// 2. Manpower Percentage Controller
  final TextEditingController manpowerPercentController = TextEditingController();

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
  int get feeBasisID => feeBasisMap[_feeBasis] ?? 0;


// 5. User Fee Collection Percentage
  final TextEditingController userFeePercentController = TextEditingController();


  Future<bool> saveOperationMaintenance({
    required int userId,
    required int stateId,
    required int districtId,
    required int isProtocolInPlace,
    required double percentVillagesWithManpower,
    required int isWaterFeeCharged,
    required int feeAmountPerMonth,
    required int isUniformFee,
    required double percentVillagesFeeCollected,
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

  //EEEEEEEEEEEEEEEEEEEEEEE

  // 1. Authorized Inspectors - Multi Select

  final Map<String,int> authorizedInspectorsMap={
    "PHED Engineer":1,
    "PMC/PMU":2,
    "TPIA":3,
    "VWSC":4,
    "Contractor Representative":5,
    "Others":6
  };

  String? _authorizedInspectors;
  String? get authorizedInspectors => _authorizedInspectors;
  set authorizedInspectors(String? value) {
    _authorizedInspectors = value;
    notifyListeners();
  }

  int get authorizedInspectorID => authorizedInspectorsMap[_authorizedInspectors] ?? 0;

// 2. Commissioning Protocol Followed - Radio
  String? _commissioningProtocolFollowed;
  String? get commissioningProtocolFollowed => _commissioningProtocolFollowed;
  set commissioningProtocolFollowed(String? value) {
    _commissioningProtocolFollowed = value;
    notifyListeners();
  }

  int get commissioningProtocolFollowedID => yesNoMap[_commissioningProtocolFollowed] ?? 0;

// 3. Commissioning Presence - Multi Select

  final Map<String,int> commissioningPresenceMap={
    "PHED":1 ,
    "VWSC Members":2 ,
    "PRI Representatives": 3,
    "ISA":4 ,
    "TPIA": 5,
    "Community Members":6
  };
  String? _commissioningPresence;
  String? get commissioningPresence => _commissioningPresence;
  set commissioningPresence(String? value) {
    _commissioningPresence = value;
    notifyListeners();
  }
  int get commissioningPresenceID => commissioningPresenceMap[_commissioningPresence] ?? 0;


// 4. Third Party Assessment - Radio
  final Map<String,int> thirdPartyAssessmentMap={
    "Yes – Regularly":1,
    "Occasionally":2,
    "Not Done":3
  };

  String? _thirdPartyAssessment;
  String? get thirdPartyAssessment => _thirdPartyAssessment;
  set thirdPartyAssessment(String? value) {
    _thirdPartyAssessment = value;
    notifyListeners();
  }

  int get thirdPartyAssessmentID => thirdPartyAssessmentMap[_thirdPartyAssessment] ?? 0;

  Future<bool> saveQualityAssurance({
    required int userId,
    required int stateId,
    required int districtId,
    required int inspectionAuthority,
    required int isCommissioningProtocolFollowed,
    required int schemesPresentDuringCommissioning,
    required int districtAssessmentAgencies,
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

  ///FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF

  // 1. Grievance Mechanism Available - Radio
  String? _grievanceMechanismAvailable;
  String? get grievanceMechanismAvailable => _grievanceMechanismAvailable;
  set grievanceMechanismAvailable(String? value) {
    _grievanceMechanismAvailable = value;
    notifyListeners();
  }
  int get grievanceMechanismAvailableID => yesNoMap[_grievanceMechanismAvailable] ?? 0;


// 2. Grievance Registration Methods - Multi Select

  final Map<String,int> grievanceRegistrationMethodsMap={
    "Toll free number": 1,
    "Web based portal": 2,
    "Mobile application": 3,
    "Public grievance registration center": 4,
    "Directly calling to PHED/Contractor/O&M agency": 5
  };

  String? _grievanceRegistrationMethods ;
  String? get grievanceRegistrationMethods => _grievanceRegistrationMethods;
  set grievanceRegistrationMethods(String? value) {
    _grievanceRegistrationMethods = value;
    notifyListeners();
  }
  int get grievanceRegistrationMethodsID => grievanceRegistrationMethodsMap[_grievanceRegistrationMethods] ?? 0;


// 3. Complaints Received - Radio
  String? _complaintsReceived;
  String? get complaintsReceived => _complaintsReceived;
  set complaintsReceived(String? value) {
    _complaintsReceived = value;
    notifyListeners();
  }

  int get complaintsReceivedID => yesNoMap[_complaintsReceived] ?? 0;


// 3.1 Type of Complaints - Multi Select
  final Map<String,int> complaintTypeMap={
    "Poor water quality":1 ,
    "Incomplete connections": 2,
    "Delay in commissioning":3 ,
    "No water supply": 4,
    "Faulty construction": 5,
    "Others":6,
  };

  String? _complaintTypes;
  String? get complaintTypes => _complaintTypes;
  set complaintTypes(String? value) {
    _complaintTypes = value;
    notifyListeners();
  }

  int get complaintTypesID => complaintTypeMap[_complaintTypes] ?? 0;

  TextEditingController avgResolutionTimeController = TextEditingController();
  TextEditingController actionTakenController = TextEditingController();


  Future<bool> saveGrievanceRedressal({
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
