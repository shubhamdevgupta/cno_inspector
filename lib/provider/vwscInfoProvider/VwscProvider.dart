import 'package:cno_inspection/model/BaseResponse.dart';
import 'package:cno_inspection/model/BaseResponseModel.dart';
import 'package:flutter/cupertino.dart';

import '../../repository/vwscInfoRepo/VwscRepository.dart';

class Vwscprovider extends ChangeNotifier {
  final VwscRepository _vwscRepository = VwscRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _message;
  String? get message => _message;
  bool? _status;
  bool? get status => _status;

  BaseResponse? baseResponse;


  // 1. Define the options map
  final Map<String, int> waterSupplyFrequencyMap = {
    "Daily": 1,
    "Once in two days": 2,
    "Once in three days": 3,
    "Irregular": 4,
    "Not functional": 5,
  };

  // 2. Expose just the labels for the UI
  List<String> get waterSupplyFrequencyOptions =>
      waterSupplyFrequencyMap.keys.toList();

  // 3. Track selected labels
  List<String> _selectedFrequencyLabels = [];

  List<String> get selectedFrequency => _selectedFrequencyLabels;

  set selectedFrequency(List<String> values) {
    _selectedFrequencyLabels = values;
    notifyListeners();
  }

  // 4. Convert selected labels to their mapped integer values (for API)
  List<int> get selectedFrequencyIds => _selectedFrequencyLabels
      .map((label) => waterSupplyFrequencyMap[label])
      .whereType<int>()
      .toList();

  // Yes/No options with mappings
  // question 2222222222222222
  final Map<String, int> yesNoMap = {
    "Yes": 1,
    "No": 2,
  };

  List<String> get yesNoOptions => yesNoMap.keys.toList();

  // Selected value for household water adequacy (label)
  String? _selectedHouseholdWater;
  String? get selectedHouseholdWater => _selectedHouseholdWater;

  set selectedHouseholdWater(String? value) {
    _selectedHouseholdWater = value;
    notifyListeners();
  }
  // Get mapped ID
  int get selectedHouseholdWaterId => yesNoMap[_selectedHouseholdWater] ?? 0;

  // question 2222222222222222

  // question 33333
  String? _selectedPvtgGroups;
  String? get selectedPvtgGroups => _selectedPvtgGroups;

  set selectedPvtgGroups(String? value) {
    _selectedPvtgGroups = value;
    notifyListeners();
  }
  TextEditingController reasonRemoteGroupsController = TextEditingController();

  int get selectedPvtgGroupsId => yesNoMap[_selectedPvtgGroups] ?? 0;

  // question 33333



///// ques 44444444444
  final Map<String, int> tailEndMap ={
    "Yes – Consistently": 1,
    "Occasionally": 2,
    "No": 3,
    "Not Verified": 4,
  };
  List<String> get tailEndOptions => tailEndMap.keys.toList();

  String? _selectedTailEnd;
  String? get selectedTailEnd => _selectedTailEnd;

  set selectedTailEnd(String? value) {
    _selectedTailEnd = value;
    notifyListeners();
  }
  int get selectedTailEndId => tailEndMap[_selectedTailEnd] ?? 0;
  /// 4444444444


  //// ques 5555555555555555555

  final Map<String, int> schemeStatusMap = {
    "Fully operational >3 months": 1,
    "Operational but with interruptions": 2,
    "Non-functional": 3,
    "Partially commissioned": 4,
  };

  List<String> get schemeStatusOptions => schemeStatusMap.keys.toList();

  String? _selectedschemeStatus;
  String? get selectedschemeStatus => _selectedschemeStatus;

  set selectedschemeStatus(String? value) {
    _selectedschemeStatus = value;
    notifyListeners();
  }

  int get selectedschemeStatusId => schemeStatusMap[_selectedschemeStatus] ?? 0;

  //// ques 5555555555555555555

// que 6666666666666666666666666

