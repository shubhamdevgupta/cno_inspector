import 'package:cno_inspection/model/DashboardResponse/DashboardResponse.dart';

import '../model/BaseResponse.dart';
import '../services/BaseApiService.dart';

class DashboardRepository {
  final BaseApiService _apiService = BaseApiService();

  Future<BaseResponseModel<CnoDashboardItem>> fetchDashboardData(
    int userID,
    int action,
  ) async {
    try {
      final response = await _apiService
          .get('/CNOSurvey/get_CNO_dashboard?userid=$userID&action=$action');

      print("DEMO----${response}");
      return BaseResponseModel<CnoDashboardItem>.fromJson(
          response, (json) => CnoDashboardItem.fromJson(json));
    } catch (e) {
      rethrow;
    }
  }
}
