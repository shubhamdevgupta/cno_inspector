import 'package:cno_inspection/model/DashboardResponse/CnoHomeDashboard.dart';
import 'package:cno_inspection/repository/DashboardRepository.dart';
import 'package:flutter/cupertino.dart';

import '../model/DashboardResponse/CnoHomeDashboard.dart';
import '../model/DashboardResponse/DashboardResponse.dart';
import '../services/LocalStorageService.dart';
import '../utils/AppConstants.dart';
import '../utils/GlobalExceptionHandler.dart';

class DashboardProvider extends ChangeNotifier {
  final DashboardRepository _dashboardRepository = DashboardRepository();
  final LocalStorageService _localStorage = LocalStorageService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _status = true;

  bool get status => _status;

  String errorMsg = '';

  // CnoDashboardResponse? cnoDashboardResponse;

  List<CnoDashboardItem> dashboardList = [];
  List<CnoDashboardHomeItem> cnoDashboardHomeList = [];
  String? selectedSchemeID;
  int selectedVwscId = 0;
  int selectedDwsmID = 0;

  Future<void> fetchDashboardHomeData(int action) async {
    _isLoading = true;
    notifyListeners();

    final int userId = _localStorage.getInt(AppConstants.prefUserId) ?? 0;

    try {
      final rawData =
          await _dashboardRepository.fetchDashboardHomeData(userId, action);

      _status = rawData.status;

      if (_status == true) {
        cnoDashboardHomeList = rawData.result;
      } else {
        errorMsg = rawData.message;
      }
    } catch (e) {
      GlobalExceptionHandler.handleException(e as Exception);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchDashboardData(int userId, int action, int phy) async {
    _isLoading = true;
    notifyListeners();
    int userId = _localStorage.getInt(AppConstants.prefUserId) ?? 0;
    try {
      final rawDashboardList =
          await _dashboardRepository.fetchDashboardData(userId, action, phy);
      _status = rawDashboardList.status;
      if (rawDashboardList.status == true) {
        dashboardList = rawDashboardList.result;
        if (dashboardList.length == 1) {
          selectedSchemeID = dashboardList.first.schemeId.toString();
          selectedDwsmID = dashboardList.first.districtId;
          selectedVwscId = dashboardList.first.villageId;
        }
      } else {
        errorMsg = rawDashboardList.message;
      }
    } catch (e) {
      GlobalExceptionHandler.handleException(e as Exception);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSelectedScheme(String? schemeId) {
    selectedSchemeID = schemeId;
    notifyListeners();
  }

  void setSelectedDWSM(int dwsmId) {
    selectedDwsmID = dwsmId;
    notifyListeners();
  }

  void setSelectedVWSC(int vwscId) {
    selectedVwscId = vwscId;
    notifyListeners();
  }

  void clearDashboardData() {
    dashboardList.clear();
    cnoDashboardHomeList.clear();
  }
}
