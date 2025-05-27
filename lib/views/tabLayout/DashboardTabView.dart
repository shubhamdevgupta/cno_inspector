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

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
      dashboardProvider.fetchDashboardHomeData(1);
      final appState = Provider.of<AppStateProvider>(context, listen: false);

      final mode = _tabController.index == 0
          ? ProjectMode.below10
          : ProjectMode.above10;
      appState.setMode(mode);


    });
  }


  void _handleTabChange() {
    if (_tabController.indexIsChanging) return;
    final appState = Provider.of<AppStateProvider>(context, listen: false);

    final mode = _tabController.index == 0
        ? ProjectMode.below10
        : ProjectMode.above10;
    appState.setMode(mode);

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
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Dashboard"),
              backgroundColor: Colors.blue,
              bottom: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Below 10 Percent'),
                  Tab(text: 'Above 10 Percent'),
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
        );
      },
    );
  }
}