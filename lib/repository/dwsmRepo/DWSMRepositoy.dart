import 'dart:convert';

import '../../model/BaseResponse.dart';
import '../../services/BaseApiService.dart';

class DWSMRepositoy {
  final BaseApiService _apiService = BaseApiService();


  Future<BaseResponse> saveCoordinationPlanningReview({
    required int userId,
    required int stateId,
    required int districtId,
    required int areMonthlyMeetingsHeld,
    required int numberOfMeetingsLast6Months,
    required int qualityOfMeeting,
    required int areCoordinationMeetingsRegular,
    required String auditInternalObservation,
    required String observationCoordination,
    required int modeType,
  }) async {
    try {
      final response = await _apiService.post(
        '/CNOSurvey/Save_cno_dwsm_coordination_planning_review_insert_update',
        body: jsonEncode({
          "userid": userId,
          "stateid": stateId,
          "districtid": districtId,
          "Is_audit_internal_Obseration_coordination_planning_review": auditInternalObservation,
          "are_monthly_dwsm_meetings_on_progress_JJM_works": areMonthlyMeetingsHeld,
          "if_yes_no_of_dwsm_meetings_last_6_months": numberOfMeetingsLast6Months,
          "quality_of_meeting_and_record_maintenance": qualityOfMeeting,
          "are_dist_develop_coordinat_monitor_committee_meeting_regularly": areCoordinationMeetingsRegular,
          "Obseration_coordination_planning_review":observationCoordination,
          "phy_status": modeType
        }),
      );
      return BaseResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<BaseResponse> saveSourceSustainability({
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
    try {
      final response = await _apiService.post(
        '/CNOSurvey/Save_cno_dwsm_source_sustainability_water_conservation_insert_update',
        body: jsonEncode({
          "userid": userId,
          "stateid": stateId,
          "districtid": districtId,
          "are_source_sustainability_measures_being_promoted": areSustainabilityMeasuresPromoted,
          "are_piped_water_schemes_gw_sources_protected_contamination": areGWSourcesProtected,
          "is_at_least_one_recharge_structure_gw_source_implemented": isRechargeStructureImplemented,
          "if_no_least_one_recharge_structure_gw_source_implemented_reson": reasonIfNotImplemented,//have to be in string
          "are_any_impact_studies_assessments_conducted_source_sustain_efforts": areImpactStudiesConducted,
          "Does_district_NABL_accredited_lab_water_quality":accrediteLabWaterQuality,
          "Does_district_NABL_accredited_lab_water_quality_no_remark":accrediteLabWaterQualityNoRemark,
          "phy_status":modeType
        }),
      );
      return BaseResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<BaseResponse> saveMonitoringQualityLab({
    required int userId,
    required int stateId,
    required int districtId,
    required int areAssetsGeotagged,
    required int hasNABLLab,
    required String testingManagementDescription,
    required String observationMonitoringQuality,
    required int modeType
  }) async {
    try {
      final response = await _apiService.post(
        '/CNOSurvey/Save_cno_dwsm_monitoring_quality_lab_infrastructure_insert_update',
        body: jsonEncode({
          "userid": userId,
          "stateid": stateId,
          "districtid": districtId,
          "are_water_supply_assets_geotagged": areAssetsGeotagged,
          "does_the_district_have_an_nabl_accredited_lab_equivalent": hasNABLLab,
          "if_no_how_is_testing_managed_description": testingManagementDescription,
          "Obseration_Monitoring_Quality_lab_Infrastructure":observationMonitoringQuality,
          "phy_status":modeType
        }),
      );
      return BaseResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<BaseResponse> saveTecnoCommercialViabbility({
    required int userId,
    required int stateId,
    required int districtId,
    required String omCostScheme,
    required String chargeStakeHolder,
    required String remaningExpenses,
    required String requiredOperation,
    required int modeType,
  }) async {
    try {
      final response = await _apiService.post(
        '/CNOSurvey/Save_cno_dwsm_Techno_Commercial_Viability_insert_update',
        body: jsonEncode({
          "userid": userId,
          "stateid": stateId,
          "districtid": districtId,
          "What_annual_OM_cost_scheme":omCostScheme,
          "What_water_charges_stakeholders":chargeStakeHolder,
          "What_State_plan_meeting_remaining_expenses":remaningExpenses,
          "Expected_skilled_manpower_required_operations":requiredOperation,
          "phy_status":modeType

        }),
      );
      return BaseResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
/*  {
  "userid": 1726,
  "stateid": 17,
  "districtid": 264,
  "Is_protocol_in_village_infrastructure": 3,
  "Percentage_villages_trained_manpower": 4.00000,
  "Is_Water_charged_households_fee_amount": 5,
  "Is_Water_charged_households_uniform_consumption": 2,
  "Percentage_villages_User_Fee_collected": 6.00000,
  "createdby": null,
  "createdip": null,
  "phy_status": 0,
  "Obseration_Operation_Maintenance": ""
  }*/

  Future<BaseResponse> saveOperationMaintenance({
    required int userId,
    required int stateId,
    required int districtId,
    required int isProtocolInPlace,
    required double percentVillagesWithManpower,
    required int isWaterFeeCharged,
    required int feeAmountPerMonth,
    required int isUniformFee,
    required double percentVillagesFeeCollected,
    required String obserVationOperationMaintenance,
    required int modeType
  }) async {
    try {
      final response = await _apiService.post(
        '/CNOSurvey/Save_cno_dwsm_operation_maintenance_insert_update',
        body: jsonEncode({
          "userid": userId,
          "stateid": stateId,
          "districtid": districtId,
          "Is_protocol_in_village_infrastructure": isProtocolInPlace,
          "Percentage_villages_trained_manpower": percentVillagesWithManpower,
          "Is_Water_charged_households_fee_amount": feeAmountPerMonth,
          "Is_Water_charged_households_uniform_consumption": isUniformFee,
          "Percentage_villages_User_Fee_collected": percentVillagesFeeCollected,
          "phy_status":modeType,
          "Obseration_Operation_Maintenance":obserVationOperationMaintenance
        }),
      );
      return BaseResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<BaseResponse> saveQualityAssurance({
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
    try {
      final response = await _apiService.post(
        '/CNOSurvey/Save_cno_dwsm_Quality_Assurance_Commissioning_insert_update',
        body: jsonEncode({
          "userid": userId,
          "stateid": stateId,
          "districtid": districtId,
          "Who_authorized_inspect_measure_field_inspection": inspectionAuthority,
          "Is_commissioning_protocol_followed": isCommissioningProtocolFollowed,
          "During_commissioning_schemes_present": schemesPresentDuringCommissioning,
          "Has_district_undertaken_assessment_inspection_agencies": districtAssessmentAgencies,
          "Has_distric_hired_third_party_inspection_agencies_JJM_schemes":districtHiredAgencies,
          "phy_status":modeType
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
    try {
      final response = await _apiService.post(
        '/CNOSurvey/Save_cno_dwsm_Public_Complaints_Grievance_Redressal_insert_update',
        body: jsonEncode({
          "userid": userId,
          "stateid": stateId,
          "districtid": districtId,
          "Grievance_Redressal_mechanism_available": grievanceMechanismAvailable,
          "How_grievances_registered_villagers": howGrievancesRegistered,
          "Are_complaints_received_public_regarding_schemes": complaintsReceived,
          "yes_type_complaints": typeOfComplaints,//todo checkbox
          "yes_type_complaints_others": otherComplaints,
          "yes_type_complaints_others_What_average_time_resolution": resolutionTime,
          "yes_type_complaints_others_Action_taken_department": actionTakenByDepartment,
          "phy_status":modeType
        }),
      );
      return BaseResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }


}
