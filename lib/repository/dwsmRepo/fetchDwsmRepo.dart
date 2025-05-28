import '../../model/BaseResponseModel.dart';
import '../../model/dwsmPartB/CoordinationPlanningReviewPARTA.dart';
import '../../model/dwsmPartB/MonitoringQualityLabInfrastructurePARTC.dart';
import '../../model/dwsmPartB/OperationMaintenancePARTD.dart';
import '../../model/dwsmPartB/PublicComplaintsGrievanceRedressalPARTF.dart';
import '../../model/dwsmPartB/QualityAssuranceCommissioningPARTE.dart';
import '../../model/dwsmPartB/SourceSustainabilityWaterConservationPARTB.dart';
import '../../services/BaseApiService.dart';

class Fetchdwsmrepo {
  final BaseApiService _apiService = BaseApiService();

  Future<BaseResponseModel<CoordinationPlanningReview>>
      fetchCoordinationPlanningReview(
          String stateId, String districtId, String userId,int modeType) async {
    try {
      final response = await _apiService.get(
          '/CNOSurvey/Get_cno_dwsm_coordination_planning_review?stateid=$stateId&districtid=$districtId&userid=$userId&phy_status=$modeType');
      return BaseResponseModel<CoordinationPlanningReview>.fromJson(
          response, (json) => CoordinationPlanningReview.fromJson(json));
    } catch (e) {
      print('Error fetching Coordination Planning Review: $e');
      rethrow;
    }
  }

  Future<BaseResponseModel<SourceSustainabilityWaterConservation>>
      fetchSourceSustainabilityWaterConservation(
          String stateId, String districtId, String userId,int modeType) async {
    try {
      final response = await _apiService.get(
          '/CNOSurvey/Get_cno_dwsm_source_sustainability_water_conservation?stateid=$stateId&districtid=$districtId&userid=$userId&phy_status=$modeType');
      return BaseResponseModel<SourceSustainabilityWaterConservation>.fromJson(
          response,
          (json) => SourceSustainabilityWaterConservation.fromJson(json));
    } catch (e) {
      print('Error fetching Source Sustainability and Water Conservation: $e');
      rethrow;
    }
  }

  Future<BaseResponseModel<MonitoringQualityLabInfrastructure>>
      fetchMonitoringQualityLabInfrastructure(
          String stateId, String districtId, String userId,int modeType) async {
    try {
      final response = await _apiService.get(
          '/CNOSurvey/Get_cno_dwsm_monitoring_quality_lab_infrastructure?stateid=$stateId&districtid=$districtId&userid=$userId&phy_status=$modeType');
      return BaseResponseModel<MonitoringQualityLabInfrastructure>.fromJson(
          response,
          (json) => MonitoringQualityLabInfrastructure.fromJson(json));
    } catch (e) {
      print('Error fetching Monitoring Quality and Lab Infrastructure: $e');
      rethrow;
    }
  }

  Future<BaseResponseModel<OperationMaintenance>> fetchOperationMaintenance(
      String stateId, String districtId, String userId,int modeType) async {
    try {
      final response = await _apiService.get(
          '/CNOSurvey/Get_cno_dwsm_operation_maintenance?stateid=$stateId&districtid=$districtId&userid=$userId&phy_status=$modeType');
      return BaseResponseModel<OperationMaintenance>.fromJson(
          response, (json) => OperationMaintenance.fromJson(json));
    } catch (e) {
      print('Error fetching Operation & Maintenance: $e');
      rethrow;
    }
  }

  Future<BaseResponseModel<QualityAssuranceCommissioning>>
      fetchQualityAssuranceCommissioning(
          String stateId, String districtId, String userId,int modeType) async {
    try {
      final response = await _apiService.get(
          '/CNOSurvey/Get_cno_dwsm_Quality_Assurance_Commissioning?stateid=$stateId&districtid=$districtId&userid=$userId&phy_status=$modeType');
      return BaseResponseModel<QualityAssuranceCommissioning>.fromJson(
          response, (json) => QualityAssuranceCommissioning.fromJson(json));
    } catch (e) {
      print('Error fetching Quality Assurance and Commissioning: $e');
      rethrow;
    }
  }

  Future<BaseResponseModel<PublicComplaintsGrievanceRedressal>>
      fetchPublicComplaintsGrievanceRedressal(
          String stateId, String districtId, String userId,int modeType) async {
    try {
      final response = await _apiService.get(
          '/CNOSurvey/Get_cno_dwsm_Public_Complaints_Grievance_Redressal?stateid=$stateId&districtid=$districtId&userid=$userId&phy_status=$modeType');
      return BaseResponseModel<PublicComplaintsGrievanceRedressal>.fromJson(
          response,
          (json) => PublicComplaintsGrievanceRedressal.fromJson(json));
    } catch (e) {
      print('Error fetching Public Complaints and Grievance Redressal: $e');
      rethrow;
    }
  }
}
