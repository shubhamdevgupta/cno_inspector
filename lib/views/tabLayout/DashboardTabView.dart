import 'package:cno_inspection/provider/dwsmInfoProvider/DwsmProvider.dart';
import 'package:cno_inspection/provider/schemeInfoProvider/SchemeProvider.dart';
import 'package:cno_inspection/provider/vwscInfoProvider/VwscProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/AppStateProvider.dart';
import '../../provider/dashboardProvider.dart';
import 'AboveTenPercentTab.dart';
import 'BelowTenPercentTab.dart';

class DashboardTabView extends StatefulWidget {
  @override
  State<DashboardTabView> createState() => _DashboardTabViewState();
}

class _DashboardTabViewState extends State<DashboardTabView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late DashboardProvider dashboardProvider;
  bool _isProviderInitialized = false;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);

      dashboardProvider.clearDashboardData();
      await dashboardProvider.fetchDashboardHomeData(1);

      _isProviderInitialized = true; // ✅ mark as ready

      final data = dashboardProvider.cnoDashboardHomeList.first;
      final isBelowDataEmpty =
          data.totalSchemeBelow == 0 &&
              data.totalDistrictBelow == 0 &&
              data.totalVillageBelow == 0;

      final appState = Provider.of<AppStateProvider>(context, listen: false);

      if (isBelowDataEmpty) {
        _tabController.animateTo(1);
        appState.setMode(ProjectMode.above10);
      } else {
        _tabController.animateTo(0);
        appState.setMode(ProjectMode.below10);
      }
    });
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging || !_isProviderInitialized) return;

    final appState = Provider.of<AppStateProvider>(context, listen: false);
    final newMode = _tabController.index == 0
        ? ProjectMode.below10
        : ProjectMode.above10;

    appState.setMode(newMode);

    dashboardProvider.fetchDashboardHomeData(1);
    Provider.of<Schemeprovider>(context, listen: false).clearSchemeProvider();
    Provider.of<Dwsmprovider>(context, listen: false).clearDwsmProvider();
    Provider.of<Vwscprovider>(context, listen: false).clearVwscProvider();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);
            return false;
          },
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/icons/header_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: const Center(
                  child: Text(
                    "Dashboard",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                backgroundColor: Colors.blue,
                bottom: TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(
                      icon: Icon(Icons.arrow_downward, color: Colors.white),
                      child: Text(
                        'Below 10 Percent',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Tab(
                      icon: Icon(Icons.arrow_upward, color: Colors.white),
                      child: Text(
                        'Above 10 Percent',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white70,
                  indicatorColor: Colors.white,
                ),
              ),
              body: TabBarView(
                controller: _tabController,
                children: const [
                  BelowTenPercentTab(),
                  AboveTenPercentTab(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
