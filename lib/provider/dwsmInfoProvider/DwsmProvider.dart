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
  String? _rechargeStructureImplemented;
  String? get rechargeStructureImplemented => _rechargeStructureImplemented;
  set rechargeStructureImplemented(String? value) {
    _rechargeStructureImplemented = value;
    if (value != "No") {
      rechargeReasonController.clear();
    }
    notifyListeners();
  }

  // Controller for recharge reason (if "No")
  final TextEditingController rechargeReasonController = TextEditingController();

  // Question 4: Impact studies conducted
  String? _impactStudies;
  String? get impactStudies => _impactStudies;
  set impactStudies(String? value) {
    _impactStudies = value;
    notifyListeners();
  }



  Future<bool> saveSourceSustainability({
    required int userId,
    required int stateId,
    required int districtId,
    required int areSustainabilityMeasuresPromoted,
    required int areGWSourcesProtected,
    required int isRechargeStructureImplemented,
    required int reasonIfNotImplemented,
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
