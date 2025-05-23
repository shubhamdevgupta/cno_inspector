import 'package:cno_inspection/repository/DashboardRepository.dart';
import 'package:flutter/cupertino.dart';

import '../model/DashboardResponse/DashboardResponse.dart';
import '../services/LocalStorageService.dart';
import '../utils/AppConstants.dart';

class DashboardProvider extends ChangeNotifier {
  final DashboardRepository _dashboardRepository = DashboardRepository();
  final LocalStorageService _localStorage = LocalStorageService();

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  CnoDashboardResponse? cnoDashboardResponse;

  List<CnoDashboardItem> dashboardList=[];
  String? selectedScheme;
  String? selectedVwsc;
  String? selectedDwsm;

  Future<void> fetchDashboardData(int userId,int action) async {
    _isLoading = true;
    notifyListeners();
   // int userId = _localStorage.getInt(AppConstants.prefUserId) ?? 0;
    try {
     final rawDashboardList = await _dashboardRepository.fetchDashboardData(userId, action);
     if(rawDashboardList.status==true){
       dashboardList=rawDashboardList.result;
     }
    } catch (e) {
      debugPrint("Dashboard Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSelectedScheme(String? schemeId) {
    selectedScheme = schemeId;
    notifyListeners();
  }
  void setSelectedDWSM(String? dwsmId) {
    selectedDwsm = dwsmId;
    notifyListeners();
  }
  void setSelectedVWSC(String? vwscId) {
    selectedVwsc = vwscId;
    notifyListeners();
  }
  @override
  void reset() {
    // TODO: implement reset
  }
}
