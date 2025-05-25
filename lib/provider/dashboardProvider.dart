import 'package:cno_inspection/repository/DashboardRepository.dart';
import 'package:flutter/cupertino.dart';

import '../model/DashboardResponse/DashboardResponse.dart';
import '../services/LocalStorageService.dart';
import '../utils/AppConstants.dart';
import '../utils/GlobalExceptionHandler.dart';

class DashboardProvider extends ChangeNotifier {
  final DashboardRepository _dashboardRepository = DashboardRepository();
  final LocalStorageService _localStorage = LocalStorageService();

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _status = true;
  bool get status => _status;


  String errorMsg = '';

  CnoDashboardResponse? cnoDashboardResponse;

  List<CnoDashboardItem> dashboardList=[];
  int selectedSchemeID=0;
  int selectedVwscId=0;
  int selectedDwsmID=0;

  Future<void> fetchDashboardData(int userId,int action) async {
    _isLoading = true;
    notifyListeners();
    int userId = _localStorage.getInt(AppConstants.prefUserId) ?? 0;
    try {
     final rawDashboardList = await _dashboardRepository.fetchDashboardData(userId, action);
     _status=rawDashboardList.status;
     if(rawDashboardList.status==true){
       dashboardList=rawDashboardList.result;
     }else{
       errorMsg=rawDashboardList.message;
     }
    } catch (e) {
      GlobalExceptionHandler.handleException(e as Exception);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSelectedScheme(int schemeId) {
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
}
