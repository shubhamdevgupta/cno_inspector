// views/DashboardScreen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/authentication_provider.dart';
import '../../provider/dashboardProvider.dart';
import '../../services/LocalStorageService.dart';
import '../../utils/AppConstants.dart';
import '../../utils/AppStyles.dart';


class Dashboardscreen extends StatefulWidget {
  const Dashboardscreen({super.key});

  @override
  State<Dashboardscreen> createState() => _DashboardscreenState();
}

class _DashboardscreenState extends State<Dashboardscreen> {
  final LocalStorageService _localStorage = LocalStorageService();

late DashboardProvider dashboardProvider;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      dashboardProvider =
          Provider.of<DashboardProvider>(context, listen: false);
    //  await dashboardProvider.loadDashboardData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/icons/header_bg.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            // Removes the default back button
            centerTitle: true,
            title: Text(
              AppConstants.appTitle,
              style: AppStyles.appBarTitle,
            ),
            leading: Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
            actions: [
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.refresh,
                        color: Colors.white),
                    // Cart icon
                    onPressed: () {
                   //   dashboardProvider.loadDashboardData();
                    },
                  )
                ],
              ),
            ],
            //elevation
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF096DA8), // Dark blue color
                    Color(0xFF3C8DBC), // Green color
                  ],
                  begin: Alignment.topCenter, // Start at the top center
                  end: Alignment.bottomCenter, // End at the bottom center
                ),
              ),
            ),
            elevation: 5,
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                       "kkk=",
                        style: AppStyles.appBarTitle,
                      ),
                      Text(
                        "ghg", // Provide a fallback value if null
                        style: AppStyles.setTextStyle(
                            16, FontWeight.normal, Colors.white70),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.dashboard),
                  title: Text(
                    "dd",
                    style: AppStyles.style16NormalBlack,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: Text(
                    "logout",
                    style: AppStyles.style16NormalBlack,
                  ),
                  onTap: () async {
                    final authProvider = Provider.of<AuthenticationProvider>(
                        context,
                        listen: false);
                    await authProvider.logoutUser();
                    Navigator.pushReplacementNamed(
                        context, AppConstants.navigateToLogin);
                  },
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Profile Picture
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade300,
                              Colors.blue.shade800
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        padding: const EdgeInsets.all(2),
                        // Border-like effect
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.grey[100],
                          backgroundImage:
                          const AssetImage('assets/icons/user.png'),
                        ),
                      ),
                      const SizedBox(width: 16),

                      // User Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Welcome Text
                            Text(
                              'Welcome',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'OpenSans',
                                color: Colors.grey.shade700,
                              ),
                            ),
                            Text(
                              "userName",
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),

                            const SizedBox(height: 4),

                            // Department and Phone
                            Row(
                              children: [
                                const Icon(Icons.account_balance_sharp,
                                    size: 18, color: Colors.teal),
                                const SizedBox(width: 6),
                                Text(
                                  'Departmental User',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'OpenSans',
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),

                            const SizedBox(height: 6),

                            Row(
                              children: [
                                const Icon(Icons.phone_android,
                                    size: 18, color: Colors.teal),
                                const SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                    "mobile",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'OpenSans',
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),


                Container(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child:buildAssessmentCard(
                      title: "Scheme Inspection Form",
                      baselineStatus: "In-Progress",
                      baselineColor: Colors.orangeAccent,
                      latestStatus: "Pending",
                      latestColor: Colors.redAccent,
                      odfStatus: "Non-ODF Plus",
                      odfColor: Colors.redAccent,
                      backgroundColor: Color(0xFFE3F2FD),
                      borderColor: Color(0xFF2196F3),
                      buttonColor: Color(0xFF2196F3),
                      onStartPressed: () {
                        Navigator.pushReplacementNamed(context, AppConstants.navigateToDashboardSchemeInfo);
                      },
                    )
                  ),
                ),


                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child:buildAssessmentCard(
                    title: "Interaction with DWSM",
                    baselineStatus: "In-Progress",
                    baselineColor: Colors.orangeAccent,
                    latestStatus: "Pending",
                    latestColor: Colors.redAccent,
                    odfStatus: "Non-ODF Plus",
                    odfColor: Colors.redAccent,
                    backgroundColor: Color(0xFFE3F2FD),
                    borderColor: Color(0xFF2196F3),
                    buttonColor: Color(0xFF2196F3),
                    onStartPressed: () {
                      Navigator.pushReplacementNamed(context, AppConstants.navigateToDashboardDWSM);
                    },
                  )
                ),

                const SizedBox(height:10),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: buildAssessmentCard(
                    title: "Interaction with VWSC ",
                    baselineStatus: "In-Progress",
                    baselineColor: Colors.orangeAccent,
                    latestStatus: "Pending",
                    latestColor: Colors.redAccent,
                    odfStatus: "Non-ODF Plus",
                    odfColor: Colors.redAccent,
                    backgroundColor: Color(0xFFE3F2FD),
                    borderColor: Color(0xFF2196F3),
                    buttonColor: Color(0xFF2196F3),
                    onStartPressed: () {
                      Navigator.pushReplacementNamed(context, AppConstants.navigateToDashboardVWSC);
                    },
                  )
                ),


                Container(

                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFe0f7fa), Color(0xFFFFFFFF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                    ],
                  ),
                ),

              ],
            ),
          )
      ),
    );
  }


  Widget buildAssessmentCard({
    required String title,
    required String baselineStatus,
    required Color baselineColor,
    required String latestStatus,
    required Color latestColor,
    required String odfStatus,
    required Color odfColor,
    required Color backgroundColor,
    required Color borderColor,
    required Color buttonColor,
    required VoidCallback onStartPressed,
  }) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: borderColor, width: 1.5),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                title,
                style: TextStyle(
                  color: borderColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Baseline Assessment",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.circle, color: baselineColor, size: 16),
                          SizedBox(width: 6),
                          Text(
                            baselineStatus,
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Latest Assessment",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.circle, color: latestColor, size: 16),
                          SizedBox(width: 6),
                          Text(
                            latestStatus,
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Divider
                Container(
                  width: 1.0,
                  height: 100,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  color: Colors.black26,
                ),

                // Right Column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ODF Plus Status",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.circle, color: odfColor, size: 16),
                        SizedBox(width: 6),
                        Text(
                          odfStatus,
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: onStartPressed,
                child: Text(
                  "Start Baseline Assessment",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
