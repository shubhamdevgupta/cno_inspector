
import 'dart:convert';

import 'package:cno_inspection/model/BaseResponse.dart';

import '../../services/BaseApiService.dart';

class VwscRepository {
  final BaseApiService _apiService = BaseApiService();


  Future<BaseResponse> saveVwscWaterSupply({
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
    try {
      final response = await _apiService.post(
        '/CNOSurvey/Save_cno_vwsc_water_supply_functionality',
        body: jsonEncode({
          "userid": userId,
          "stateid": stateId,
          "villageid": villageId,
          "water_supply_frequency": waterSupplyFrequency,
          "is_adequate_water_quantity_reach_to_hh": adequateWaterToHH,
          "is_adequate_water_quantity_reach_to_remote": adequateWaterToRemote,
          "is_adequate_water_quantity_reach_to_remote_reason": remoteReason,
          "whether_water_reach_to_tail_end": tailEndWaterReach,
          "scheme_operational_status_commissioning": schemeOperationalStatus,
          "whether_pws_reach_all_school_anganwadiphc": pwsReachInstitutions,


          // New parameters
          "phy_status": phyStatus,
          "Is_there_any_piped_water_supply_scheme_in_the_village": isPipedWaterSupplyScheme,
          "What_is_the_type_of_scheme_presently_commissioned": typeOfSchemeCommissioned,
          "If_scheme_is_commissioned_how_many_households_are_being_benefitted": schemeBeneficiaryHouseholds,
          "What_is_the_present_status_of_water_supply_schemes": presentStatusOfWaterSupplySchemes,
          "Water_supply_frequency_assured_to_villagers_in_the_scheme": waterSupplyFrequencyAssured,
          "rdb_Whether_remote_SC_ST_PVTG_groups_existing_in_command_area_of_the_scheme_has_been_planned_in_scheme": remoteGroupsPlanned,
          "txt_Whether_remote_SC_ST_PVTG_groups_existing_in_command_area_of_the_scheme_has_been_planned_in_scheme": remoteGroupsPlannedDetails,
          "ObservationWatersupplyFunctionality": observationWaterSupplyFunctionality,
        }),
      );

      return BaseResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }


  // vwsc_repository.dart (add this inside same class)
  Future<BaseResponse> saveVwscCommunityInvolvement({
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
    required String ObservationCommunityInvolvementFunctionality
  }) async {
    try {
      final response = await _apiService.post(
        '/CNOSurvey/Save_cno_vwsc_community_Involvement_insert_update',
        body: jsonEncode({
          "userid": userId,
          "stateid": stateId,
          "villageid": villageId,
          "is_pani_samiti_formed": isPaniSamitiFormed,
          "is_vwsc_bank_account": isVwscBankAccount,
          "vwsc_gp_involvement_scheme": vwscGpInvolvementScheme,
          "drawing_pipeline_avl_gp_office": drawingPipelineAvlGpOffice,
          "is_vwsc_meeting_periodic_manner": isVwscMeetingPeriodic,
          "meeting_held_yes_frequency": meetingHeldFrequency,
          "is_vwsc_meeting_record_avl": isVwscMeetingRecordAvl,
          "vwsc_involvement_om": vwscInvolvementOM,
          "scheme_handed_over_gp": schemeHandedOverGp,
          "om_arrangement": omArrangement,
          "community_awareness": communityAwareness,
          "community_satisfaction_with_wq": communitySatisfactionWithWq,
          "createdby": createdBy,
          "ObservationCommunity_Involvement_Functionality": ObservationCommunityInvolvementFunctionality,
        }),
      );

      return BaseResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  /// Function in the repository to save community feedback data to the API.
  Future<BaseResponse> saveCommunityFeedback({
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
    try {
      /// Prepare the request body as a JSON-encoded map.
      final response = await _apiService.post(
        '/CNOSurvey/Save_cno_vwsc_community_feedback_insert_update',
        body: jsonEncode({
          "userid": userId,
          "stateid": stateId,
          "villageid": villageId,
          "any_complaint_by_community": anyComplaintByCommunity,
          "is_complaint_addressed": isComplaintAddressed,

          /// Complaint type as a list of integers.
          "complainttype": complaintType,



          /// If the complaint type is "Other", its description.
          "Type_complaint_other": typeComplaintOther,

          /// Physical status of the observation.
          "phy_status": phyStatus,

          /// Additional observations or remarks.
          "ObservationCommunity_feedback_quality_construction": observationCommunityFeedbackQualityConstruction,

          /// User ID of the person who created the record.
          "createdby": createdBy,
        }),
      );

      /// Return the parsed response as a BaseResponse object.
      return BaseResponse.fromJson(response);
    } catch (e) {
      /// Rethrow the error to be handled by the calling function.
      rethrow;
    }
  }



  Future<BaseResponse> saveWaterQualityMonitoring({
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
    try {
      final response = await _apiService.post(
        '/CNOSurvey/Save_cno_vwsc_wqmis_insert_update',
        body: jsonEncode({
          "userid": userId,
          "stateid": stateId,
          "villageid": villageId,
          "is_ftk_avl": isFtkAvailable,
          "ftk_testing_period": ftkTestingPeriod,
          "number_women_trained_ftk": numberWomenTrainedFtk,
          "who_test_ftk": whoTestFtk,
          "Is_chlorination_disinfection_done": isChlorinationDone,
          "frc_avl_at_end": frcAvailableAtEnd,
          "phy_status": phyStatus,
          "ObservationWater_Quality_Monitoring": observationWaterQualityMonitoring,

        }),
      );

      return BaseResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }


  Future<BaseResponse> saveGrievanceRedressal({
    required int userId,
    required int stateId,
    required int villageId,
    required int grievanceMechanismAvailable,
    required int grievanceTurnAroundTime,
    required List<int> registrationTypes,
    required String observationGrievanceRedressal, // NEW
    required int phyStatus, // NEW

  }) async {
    try {
      final response = await _apiService.post(
        '/CNOSurvey/Save_cno_vwsc_grievance_insert_update',
        body: jsonEncode({
          "userid": userId,
          "stateid": stateId,
          "villageid": villageId,
          "grievance_mech_avl": grievanceMechanismAvailable,
          "grievance_turn_around_time": grievanceTurnAroundTime,
          "registration_type": registrationTypes,
          "phy_status": phyStatus, // NEW
          "ObservationGrievance_Redressal": observationGrievanceRedressal, // NEW

        }),
      );

      return BaseResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }





}
