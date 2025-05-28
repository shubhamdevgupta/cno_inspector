import 'package:cno_inspection/model/BaseResponse.dart';
import 'package:cno_inspection/repository/vwscInfoRepo/fetchVwscRepo.dart';
import 'package:flutter/cupertino.dart';

import '../../model/vwscPartC/CommunityFeedbackPartCResponse.dart';
import '../../model/vwscPartC/CommunityInvolmentPartBResponse.dart';
import '../../model/vwscPartC/VwscGrievancePartEResponse.dart';
import '../../model/vwscPartC/WaterQualityPartAResponse.dart';
import '../../model/vwscPartC/WaterQualityPartDResponse.dart';
import '../../repository/vwscInfoRepo/VwscRepository.dart';
import '../../utils/GlobalExceptionHandler.dart';

class Vwscprovider extends ChangeNotifier {
  final VwscRepository _vwscRepository = VwscRepository();
  final Fetchvwscrepo _fetchvwscrepo = Fetchvwscrepo();

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
  final Map<String, int> FrequencyLabels = {
    "Daily": 1,
    "Once in two days": 2,
    "Once in three days": 3,
    "Irregular": 4,
    "Not functional": 5,
  };

  List<String> get FrequencyLabelOption => FrequencyLabels.keys.toList();

  // 2. Expose just the labels for the UI

  String? _selectedFrequencyLabels;

  String? get selectedFrequency => _selectedFrequencyLabels;

  // 3. Track selected labels

  set selectedFrequency(String? values) {
    _selectedFrequencyLabels = values;
    notifyListeners();
  }

  int get selectedFrequencyID => FrequencyLabels[_selectedFrequencyLabels] ?? -1;

  // 4. Convert selected labels to their mapped integer values (for API)