  final Map<String, int> institutionsMap = {
    "Schools": 1,
    "Anganwadi’s": 2,
    "PHCs": 3,
    "Not Applicable": 4,
  };
  List<String> get institutionsOptions => institutionsMap.keys.toList();

  List<String> _selectedinstitutions = [];
  List<String> get selectedinstitutions => _selectedinstitutions;

  set selectedinstitutions(List<String> values) {
    _selectedinstitutions = values;
    notifyListeners();
  }

  List<int> get selectedinstitutionsIds => _selectedinstitutions
      .map((label) => institutionsMap[label])
      .whereType<int>()
      .toList();

// que 6666666666666666666666666





  Future<bool> saveVwscWaterSupply({
    required int userId,
    required int stateId,
    required int villageId,
    required int waterSupplyFrequency,
    required int adequateWaterToHH,
    required int adequateWaterToRemote,
    required String remoteReason,
    required int tailEndWaterReach,
    required int schemeOperationalStatus,
    required List<int> pwsReachInstitutions,
    required int createdBy,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _vwscRepository.saveVwscWaterSupply(
        userId: userId,
        stateId: stateId,
        villageId: villageId,
        waterSupplyFrequency: waterSupplyFrequency,
        adequateWaterToHH: adequateWaterToHH,
        adequateWaterToRemote: adequateWaterToRemote,
        remoteReason: remoteReason,
        tailEndWaterReach: tailEndWaterReach,
        schemeOperationalStatus: schemeOperationalStatus,
        pwsReachInstitutions: pwsReachInstitutions,
        createdBy: createdBy,
      );
      _message = response.message;
      _status=response.status;
      return response.status ?? false;
    } catch (e) {
      _message = 'Something went wrong';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // vwsc_provider.dart (add this inside your provider)
  Future<bool> saveVwscCommunityInvolvement({
    required int userId,
    required int stateId,
    required int villageId,
    required int isPaniSamitiFormed,
    required int isVwscBankAccount,
    required int vwscGpInvolvementScheme,
    required int drawingPipelineAvlGpOffice,
    required int isVwscMeetingPeriodic,
    required String meetingHeldFrequency,
    required int isVwscMeetingRecordAvl,
    required int vwscInvolvementOM,
    required int schemeHandedOverGp,
    required int omArrangement,
    required int communityAwareness,
    required int communitySatisfactionWithWq,
    required int createdBy,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _vwscRepository.saveVwscCommunityInvolvement(
        userId: userId,
        stateId: stateId,
        villageId: villageId,
        isPaniSamitiFormed: isPaniSamitiFormed,
        isVwscBankAccount: isVwscBankAccount,
        vwscGpInvolvementScheme: vwscGpInvolvementScheme,
        drawingPipelineAvlGpOffice: drawingPipelineAvlGpOffice,
        isVwscMeetingPeriodic: isVwscMeetingPeriodic,
        meetingHeldFrequency: meetingHeldFrequency,
        isVwscMeetingRecordAvl: isVwscMeetingRecordAvl,
        vwscInvolvementOM: vwscInvolvementOM,
        schemeHandedOverGp: schemeHandedOverGp,
        omArrangement: omArrangement,
        communityAwareness: communityAwareness,
        communitySatisfactionWithWq: communitySatisfactionWithWq,
        createdBy: createdBy,
      );

      _message = response.message;
      return response.status ?? false;
    } catch (e) {
      _message = 'Something went wrong';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> saveCommunityFeedback({
    required int userId,
    required int stateId,
    required int villageId,
    required int anyComplaintByCommunity,
    required int isComplaintAddressed,
    required List<int> complaintType,
    required int createdBy,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _vwscRepository.saveCommunityFeedback(
        userId: userId,
        stateId: stateId,
        villageId: villageId,
        anyComplaintByCommunity: anyComplaintByCommunity,
        isComplaintAddressed: isComplaintAddressed,
        complaintType: complaintType,
        createdBy: createdBy,
      );
      _message = response.message;
      _status=response.status;
      return response.status ?? false;
    } catch (e) {
      _message = 'Something went wrong';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> saveWaterQualityMonitoring({
    required int userId,
    required int stateId,
    required int villageId,
    required int isFtkAvailable,
    required int ftkTestingPeriod,
    required int numberWomenTrainedFtk,
    required String whoTestFtk,
    required int isChlorinationDone,
    required int frcAvailableAtEnd,
    required int createdBy,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _vwscRepository.saveWaterQualityMonitoring(
        userId: userId,
        stateId: stateId,
        villageId: villageId,
        isFtkAvailable: isFtkAvailable,
        ftkTestingPeriod: ftkTestingPeriod,
        numberWomenTrainedFtk: numberWomenTrainedFtk,
        whoTestFtk: whoTestFtk,
        isChlorinationDone: isChlorinationDone,
        frcAvailableAtEnd: frcAvailableAtEnd,
        createdBy: createdBy,
      );

      _message = response.message;
      return response.status ?? false;
    } catch (e) {
      _message = 'Something went wrong';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> saveGrievanceRedressal({
    required int userId,
    required int stateId,
    required int villageId,
    required int grievanceMechanismAvailable,
    required int grievanceTurnAroundTime,
    required List<int> registrationTypes,
    required int createdBy,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _vwscRepository.saveGrievanceRedressal(
        userId: userId,
        stateId: stateId,
        villageId: villageId,
        grievanceMechanismAvailable: grievanceMechanismAvailable,
        grievanceTurnAroundTime: grievanceTurnAroundTime,
        registrationTypes: registrationTypes,
        createdBy: createdBy,
      );

      _message = response.message;
      return response.status ?? false;
    } catch (e) {
      _message = 'Something went wrong';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  ///// ques c 1111111
  final Map<String, int> complainByCommunityOptMap ={
    "Yes": 1,
    "No": 2,
    "Not Known": 3,
  };
  List<String> get complainByCommunityOption => complainByCommunityOptMap.keys.toList();

  String? _selectedComplaintByCommunity;
  String? get selectedComplaintByCommunity => _selectedComplaintByCommunity;

  set selectedComplaintByCommunity(String? value) {
    _selectedComplaintByCommunity = value;
    notifyListeners();
  }

  int get selectedComplaintByCommunityId => complainByCommunityOptMap[_selectedComplaintByCommunity] ?? 0;

/// 11111111

  ///////////33333333333/////////////

  final Map<String, int> whereComplaintAddressOptMap ={
    "Yes": 1,
    "No": 2,
    "Partially": 3,
  };
  List<String> get whereComplaintAddressOpt => whereComplaintAddressOptMap.keys.toList();

  String? _selectedWhereComplaintAddressOpt;
  String? get selectedWhereComplaintAddress => _selectedWhereComplaintAddressOpt;

  set SetSelectedWhereComplaintAddress(String? value) {
    _selectedWhereComplaintAddressOpt = value;
    notifyListeners();
  }

  int get selectedWhereComplaintAddressOptId => whereComplaintAddressOptMap[_selectedWhereComplaintAddressOpt] ?? 0;


  ///////////33333333333/////////////

  /// 222222222
  final Map<String, int> typeOfComplaintMap = {
    "Substandard material": 1,
    "Poor workmanship": 2,
    "Leakages": 3,
    "Contamination": 4,
    "Incomplete structures": 5,
    "No water": 6,
    "Water discoloration": 7,
    "Others": 8,
  };

  List<String> get typeOfComplaintMapOptions => typeOfComplaintMap.keys.toList();

  List<String> _typeOfComplaintLabels = [];

  List<String> get selectedTypeOfComplaint => _typeOfComplaintLabels;

  set selectedTypeOfComplaint(List<String> values) {
    _typeOfComplaintLabels = values;
    notifyListeners();
  }

  // 4. Convert selected labels to their mapped integer values (for API)
  List<int> get selectedTypeOfComplaintIds => _typeOfComplaintLabels
      .map((label) => typeOfComplaintMap[label])
      .whereType<int>()
      .toList();

//

}
