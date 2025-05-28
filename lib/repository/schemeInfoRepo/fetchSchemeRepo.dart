
import 'package:flutter/cupertino.dart';

import '../../model/BaseResponseModel.dart';
import '../../model/schemePartA/AdditionalInfoRetrofitResponsePartC.dart';
import '../../model/schemePartA/SchemeImplementationModelPartD.dart';
import '../../model/schemePartA/SchemePlanningResponsePartB.dart';
import '../../model/schemePartA/SchemeVisualInspectionModelPartE.dart';
import '../../model/schemePartA/SourceSurveyResponsePartA.dart';
import '../../services/BaseApiService.dart';

class Fetchschemeinfo {
  final BaseApiService _apiService = BaseApiService();

  //aaaaaaaaaaaa


  Future<BaseResponseModel<SourceSurveyItem>> fetchSourceSurvey(
      String stateId, String schemeId, String userId,int modeType) async {
    try {
      final response = await _apiService.get(
          '/CNOSurvey/Get_cno_source_survey?stateid=$stateId&schemeid=$schemeId&userid=$userId&phy_status=$modeType');
      return BaseResponseModel<SourceSurveyItem>.fromJson(
        response,
            (json) => SourceSurveyItem.fromJson(json),
      );
    } catch (e) {
      print('Error fetching Source Survey: $e');
      rethrow;
    }
  }

  Future<BaseResponseModel<SchemePlanningItem>> fetchSchemePlanning(
      String stateId, String schemeId, String userId,int modeType) async {
    try {
      final response = await _apiService.get(
          '/CNOSurvey/Get_cno_scheme_planning?stateid=$stateId&schemeid=$schemeId&userid=$userId&phy_status=$modeType');
      return BaseResponseModel<SchemePlanningItem>.fromJson(
        response,
            (json) => SchemePlanningItem.fromJson(json),
      );
    } catch (e) {
      print('Error fetching Scheme Planning: $e');
      rethrow;
    }
  }

  Future<BaseResponseModel<AdditionalInfoRetrofitItem>>
  fetchAdditionalInfoRetrofit(
      String stateId, String schemeId, String userId,int modeType) async {
    try {
      final response = await _apiService.get(
          '/CNOSurvey/Get_cno_additional_info_retrofit?stateid=$stateId&schemeid=$schemeId&userid=$userId&phy_status=$modeType');
      return BaseResponseModel<AdditionalInfoRetrofitItem>.fromJson(
        response,
            (json) => AdditionalInfoRetrofitItem.fromJson(json),
      );
    } catch (e) {
      print('Error fetching Additional Info for Retrofitting: $e');
      rethrow;
    }
  }

  Future<BaseResponseModel<SchemeImplementationModel>> fetchSchemeImplementation(
      String stateId, String schemeId, String userId,int modeType) async {
    try {
      final response = await _apiService.get(
          '/CNOSurvey/Get_cno_scheme_implementation?stateid=$stateId&schemeid=$schemeId&userid=$userId&phy_status=$modeType');

      return BaseResponseModel<SchemeImplementationModel>.fromJson(
        response,
            (json) => SchemeImplementationModel.fromJson(json),
      );
    } catch (e) {
      debugPrint('Error fetching Scheme Implementation: $e');
      rethrow;
    }
  }

  Future<BaseResponseModel<SchemeVisualInspectionModel>> fetchSchemeVisualInspection(
      String stateId, String schemeId, String userId,int modeType) async {
    try {
      final response = await _apiService.get(
          '/CNOSurvey/Get_cno_scheme_visual_Inspection?stateid=$stateId&schemeid=$schemeId&userid=$userId&phy_status=$modeType');

      return BaseResponseModel<SchemeVisualInspectionModel>.fromJson(
        response,
            (json) => SchemeVisualInspectionModel.fromJson(json),
      );
    } catch (e) {
      debugPrint('Error fetching Scheme Visual Inspection: $e');
      rethrow;
    }
  }




}