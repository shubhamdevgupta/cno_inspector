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


  int? _villageId;

  int? get villageId => _villageId;

  void setVillageId(int id) {
    _villageId = id;
    notifyListeners();
  }

  int? _stateId;

  int? get stateId => _stateId;

  void setStateId(int id) {
    _stateId = id;
    notifyListeners();
  }

  // 1. Define the options map
  final Map<String, int> waterSupplyFrequencyMap = {
    "Daily": 1,
    "Once in two days": 2,
    "Once in three days": 3,
    "Irregular": 4,
    "Not functional": 5,
  };

  // 2. Expose just the labels for the UI

  List<String> get waterSupplyFrequencyOptions => waterSupplyFrequencyMap.keys.toList();


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



////////
  String? _selectedVWSCFormed; // Yes / No

  String? get selectedVWSCFormed => _selectedVWSCFormed;

  set selectedVWSCFormed(String? value) {
    _selectedVWSCFormed = value;
    notifyListeners();
  }

  //
  int get selectedVWSCFormedID => yesNoMap[_selectedVWSCFormed] ?? 0;



    String? _selectedVWSCBankAccount; // Yes / No

  String? get selectedVWSCBankAccount => _selectedVWSCBankAccount;

  set selectedVWSCBankAccount(String? value) {
    _selectedVWSCBankAccount = value;
    notifyListeners();
  }

  //
  int get selectedVWSCBankAccountID => yesNoMap[_selectedVWSCBankAccount] ?? 0;




    String? _selectedAsBuiltDrawing; // Yes / No

  String? get selectedAsBuiltDrawing => _selectedAsBuiltDrawing;

  set selectedAsBuiltDrawing(String? value) {
    _selectedAsBuiltDrawing = value;
    notifyListeners();
  }

  //
  int get selectedAsBuiltDrawingID => yesNoMap[_selectedAsBuiltDrawing] ?? 0;



  String? _selectedVWSCMeetingConducted; // Yes / No

  String? get selectedVWSCMeetingConducted => _selectedVWSCMeetingConducted;

  set selectedVWSCMeetingConducted(String? value) {
    _selectedVWSCMeetingConducted = value;
    notifyListeners();
  }

  //
  int get selectedVWSCMeetingConductedID => yesNoMap[_selectedAsBuiltDrawing] ?? 0;




  String? _selectedVWSCInvolvement; // Yes / No

  String? get selectedVWSCInvolvement => _selectedVWSCInvolvement;

  set selectedVWSCInvolvement(String? value) {
    _selectedVWSCInvolvement = value;
    notifyListeners();
  }
  //
  final Map<String, int> VwscGPInvolment = {
    "Active": 1,
    "Limited": 2,"No Involvement": 3,"VWSC not found": 4,
  };

  //
  int get selectedVWSCInvolvementID => VwscGPInvolment[_selectedVWSCInvolvement] ?? 0;


  String? _selectedVWSCRecordsAvailable; // Yes / No

  String? get selectedVWSCRecordsAvailable => _selectedVWSCRecordsAvailable;

  set selectedVWSCRecordsAvailable(String? value) {
    _selectedVWSCRecordsAvailable = value;
    notifyListeners();
  }


  //
  int get selectedVWSCRecordsAvailableID => yesNoMap[_selectedVWSCRecordsAvailable] ?? 0;



  String? _selectedVWSCOMInvolved; // Yes / No

  String? get selectedVWSCOMInvolved => _selectedVWSCOMInvolved;

  set selectedVWSCOMInvolved(String? value) {
    _selectedVWSCOMInvolved = value;
    notifyListeners();
  }


  final Map<String, int> VWSCOMInvolvedID = {
    "Active": 1,
    "Limited": 2,"No": 3,"Not Applicable": 4,
  };
  //
  int get selectedVWSCOMInvolvedID => VWSCOMInvolvedID[_selectedVWSCOMInvolved] ?? 0;


  String? _selectedSchemeHandover; // Yes / No

  String? get selectedSchemeHandover => _selectedSchemeHandover;

  set selectedSchemeHandover(String? value) {
    _selectedSchemeHandover = value;
    notifyListeners();
  }


  final Map<String, int> SchemeHandover = {
    "Yes": 1,
    "No": 2,"Not Applicable": 3,
  };
  //
  int get selectedSchemeHandoverID => SchemeHandover[_selectedSchemeHandover] ?? 0;



  String? _selectedOMArrangements; // Yes / No

  String? get selectedOMArrangements => _selectedOMArrangements;

  set selectedOMArrangements(String? value) {
    _selectedOMArrangements = value;
    notifyListeners();
  }


  final Map<String, int> OMArrangements = {
    "VWSC": 1,
    "PHED": 2,"Outsourced": 3,"No arrangement": 4,
  };
  //
  int get selectedOMArrangementsID => OMArrangements[_selectedOMArrangements] ?? 0;

  String? _selectedCommunityAwareness; // Yes / No

  String? get selectedCommunityAwareness => _selectedOMArrangements;

  set selectedCommunityAwareness(String? value) {
    _selectedCommunityAwareness = value;
    notifyListeners();
  }


  final Map<String, int> CommunityAwarenessID = {
    "Well informed": 1,
    "Some awareness": 2,"No awareness": 3
  };

  List<String> get CommunityAwarenessOptions => CommunityAwarenessID.keys.toList();

  //
  int get selectedCommunityAwarenessID => CommunityAwarenessID[_selectedCommunityAwareness] ?? 0;

  String? _selectedVWSCMeetingFrequency; // Yes / No

  String? get selectedVWSCMeetingFrequency => _selectedVWSCMeetingFrequency;

  set selectedVWSCMeetingFrequency(String? value) {
    _selectedVWSCMeetingFrequency = value;
    notifyListeners();
  }

  //
  final Map<String, int> VWSCMeetingFrequency = {
    "Weekly": 1,
    "Monthly": 2,"Quarterly": 3,"Other": 4,
  };
  int get selectedVWSCMeetingFrequencyID => VWSCMeetingFrequency[_selectedVWSCMeetingFrequency] ?? 0;




  String? _selectedWaterQualitySatisfaction; // Yes / No

  String? get selectedWaterQualitySatisfaction => _selectedWaterQualitySatisfaction;

  set selectedWaterQualitySatisfaction(String? value) {
    _selectedWaterQualitySatisfaction = value;
    notifyListeners();
  }

  //
  final Map<String, int> WaterQualitySatisfaction = {
    "Satisfied": 1,
    "Partially Satisfied": 2,"Dissatisfied": 3,"Not Interacted": 4,
  };
  int get selectedWaterQualitySatisfactionID => WaterQualitySatisfaction[_selectedWaterQualitySatisfaction] ?? 0;



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



  Map<String, int> ftkTestingFrequencyMap = {
    'Regularly tested': 1,
    'Occasionally': 2,
    'Not tested': 3,
    'No FTK': 4,
  };

  Map<String, int> frcLevelMap = {
    'Available': 1,
    'Occasionally': 2,
    'Not Available': 3,
    'Not Tested': 4,
  };


  // 1. FTK Availability
  String? _selectedFTKAvailability;
  String? get selectedFTKAvailability => _selectedFTKAvailability;
  set selectedFTKAvailability(String? value) {
    _selectedFTKAvailability = value;
    notifyListeners();
  }
  int get selectedFTKAvailabilityId => yesNoMap[_selectedFTKAvailability] ?? 0;

  // 2. FTK Testing Frequency
  String? _selectedFTKTestingFrequency;
  String? get selectedFTKTestingFrequency => _selectedFTKTestingFrequency;
  set selectedFTKTestingFrequency(String? value) {
    _selectedFTKTestingFrequency = value;
    notifyListeners();
  }
  int get selectedFTKTestingFrequencyId => ftkTestingFrequencyMap[_selectedFTKTestingFrequency] ?? 0;

  // 3. Women Trained in FTK Testing
  TextEditingController womenTrainedController=TextEditingController();

  // 4. Who is doing water quality testing
  TextEditingController testerNameController = TextEditingController();

  // 5. Disinfection Done
  String? _selectedDisinfectionDone;
  String? get selectedDisinfectionDone => _selectedDisinfectionDone;
  set selectedDisinfectionDone(String? value) {
    _selectedDisinfectionDone = value;
    notifyListeners();
  }
  int get selectedDisinfectionDoneId => yesNoMap[_selectedDisinfectionDone] ?? 0;

  // 6. FRC Level
  String? _selectedFRCLevel;
  String? get selectedFRCLevel => _selectedFRCLevel;
  set selectedFRCLevel(String? value) {
    _selectedFRCLevel = value;
    notifyListeners();
  }
  int get selectedFRCLevelId => frcLevelMap[_selectedFRCLevel] ?? 0;


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



  Map<String, int> turnAroundTimeMap = {
    'Same day': 1,
    'Two days': 2,
    'Three days': 3,
    'More than three days': 4,
  };

  final Map<String, int> grievanceRegistrationMethodMap = {
    "Toll free number": 1,
    "Web based portal": 2,
    "Mobile application": 3,
    "Public grievance registration center": 4,
    "Directly calling to PHED/Contractor/O&M agency": 5,
  };


