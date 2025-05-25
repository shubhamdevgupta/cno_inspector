
import 'package:cno_inspection/model/BaseResponseModel.dart';

import '../../model/vwscPartC/CommunityFeedbackPartCResponse.dart';
import '../../model/vwscPartC/CommunityInvolmentPartBResponse.dart';
import '../../model/vwscPartC/VwscGrievancePartEResponse.dart';
import '../../model/vwscPartC/WaterQualityPartAResponse.dart';
import '../../model/vwscPartC/WaterQualityPartDResponse.dart';
import '../../services/BaseApiService.dart';

class Fetchvwscrepo {
  final BaseApiService _apiService = BaseApiService();

  /// aaaaaaa
  Future<BaseResponseModel<WaterSupplyFunctionality>> fetchWaterSupplyFunctionality(
      String stateId, String villageId, String userId) async {
    try {
      final response = await _apiService.get(
          '/CNOSurvey/Get_cno_vwsc_water_supply_functionality?stateid=$stateId&villageid=$villageId&userid=$userId'
      );
      return BaseResponseModel<WaterSupplyFunctionality>.fromJson(
          response,
              (json) => WaterSupplyFunctionality.fromJson(json)
      );
    } catch (e) {
      print('Error fetching water supply functionality: $e');
      rethrow;
    }
  }


  ////// BBbbbb
  Future<BaseResponseModel<CommunityInvolvement>> fetchCommunityInvolvement(
      String stateId, String villageId, String userId) async {
    try {
      final response = await _apiService.get(
          '/api/CNOSurvey/Get_cno_vwsc_community_Involvement?stateid=$stateId&villageid=$villageId&userid=$userId'
      );
      return BaseResponseModel<CommunityInvolvement>.fromJson(
          response,
              (json) => CommunityInvolvement.fromJson(json)
      );
    } catch (e) {
      print('Error fetching community involvement: $e');
      rethrow;
    }
  }


  ///ccccccc
  Future<BaseResponseModel<CommunityFeedback>> fetchCommunityFeedback(
      String stateId, String villageId, String userId) async {
    try {
      final response = await _apiService.get(
          '/api/CNOSurvey/Get_cno_vwsc_community_feedback?stateid=$stateId&villageid=$villageId&userid=$userId'
      );
      return BaseResponseModel<CommunityFeedback>.fromJson(
          response,
              (json) => CommunityFeedback.fromJson(json)
      );
    } catch (e) {
      print('Error fetching community feedback: $e');
      rethrow;
    }
  }


///dddddd
  Future<BaseResponseModel<WaterQualityMonitoring>> fetchWaterQualityMonitoring(
      String stateId, String villageId, String userId) async {
    try {
      final response = await _apiService.get(
          '/api/CNOSurvey/Get_cno_vwsc_wqmis?stateid=$stateId&villageid=$villageId&userid=$userId'
      );
      return BaseResponseModel<WaterQualityMonitoring>.fromJson(
          response,
              (json) => WaterQualityMonitoring.fromJson(json)
      );
    } catch (e) {
      print('Error fetching water quality monitoring: $e');
      rethrow;
    }
  }

////// eeeeeeee
  Future<BaseResponseModel<VwscGrievance>> fetchVwscGrievance(
      String stateId, String villageId, String userId) async {
    try {
      final response = await _apiService.get(
          '/api/CNOSurvey/Get_cno_vwsc_grievance?stateid=$stateId&villageid=$villageId&userid=$userId'
      );
      return BaseResponseModel<VwscGrievance>.fromJson(
          response,
              (json) => VwscGrievance.fromJson(json)
      );
    } catch (e) {
      print('Error fetching VWSC grievance: $e');
      rethrow;
    }
  }






}