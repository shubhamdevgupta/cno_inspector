import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

    // Set up tab controller with listener
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);

    // Delay until context is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
      _fetchDataForTab(_tabController.index); // initial load
    });
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) return; // Wait until animation completes
    _fetchDataForTab(_tabController.index);
  }

  void _fetchDataForTab(int index) {
    int action = index == 0 ? 1 : 1;
    dashboardProvider.fetchDashboardHomeData(action);
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
