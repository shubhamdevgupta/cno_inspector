import 'dart:convert';

import 'package:cno_inspection/model/DashboardResponse/DashboardResponse.dart';

import '../../model/BaseResponse.dart';
import '../../services/BaseApiService.dart';

class SchemeRepositoy {
  final BaseApiService _apiService = BaseApiService();
  Future<BaseResponse> saveSourceSurvey({
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
    try {
      final response = await _apiService.post(
        '/CNOSurvey/Save_cno_source_survey_insert_update',
        body: jsonEncode({
          "userid": userId,
          "stateid": stateId,
          "schemeid": schemeId,
          "is_rcmnd_shift_to_surface_wtr": isRecommendShiftToSurface,
          "any_study_access_gw_before_sw": studyAccessGroundBeforeSurface,
          "no_villages_safe_zone": safeZoneVillages,
          "no_villages_critical_zone": criticalZoneVillages,
          "no_villages_semi_critical_zone": semiCriticalZoneVillages,
          "incase_gw_cont_any_analysis_conduct": groundWaterAnalysisConducted,
          "wtr_allocation_frm_state_WRD_ID_frm_sw": waterAllocationFromWRD,
        }),
      );
      return BaseResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<BaseResponse> saveSchemePlanning({
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
    try {
      final response = await _apiService.post(
        '/CNOSurvey/Save_cno_scheme_planning_insert_update',
        body: jsonEncode({
          "userid": userId,
          "stateid": stateId,
          "schemeid": schemeId,
          "is_topographical_survey": topoSurvey,
          "is_gps_physical_survey": gpsSurvey,
          "is_google_earth_survey": googleSurvey,
          "no_survey": numberOfSurveys,
          "running_hrs_per_day_design_transmission_main": designRunningHours,
          "retention_time_in_hrs_per_day_OSHR_OHT": retentionTimeOHT,
          "retention_time_in_hrs_per_day_mbr": retentionTimeMBR,
          "distribution_netwrk_terrian_type_rocky_strata": terrainRocky,
          "distribution_netwrk_terrian_type_soil_strata": terrainSoil,
          "found_as_per_dpr": foundAsPerDPR,
          "divation_if_any": deviation,
        }),
      );
      return BaseResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<BaseResponse> saveRetrofitAdditionalInfo({
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
    try {
      final response = await _apiService.post(
        '/CNOSurvey/Save_cno_additional_info_retrofit_insert_update',
        body: jsonEncode({
          "userid": userId,
          "stateid": stateId,
          "schemeid": schemeId,
          "whether_assesment_legacy_done": isAssessmentDone,
          "if_yes_whether_assesment_legacy_done_method": assessmentMethod,
          "if_no_whether_assesment_legacy_reason": assessmentReason,
          "legacy_infrastructure_tramission_pipeline_in_kms": pipelineKms,
          "legacy_infrastructure_distribution_pipeline_in_kms": distributionKms,
          "legacy_infrastructure_wtp_capcity_in_mld": wtpCapacity,
          "legacy_infrastructure_storage_str_nos": structureNos,
          "legacy_infrastructure_storage_str_capacity_kl": structureCapacity,
          "build_drawing_infr_available": buildDrawingAvailable,
          "if_yes_is_it_on_PMGati": onPMGati,
          "if_no_reason": noReason,
        }),
      );
      return BaseResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }


  Future<BaseResponse> saveSchemeImplementation({
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
    try {
      final response = await _apiService.post(
        '/CNOSurvey/Save_cno_scheme_implementation_insert_update',
        body: jsonEncode({
          "userid": userId,
          "stateid": stateId,
          "schemeid": schemeId,
          "cost_overrun": costOverrun,
          "has_scheme_cost_revised_befor_work": costRevisedBeforeWork,
          "scheme_cost_revised_befor_work_yes_per": revisedCostPercentage,
          "slssc_date_for_revised_estimate": slsscDate,
          "num_intake_tube_well": intakeTubeWellNum,
          "cost_intake_tube_well_cr": intakeTubeWellCost,
          "num_electro_mechanical_incl_pump": electroMechanicalNum,
          "cost_electro_mechanical_incl_pump_cr": electroMechanicalCost,
          "num_wtp": wtpNum,
          "cost_wtp_cr": wtpCost,
          "num_mbr": mbrNum,
          "cost_mbr": mbrCost,
          "num_transmission_pipeline": transmissionPipelineNum,
          "cost_transmission_pipeline_cr": transmissionPipelineCost,
          "num_distribution_pipeline": distributionPipelineNum,
          "cost_distribution_pipeline_cr": distributionPipelineCost,
          "num_disinfection_unit": disinfectionUnitNum,
          "cost_disinfection_unit_cr": disinfectionUnitCost,
          "num_oshr_esr_oht_gsr": ohtNum,
          "cost_oshr_esr_oht_gsr_cr": ohtCost,
          "num_IoT_SCADA": iotNum,
          "cost_IoT_SCADA_cr": iotCost,
          "num_road_restoration": roadRestorationNum,
          "cost_road_restoration_cr": roadRestorationCost,
          "num_solar_components": solarComponentNum,
          "cost_solar_components_cr": solarComponentCost,
          "num_other_dg_set_hh_storage_tanks_etc": otherComponentsNum,
          "cost_other_dg_set_hh_storage_tanks_etc_cr": otherComponentsCost,
          "is_compoent_planed_PT_gati_shakti_WTP": plannedPTGatiShaktiWTP,
          "is_compoent_planed_PT_gati_shakti_oshr_esr_oht_gsr": plannedPTGatiShaktiOHT,
          "is_compoent_planed_PT_gati_shakti_source": plannedPTGatiShaktiSource,
          "is_compoent_planed_PT_gati_shakti_pipeline": plannedPTGatiShaktiPipeline,
          "delay_work_reason": delayReasons,
          "cost_overrun_reason": costOverrunReasons,
          "cost_revision_reason": costRevisionReasons,
        }),
      );
      return BaseResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }


  Future<BaseResponse> saveVisualInspection({
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
    try {
      final response = await _apiService.post(
        '/CNOSurvey/Save_cno_scheme_visual_Inspection_insert_update',
        body: jsonEncode({
          "userid": userId,
          "stateid": stateId,
          "schemeid": schemeId,
          "cost_overrun": costOverrun,
          "is_inspect_of_spalling_peeling_off_surface": spalling,
          "is_inspect_of_cracks": cracks,
          "is_inspect_of_red_brown_rust_marks": rustMarks,
          "is_inspect_of_swollen_concrete": swollenConcrete,
          "is_inspect_of_trapped_jute_plastic_bags": trappedJute,
          "is_inspect_of_protruding_rusted_reinforcement_bars": rustedBars,
          "is_inspect_of_dampness_of_concrete_surfaces": dampness,
          "is_inspect_of_visible_white_marks": whiteMarks,
          "is_inspect_of_visible_stone_aggregates": stoneAggregates,
          "is_inspect_of_structures_missing_vertical_alignment": verticalAlignment,
          "is_inspect_of_visible_sag_in_the_slab_beam": sagSlabBeam,
          "is_inspect_of_high_vibration_observed_in_the_pumps": highVibrationPumps,
          "is_inspect_of_leakages_in_reservoirs": reservoirLeakage,
          "is_inspect_of_high_leakages_from_the_pumps": highLeakagePumps,
          "is_inspect_of_Pipelines_leakages_in_transmission": pipelineLeakageTransmission,
          "is_inspect_of_Pipelines_leakages_in_distribution": pipelineLeakageDistribution,
          "is_inspect_of_Pipelines_wet_patches_pool_of_water": wetPatches,
          "whether_quality_verify_of_manufacture_pipe_third_party": verifyPipeQuality,
          "are_the_pipes_as_mention_in_the_DPR_implement_on_ground": pipesAsPerDPR,
          "are_there_any_complaints_regard_pipeline_approve_design_DPR": complaintsOnPipelineDesign,
          "is_tpia_engaged_for_this_scheme": isTPIAEngaged,
          "are_sample_based_quality_checks_pipes_civil_key_components": sampleChecks,
          "is_concurrent_supervision_in_the_scope_of_TPIA": concurrentSupervision,
          "has_tpia_cond_quality_checks_diff_stages_of_construction": tpiaStageChecks,
          "are_there_records_of_observ_inspect_reports_issued_tpia": tpiaReports,
          "has_any_action_taken_by_dept_based_on_tpia_observation": actionOnTPIA,
          "does_tpia_verify_measurement_books": tpiaVerifyMB,
          "is_hydrotesting_pipelines_done": hydroTestingDone,
          "is_test_reports_provided_samples": testReportsProvided,
          "whether_dept_engineers_do_quality_checks": deptQualityChecks,
          "whether_dept_eng_verify_measure_construction_works": deptMeasurementVerification,
          "scheme_commissioned_done_per_commissioning_protocol": schemeCommissioned,
          "document_as_proof_of_commissioning_available": commissioningProofAvailable,
          "type_of_issues_tpias": tpiaIssueTypes,
        }),
      );
      return BaseResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }





}