// 7. Grievance redressal mechanism available
  String? _selectedGrievanceMechanism;
  String? get selectedGrievanceMechanism => _selectedGrievanceMechanism;
  set selectedGrievanceMechanism(String? value) {
    _selectedGrievanceMechanism = value;
    notifyListeners();
  }
  int get selectedGrievanceMechanismId => yesNoMap[_selectedGrievanceMechanism] ?? 0;

// 8. Grievance registration methods (multi-select)
  List<String> _selectedGrievanceMethods = [];

  List<String> get grievanceRegistrationMethods => _selectedGrievanceMethods;

  set grievanceRegistrationMethods(List<String> values) {
    _selectedGrievanceMethods = values;
    notifyListeners();
  }

// Expose selected IDs (mapped from selected labels)
  List<int> get selectedGrievanceMethodIds =>
      _selectedGrievanceMethods.map((e) => grievanceRegistrationMethodMap[e] ?? 0).toList();


// 9. Turn around time for grievance
  String? _selectedTurnAroundTime;
  String? get selectedTurnAroundTime => _selectedTurnAroundTime;
  set selectedTurnAroundTime(String? value) {
    _selectedTurnAroundTime = value;
    notifyListeners();
  }
  int get selectedTurnAroundTimeId => turnAroundTimeMap[_selectedTurnAroundTime] ?? 0;

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
