import 'package:cno_inspection/model/DashboardResponse/DashboardResponse.dart';

import '../model/BaseResponseModel.dart';
import '../model/DashboardResponse/CnoHomeDashboard.dart';
import '../services/BaseApiService.dart';

class DashboardRepository {
  final BaseApiService _apiService = BaseApiService();

  Future<BaseResponseModel<CnoDashboardItem>> fetchDashboardData(userId, action, phy,) async {
    final response = await _apiService.get(
      '/CNOSurvey/Get_CNO_dashboard?userid=$userId&action=$action&phy=$phy',
    );
    return BaseResponseModel<CnoDashboardItem>.fromJson(
      response,
      (json) => CnoDashboardItem.fromJson(json),
    );
  }

  Future<BaseResponseModel<CnoDashboardHomeItem>> fetchDashboardHomeData(
    int userID,
    int action,
  ) async {
    final response = await _apiService.get(
      '/CNOSurvey/Get_cno_dashboard_home?userid=$userID&action=$action',
    );

    print("Dashboard Home Response: $response");

    return BaseResponseModel<CnoDashboardHomeItem>.fromJson(
      response,
      (json) => CnoDashboardHomeItem.fromJson(json),
    );
  }
}