  // Yes/No options with mappings
  // question 2222222222222222
  final Map<String, int> yesNoMap = {
    "Yes": 1,
    "No": 0,
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
  int get selectedVWSCFormedID => yesNoMap[_selectedVWSCFormed] ?? -1;

  String? _selectedVWSCBankAccount; // Yes / No

  String? get selectedVWSCBankAccount => _selectedVWSCBankAccount;

  set selectedVWSCBankAccount(String? value) {
    _selectedVWSCBankAccount = value;
    notifyListeners();
  }

  //
  int get selectedVWSCBankAccountID => yesNoMap[_selectedVWSCBankAccount] ?? -1;

  String? _selectedAsBuiltDrawing; // Yes / No

  String? get selectedAsBuiltDrawing => _selectedAsBuiltDrawing;

  set selectedAsBuiltDrawing(String? value) {
    _selectedAsBuiltDrawing = value;
    notifyListeners();
  }

  //
  int get selectedAsBuiltDrawingID => yesNoMap[_selectedAsBuiltDrawing] ?? -1;

  String? _selectedVWSCMeetingConducted; // Yes / No

  String? get selectedVWSCMeetingConducted => _selectedVWSCMeetingConducted;

  set selectedVWSCMeetingConducted(String? value) {
    _selectedVWSCMeetingConducted = value;
    notifyListeners();
  }

  //
  int get selectedVWSCMeetingConductedID =>
      yesNoMap[_selectedVWSCMeetingConducted] ?? -1;

  TextEditingController FrequencyController = TextEditingController();

  String? _selectedVWSCInvolvement; // Yes / No

  String? get selectedVWSCInvolvement => _selectedVWSCInvolvement;

  set selectedVWSCInvolvement(String? value) {
    _selectedVWSCInvolvement = value;
    notifyListeners();
  }

  //
  final Map<String, int> VwscGPInvolment = {
    "Active": 1,
    "Limited": 2,
    "No Involvement": 3,
    "VWSC not found": 4,
  };

  List<String> get VwscGPInvolmentOptions => VwscGPInvolment.keys.toList();

  //
  int get selectedVWSCInvolvementID =>
      VwscGPInvolment[_selectedVWSCInvolvement] ?? -1;

  String? _selectedVWSCRecordsAvailable; // Yes / No

  String? get selectedVWSCRecordsAvailable => _selectedVWSCRecordsAvailable;

  set selectedVWSCRecordsAvailable(String? value) {
    _selectedVWSCRecordsAvailable = value;
    notifyListeners();
  }

  //
  int get selectedVWSCRecordsAvailableID =>
      yesNoMap[_selectedVWSCRecordsAvailable] ?? -1;

  String? _selectedVWSCOMInvolved; // Yes / No

  String? get selectedVWSCOMInvolved => _selectedVWSCOMInvolved;

  set selectedVWSCOMInvolved(String? value) {
    _selectedVWSCOMInvolved = value;
    notifyListeners();
  }

  final Map<String, int> VWSCOMInvolvedID = {
    "Active": 1,
    "Limited": 2,
    "No": 3,
    "Not Applicable": 4,
  };

  //
  int get selectedVWSCOMInvolvedID =>
      VWSCOMInvolvedID[_selectedVWSCOMInvolved] ?? -1;

  String? _selectedSchemeHandover; // Yes / No

  String? get selectedSchemeHandover => _selectedSchemeHandover;

  set selectedSchemeHandover(String? value) {
    _selectedSchemeHandover = value;
    notifyListeners();
  }

  final Map<String, int> SchemeHandover = {
    "Yes": 1,
    "No": 2,
    "Not Applicable": 3,
  };

  List<String> get SchemeHandoverOptions => SchemeHandover.keys.toList();

  //
  int get selectedSchemeHandoverID =>
      SchemeHandover[_selectedSchemeHandover] ?? -1;

  String? _selectedOMArrangements; // Yes / No

  String? get selectedOMArrangements => _selectedOMArrangements;

  set selectedOMArrangements(String? value) {
    _selectedOMArrangements = value;
    notifyListeners();
  }

  final Map<String, int> OMArrangements = {
    "VWSC": 1,
    "PHED": 2,
    "Outsourced": 3,
    "No arrangement": 4,
  };

  List<String> get OMArrangementsOptions => OMArrangements.keys.toList();

  //
  int get selectedOMArrangementsID =>
      OMArrangements[_selectedOMArrangements] ?? -1;

  String? _selectedCommunityAwareness; // Yes / No

  String? get selectedCommunityAwareness => _selectedCommunityAwareness;

  set selectedCommunityAwareness(String? value) {
    _selectedCommunityAwareness = value;
    notifyListeners();
  }

  final Map<String, int> CommunityAwarenessID = {
    "Well informed": 1,
    "Some awareness": 2,
    "No awareness": 3
  };

  List<String> get CommunityAwarenessOptions =>
      CommunityAwarenessID.keys.toList();

  //
  int get selectedCommunityAwarenessID =>
      CommunityAwarenessID[_selectedCommunityAwareness] ?? -1;

  String? _selectedVWSCMeetingFrequency; // Yes / No

  String? get selectedVWSCMeetingFrequency => _selectedVWSCMeetingFrequency;

  set selectedVWSCMeetingFrequency(String? value) {
    _selectedVWSCMeetingFrequency = value;
    notifyListeners();
  }

  //
  final Map<String, int> VWSCMeetingFrequency = {
    "Weekly": 1,
    "Monthly": 2,
    "Quarterly": 3,
    "Other": 4,
  };

  int get selectedVWSCMeetingFrequencyID =>
      VWSCMeetingFrequency[_selectedVWSCMeetingFrequency] ?? -1;

  String? _selectedWaterQualitySatisfaction; // Yes / No

  String? get selectedWaterQualitySatisfaction =>
      _selectedWaterQualitySatisfaction;

  set selectedWaterQualitySatisfaction(String? value) {
    _selectedWaterQualitySatisfaction = value;
    notifyListeners();
  }

  //
  final Map<String, int> WaterQualitySatisfaction = {
    "Satisfied": 1,
    "Partially Satisfied": 2,
    "Dissatisfied": 3,
    "Not Interacted": 4,
  };

  List<String> get WaterQualitySatisfactionOptions =>
      WaterQualitySatisfaction.keys.toList();

  int get selectedWaterQualitySatisfactionID =>
      WaterQualitySatisfaction[_selectedWaterQualitySatisfaction] ?? -1;

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

  int get selectedPvtgGroupsId => yesNoMap[_selectedPvtgGroups] ?? -1;

  // question 33333

///// ques 44444444444
  final Map<String, int> tailEndMap = {
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

  int get selectedTailEndId => tailEndMap[_selectedTailEnd] ?? -1;

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

  int get selectedschemeStatusId => schemeStatusMap[_selectedschemeStatus] ?? -1;

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
 final Map<String, int> vwscBelowPartAQues2Map = {
     'JJM new':1,
     'JJM Retrofitted':2,
     'NRDWP':3,
     'State Scheme':4,
     'No scheme':5,
 };

 final Map<String, int> vwscBelowPartAQues3Map = {
     'Meeting daily needs throughout the year':1,
     'Meeting daily needs partly in the year':2,
     'Not able to meet daily needs:':3
 };

  // below 10%  start
  String? _selectedOption1_belowPartA;
  String? _selectedOption2_belowPartA;
  String? _selectedOption3_belowPartA;
  String? _selectedOption5_belowPartA;
  String? _selectedOption6_belowPartA;

  String? get selectedOption1_belowPartA => _selectedOption1_belowPartA;
  String? get selectedOption2_belowPartA => _selectedOption2_belowPartA;
  String? get selectedOption3_belowPartA => _selectedOption3_belowPartA;
  String? get selectedOption5_belowPartA => _selectedOption5_belowPartA;
  String? get selectedOption6_belowPartA => _selectedOption6_belowPartA;

  int get selectedOption1_belowPartAID => yesNoMap[_selectedOption1_belowPartA] ?? -1;
  int get selectedOption2_belowPartAID => vwscBelowPartAQues2Map[_selectedOption2_belowPartA] ?? -1;
  int get selectedOption3_belowPartAID => vwscBelowPartAQues3Map[_selectedOption3_belowPartA] ?? -1;
  int get selectedOption5_belowPartAID => yesNoMap[_selectedOption5_belowPartA] ?? -1;
 int get selectedOption6_belowPartAID => yesNoMap[_selectedOption6_belowPartA] ?? -1;

  set selectedOption1_belowPartA(String? value) {
    _selectedOption1_belowPartA = value;
    notifyListeners();
  }
  set selectedOption2_belowPartA(String? value) {
    _selectedOption2_belowPartA = value;
    notifyListeners();
  }
  set selectedOption3_belowPartA(String? value) {
    _selectedOption3_belowPartA = value;
    notifyListeners();
  }

  set selectedOption5_belowPartA(String? value) {
    _selectedOption5_belowPartA = value;
    notifyListeners();
  }
  set selectedOption6_belowPartA(String? value) {
    _selectedOption6_belowPartA = value;
    notifyListeners();
  }

  TextEditingController householdPercentageController = TextEditingController();
  TextEditingController reasonsController = TextEditingController();
  TextEditingController PartAVWSCuserObservationController = TextEditingController();
  // below 10%  end

  Future<void> saveVwscWaterSupply({
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


    // New Parameters
    required int phyStatus,
    required int isPipedWaterSupplyScheme,
    required int typeOfSchemeCommissioned,
    required String schemeBeneficiaryHouseholds,
    required int presentStatusOfWaterSupplySchemes,
    required int waterSupplyFrequencyAssured,
    required int remoteGroupsPlanned,
    required String remoteGroupsPlannedDetails,
    required String observationWaterSupplyFunctionality,
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


        // Pass new parameters
        phyStatus: phyStatus,
        isPipedWaterSupplyScheme: isPipedWaterSupplyScheme,
        typeOfSchemeCommissioned: typeOfSchemeCommissioned,
        schemeBeneficiaryHouseholds: schemeBeneficiaryHouseholds,
        presentStatusOfWaterSupplySchemes: presentStatusOfWaterSupplySchemes,
        waterSupplyFrequencyAssured: waterSupplyFrequencyAssured,
        remoteGroupsPlanned: remoteGroupsPlanned,
        remoteGroupsPlannedDetails: remoteGroupsPlannedDetails,
        observationWaterSupplyFunctionality: observationWaterSupplyFunctionality,
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


  /// get api for que 111

  List<WaterSupplyFunctionality> waterSupplyData = [];

  Future<void> fetchWaterSupply(
      String stateId, String villageId, String userId, int phystatus) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _fetchvwscrepo.fetchWaterSupplyFunctionality(
          stateId, villageId, userId, phystatus);
      if (response.status) {
        waterSupplyData = response.result;

        selectedFrequency = getRadiobuttonData(waterSupplyData.first.waterSupplyFrequency,FrequencyLabels);
        print('selectedFrequency: $selectedFrequency');

        selectedHouseholdWater =
            getRadiobuttonData(waterSupplyData.first.isAdequateWaterQuantityReachToHh,yesNoMap);
        print('selectedHouseholdWater: $selectedHouseholdWater');

        selectedPvtgGroups =
            getRadiobuttonData(waterSupplyData.first.isAdequateWaterQuantityReachToRemote,yesNoMap);
        print('selectedPvtgGroups: $selectedPvtgGroups');

        reasonRemoteGroupsController.text = waterSupplyData.first.isAdequateWaterQuantityReachToRemoteReason;
        print('reasonRemoteGroupsController: ${reasonRemoteGroupsController.text}');

        selectedTailEnd = getRadiobuttonData(waterSupplyData.first.whetherWaterReachToTailEnd,tailEndMap);
        print('selectedTailEnd: $selectedTailEnd');

        selectedschemeStatus = getRadiobuttonData(waterSupplyData.first.schemeOperationalStatusCommissioning,schemeStatusMap);
        print('selectedschemeStatus: $selectedschemeStatus');

        selectedinstitutions = getCheckBoxData(waterSupplyData.first.whetherPwsReachAllSchoolAnganwadiPhc,institutionsMap);
        print('selectedinstitutions: $selectedinstitutions');


        //New Field



        selectedOption1_belowPartA = getRadiobuttonData(waterSupplyData.first.isThereAnyPipedWaterSupplySchemeInTheVillage,yesNoMap);
        print('selectedOption1_belowPartA: $selectedOption1_belowPartA');

        selectedOption2_belowPartA = getRadiobuttonData(waterSupplyData.first.whatIsTheTypeOfSchemePresentlyCommissioned,vwscBelowPartAQues2Map);
        print('selectedOption2_belowPartA: $selectedOption2_belowPartA');

        householdPercentageController.text = waterSupplyData.first.ifSchemeIsCommissionedHowManyHouseholdsAreBeingBenefitted;
        print('householdPercentageController: ${householdPercentageController.text}');

        selectedOption3_belowPartA = getRadiobuttonData(waterSupplyData.first.whatIsThePresentStatusOfWaterSupplySchemes,vwscBelowPartAQues3Map);
        print('selectedOption3_belowPartA: $selectedOption3_belowPartA');


        selectedOption5_belowPartA = getRadiobuttonData(waterSupplyData.first.remoteGroupsPlanned,yesNoMap);
        print('selectedOption5_belowPartA: $selectedOption5_belowPartA');

        reasonsController.text = waterSupplyData.first.remoteGroupsPlannedDetails;
        print('reasonsController: ${reasonsController.text}');

        PartAVWSCuserObservationController.text = waterSupplyData.first.remoteGroupsPlannedDetails;
        print('PartAVWSCuserObservationController: ${PartAVWSCuserObservationController.text}');





        notifyListeners();
        _message = '';
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
  void clearValuesforqueA() {
    selectedFrequency = null;
    selectedHouseholdWater = null;
    selectedPvtgGroups = null;
    reasonRemoteGroupsController.clear();
    selectedTailEnd = null;
    selectedschemeStatus = null;
    selectedinstitutions = [];
    //below 10 % content clear

    selectedOption1_belowPartA = null;
    selectedOption2_belowPartA = null;
    selectedOption3_belowPartA = null;
    selectedOption5_belowPartA = null;
    selectedOption6_belowPartA = null;
    householdPercentageController.clear();
    reasonsController.clear();
    PartAVWSCuserObservationController.clear();

    notifyListeners();
  }




  /// get api for que 111
  /// get api for que 222

  List<CommunityInvolvement> communityInvolvementData = [];

  Future<void> fetchCommunityInvolvement(String stateId, String villageId, String userId, int phystatus) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _fetchvwscrepo.fetchCommunityInvolvement(stateId, villageId, userId, phystatus);
      if (response.status) {
        communityInvolvementData = response.result;
        selectedVWSCFormed = getRadiobuttonData(communityInvolvementData.first.isPaniSamitiFormed,yesNoMap);
        print('selectedVWSCFormed: $selectedVWSCFormed');

        selectedVWSCBankAccount = getRadiobuttonData(communityInvolvementData.first.isVwscBankAccount,yesNoMap);
        print('selectedVWSCBankAccount: $selectedVWSCBankAccount');


        selectedVWSCInvolvement = getRadiobuttonData(communityInvolvementData.first.vwscGpInvolvementScheme,VwscGPInvolment);
        print('selectedVWSCInvolvement: $selectedVWSCInvolvement');

        selectedAsBuiltDrawing = getRadiobuttonData(communityInvolvementData.first.drawingPipelineAvlGpOffice,yesNoMap);
        print('selectedAsBuiltDrawing: $selectedAsBuiltDrawing');

        selectedVWSCMeetingConducted = getRadiobuttonData(communityInvolvementData.first.isVwscMeetingPeriodicManner,yesNoMap);
        print('selectedVWSCMeetingConducted: $selectedVWSCMeetingConducted');


        FrequencyController.text = communityInvolvementData.first.meetingHeldYesFrequency;
        print('FrequencyController: ${FrequencyController.text}');



        selectedVWSCRecordsAvailable = getRadiobuttonData(communityInvolvementData.first.isVwscMeetingRecordAvl,yesNoMap);
        print('selectedVWSCMeetingConducted: $selectedVWSCRecordsAvailable');

        selectedVWSCOMInvolved = getRadiobuttonData(communityInvolvementData.first.vwscInvolvementOm,VWSCOMInvolvedID);
        print('selectedVWSCMeetingConducted: $selectedVWSCOMInvolved');

        selectedSchemeHandover = getRadiobuttonData(communityInvolvementData.first.schemeHandedOverGp,SchemeHandover);
        print('selectedSchemeHandover: $selectedSchemeHandover');

        selectedOMArrangements = getRadiobuttonData(communityInvolvementData.first.omArrangement,OMArrangements);
        print('selectedOMArrangements: $selectedOMArrangements');

        selectedCommunityAwareness = getRadiobuttonData(communityInvolvementData.first.communityAwareness,CommunityAwarenessID);
        print('selectedOMArrangements: $selectedCommunityAwareness');

        selectedWaterQualitySatisfaction = getRadiobuttonData(communityInvolvementData.first.communitySatisfactionWithWq,WaterQualitySatisfaction);
        print('selectedWaterQualitySatisfaction: $selectedWaterQualitySatisfaction');

        PartBVWSCuserObservationController.text = communityInvolvementData.first.meetingHeldYesFrequency;
        print('PartBVWSCuserObservationController: ${PartBVWSCuserObservationController.text}');


        communityInvolvementData = response.result;
        _message = '';
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

  void clearCommunityInvolvementData() {
    // Clear selected radio button values
    selectedVWSCFormed = null;
    selectedVWSCBankAccount = null;
    selectedVWSCInvolvement = null;
    selectedAsBuiltDrawing = null;
    selectedVWSCMeetingConducted = null;
    selectedVWSCRecordsAvailable = null;
    selectedVWSCOMInvolved = null;
    selectedSchemeHandover = null;
    selectedOMArrangements = null;
    selectedCommunityAwareness = null;
    selectedWaterQualitySatisfaction = null;

    // Clear frequency text field
    FrequencyController.clear();

    notifyListeners();
  }

  /// get api for que 222

  Future<void> saveVwscCommunityInvolvement({
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

    required int phyStatus,
    required String observationCommunityInvolvementFunctionality
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
       phyStatus: phyStatus,
        ObservationCommunityInvolvementFunctionality: observationCommunityInvolvementFunctionality

      );
      _status = response.status;
      _message = response.message;
    } catch (e) {
      _message = 'Something went wrong';
      GlobalExceptionHandler.handleException(e as Exception);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  /// get api for que 33
  List<CommunityFeedback> communityFeedbackData = [];

  Future<void> fetchCommunityFeedback(String stateId, String villageId, String userId, int phystatus) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _fetchvwscrepo.fetchCommunityFeedback(stateId, villageId, userId, phystatus);
      if (response.status) {

        communityFeedbackData = response.result;
        _message = '';

        selectedComplaintByCommunity = getRadiobuttonData(communityFeedbackData.first.anyComplaintByCommunity,complainByCommunityOptMap);
        print('selectedComplaintByCommunity: $selectedComplaintByCommunity');

        selectedTypeOfComplaint = getCheckBoxData(communityFeedbackData.first.complaintType,typeOfComplaintMap);
        print('selectedTypeOfComplaint: $selectedTypeOfComplaint');


        SetSelectedWhereComplaintAddress = getRadiobuttonData(communityFeedbackData.first.isComplaintAddressed,whereComplaintAddressOptMap);
     /*   print('selectedComplaintByCommunity: $SetSelectedWhereComplaintAddress');*/

        PartCVWSCuserObservationController.text = communityFeedbackData.first.observationCommunityFeedbackQualityConstruction;
        print('PartCVWSCuserObservationController: ${PartCVWSCuserObservationController.text}');


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
  void clearCommunityFeedback() {
    // Clear selected radio button values
    selectedComplaintByCommunity = null;
    selectedTypeOfComplaint = [];
    SetSelectedWhereComplaintAddress = null;
    PartCVWSCuserObservationController.clear();
    notifyListeners();
  }


  //33

  /// Function in the Provider/ViewModel to handle the community feedback save action.
  Future<void> saveCommunityFeedback({
    required int userId,
    required int stateId,
    required int villageId,
    required int anyComplaintByCommunity,
    required int isComplaintAddressed,
    required List<int> complaintType,
    required String typeComplaintOther,
    required int phyStatus,
    required String observationCommunityFeedbackQualityConstruction,
    required int createdBy,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {

      /// Call the repository function with the new variable.
      final response = await _vwscRepository.saveCommunityFeedback(
        userId: userId,
        stateId: stateId,
        villageId: villageId,
        anyComplaintByCommunity: anyComplaintByCommunity,
        isComplaintAddressed: isComplaintAddressed,
        complaintType: complaintType,
        typeComplaintOther: typeComplaintOther,
        phyStatus: phyStatus,
        observationCommunityFeedbackQualityConstruction: observationCommunityFeedbackQualityConstruction,
        createdBy: createdBy,
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

  int get selectedFTKAvailabilityId => yesNoMap[_selectedFTKAvailability] ?? -1;

  // 2. FTK Testing Frequency
  String? _selectedFTKTestingFrequency;

  String? get selectedFTKTestingFrequency => _selectedFTKTestingFrequency;

  set selectedFTKTestingFrequency(String? value) {
    _selectedFTKTestingFrequency = value;
    notifyListeners();
  }

  int get selectedFTKTestingFrequencyId =>
      ftkTestingFrequencyMap[_selectedFTKTestingFrequency] ?? -1;

  // 3. Women Trained in FTK Testing
  TextEditingController womenTrainedController = TextEditingController();

  // 4. Who is doing water quality testing
  TextEditingController testerNameController = TextEditingController();

  // 5. Disinfection Done
  String? _selectedDisinfectionDone;

  String? get selectedDisinfectionDone => _selectedDisinfectionDone;

  set selectedDisinfectionDone(String? value) {
    _selectedDisinfectionDone = value;
    notifyListeners();
  }

  int get selectedDisinfectionDoneId =>
      yesNoMap[_selectedDisinfectionDone] ?? -1;

  // 6. FRC Level
  String? _selectedFRCLevel;

  String? get selectedFRCLevel => _selectedFRCLevel;

  set selectedFRCLevel(String? value) {
    _selectedFRCLevel = value;
    notifyListeners();
  }

  int get selectedFRCLevelId => frcLevelMap[_selectedFRCLevel] ?? -1;


  TextEditingController PartDVWSCuserObservationController = TextEditingController();


  //44
  List<WaterQualityMonitoring> waterQualityData = [];

  Future<void> fetchWaterQuality(String stateId, String villageId, String userId, int phystatus) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _fetchvwscrepo.fetchWaterQualityMonitoring(stateId, villageId, userId, phystatus );
      if (response.status) {
        waterQualityData = response.result;
        _message = '';



        selectedFTKAvailability = getRadiobuttonData(waterQualityData.first.isFtkAvl,yesNoMap);
        print('selectedFTKAvailability: $selectedFTKAvailability');


        selectedFTKTestingFrequency = getRadiobuttonData(waterQualityData.first.ftkTestingPeriod,ftkTestingFrequencyMap);
        print('selectedFTKTestingFrequency: $selectedFTKTestingFrequency');

        womenTrainedController.text = waterQualityData.first.numberWomenTrainedFtk.toString();
        print('FrequencyController: ${womenTrainedController.text}');

        testerNameController.text = waterQualityData.first.whoTestFtk.toString();
        print('testerNameController: ${testerNameController.text}');


        selectedDisinfectionDone = getRadiobuttonData(waterQualityData.first.isChlorinationDisinfectionDone,yesNoMap);
        print('selectedDisinfectionDone: $selectedDisinfectionDone');

        selectedFRCLevel = getRadiobuttonData(waterQualityData.first.frcAvlAtEnd,frcLevelMap);
        print('selectedFRCLevel: $selectedFRCLevel');


        PartDVWSCuserObservationController.text = waterQualityData.first.observationWaterQualityMonitoring;
        print('PartDVWSCuserObservationController: ${PartDVWSCuserObservationController.text}');

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
  void clearFetchWaterQuality() {
    // Clear selected radio button values
    selectedFTKAvailability = null;
    selectedFTKTestingFrequency = null;
    SetSelectedWhereComplaintAddress = null;
    selectedDisinfectionDone = null;
    selectedFRCLevel = null;


    // Clear frequency text field
    womenTrainedController.clear();
    testerNameController.clear();
    PartDVWSCuserObservationController.clear();

    notifyListeners();
  }


  ///44

  Future<void> saveWaterQualityMonitoring({
    required int userId,
    required int stateId,
    required int villageId,
    required int isFtkAvailable,
    required int ftkTestingPeriod,
    required int numberWomenTrainedFtk,
    required String whoTestFtk,
    required int isChlorinationDone,
    required int frcAvailableAtEnd,
    required int phyStatus,
    required String observationWaterQualityMonitoring,

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
        phyStatus: phyStatus,
        observationWaterQualityMonitoring: observationWaterQualityMonitoring,

      );

      _status = response.status;
      _message = response.message;
    } catch (e) {
      GlobalExceptionHandler.handleException(e as Exception);
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

  int get selectedGrievanceMechanismId =>
      yesNoMap[_selectedGrievanceMechanism] ?? -1;

// 8. Grievance registration methods (multi-select)
  List<String> _selectedGrievanceMethods = [];

  List<String> get grievanceRegistrationMethods => _selectedGrievanceMethods;

  set grievanceRegistrationMethods(List<String> values) {
    _selectedGrievanceMethods = values;
    notifyListeners();
  }

// Expose selected IDs (mapped from selected labels)
  List<int> get selectedGrievanceMethodIds => _selectedGrievanceMethods
      .map((e) => grievanceRegistrationMethodMap[e] ?? -1)
      .toList();

// 9. Turn around time for grievance
  String? _selectedTurnAroundTime;

  String? get selectedTurnAroundTime => _selectedTurnAroundTime;

  set selectedTurnAroundTime(String? value) {
    _selectedTurnAroundTime = value;
    notifyListeners();
  }

  int get selectedTurnAroundTimeId =>
      turnAroundTimeMap[_selectedTurnAroundTime] ?? -1;

  TextEditingController PartEVWSCuserObservationController = TextEditingController();


  //5

  List<VwscGrievance> vwscGrievanceData = [];

  Future<void> fetchVwscGrievance(String stateId, String villageId, String userId, int phystatus) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _fetchvwscrepo.fetchVwscGrievance(stateId, villageId, userId, phystatus);
      if (response.status) {
        vwscGrievanceData = response.result;
        _message = '';



        selectedGrievanceMechanism = getRadiobuttonData(vwscGrievanceData.first.grievanceMechAvl,yesNoMap);
        print('selectedGrievanceMechanism: $selectedGrievanceMechanism');

        grievanceRegistrationMethods = getCheckBoxData(vwscGrievanceData.first.registrationType,grievanceRegistrationMethodMap);
        print('grievanceRegistrationMethods: $grievanceRegistrationMethods');

        selectedTurnAroundTime = getRadiobuttonData(vwscGrievanceData.first.grievanceTurnAroundTime,turnAroundTimeMap);
        print('selectedTurnAroundTime: $selectedTurnAroundTime');

        PartEVWSCuserObservationController.text = vwscGrievanceData.first.observationGrievanceRedressal;
        print('PartEVWSCuserObservationController: ${PartEVWSCuserObservationController.text}');

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
  void clearFetchGrievance() {
    // Clear selected radio button values
    selectedGrievanceMechanism = null;
    grievanceRegistrationMethods = [];
    selectedTurnAroundTime = null;
    PartEVWSCuserObservationController.clear();




    notifyListeners();
  }

  //5

  Future<void> saveGrievanceRedressal({
    required int userId,
    required int stateId,
    required int villageId,
    required int grievanceMechanismAvailable,
    required int grievanceTurnAroundTime,
    required List<int> registrationTypes,
    required String observationGrievanceRedressal, // NEW
    required int phyStatus, // NEW

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
        observationGrievanceRedressal: observationGrievanceRedressal, // NEW
        phyStatus: phyStatus, // NEW

      );

      _status = response.status;
      _message = response.message;
    } catch (e) {
      GlobalExceptionHandler.handleException(e as Exception);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  ///// ques c 1111111
  final Map<String, int> complainByCommunityOptMap = {
    "Yes": 1,
    "No": 2,
    "Not Known": 3,
  };

  List<String> get complainByCommunityOption =>
      complainByCommunityOptMap.keys.toList();

  String? _selectedComplaintByCommunity;

  String? get selectedComplaintByCommunity => _selectedComplaintByCommunity;

  set selectedComplaintByCommunity(String? value) {
    _selectedComplaintByCommunity = value;
    notifyListeners();
  }

  int get selectedComplaintByCommunityId =>
      complainByCommunityOptMap[_selectedComplaintByCommunity] ?? -1;

  /// 11111111

  ///////////33333333333/////////////

  final Map<String, int> whereComplaintAddressOptMap = {
    "Yes": 1,
    "No": 2,
    "Partially": 3,
  };

  List<String> get whereComplaintAddressOpt =>
      whereComplaintAddressOptMap.keys.toList();

  String? _selectedWhereComplaintAddressOpt;

  String? get selectedWhereComplaintAddress =>
      _selectedWhereComplaintAddressOpt;

  set SetSelectedWhereComplaintAddress(String? value) {
    _selectedWhereComplaintAddressOpt = value;
    notifyListeners();
  }

  int get selectedWhereComplaintAddressOptId =>
      whereComplaintAddressOptMap[_selectedWhereComplaintAddressOpt] ?? -1;



  TextEditingController PartCVWSCuserObservationController = TextEditingController();

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

  //other case

  TextEditingController othersComplaintController = TextEditingController();

  // 4. Convert selected labels to their mapped integer values (for API)
  List<int> get selectedTypeOfComplaintIds => _typeOfComplaintLabels
      .map((label) => typeOfComplaintMap[label])
      .whereType<int>()
      .toList();

//
}
