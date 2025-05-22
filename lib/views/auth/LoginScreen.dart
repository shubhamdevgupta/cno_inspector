/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../provider/authentication_provider.dart';
import '../../utils/AppConstants.dart';
import '../../utils/AppStyles.dart';
import '../../utils/Appcolor.dart';
import '../../utils/LoaderUtils.dart';
import '../../utils/toast_helper.dart';

// Login Page
class Loginscreen extends StatefulWidget {
  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginscreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController captchaController = TextEditingController();

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => AuthenticationProvider(),
        child: Consumer<AuthenticationProvider>(
            builder: (context, provider, child) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(40.0),
              child: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Text(
                  'Login ',
                   style: AppStyles.appBarTitle,
                ),
                backgroundColor: Appcolor.btncolor,
              ),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/icons/header_bg.png'),
                    fit: BoxFit.fill,
                    scale: 3),
              ),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 10),
                          child: buildHeader(),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildFormLabel('Mobile Number / Username'),
                                buildTextFormField(
                                  controller: phoneController,
                                  hint: 'Enter Mobile Number or Username',
                                  icon: Icons.person_outline,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(10),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                                SizedBox(height: 20),

                                buildFormLabel('Password'),
                                buildTextFormField(
                                  controller: passwordController,
                                  hint: 'Enter your password',
                                  icon: Icons.lock_outline,
                                  obscureText: !provider.isShownPassword,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      provider.isShownPassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.blueGrey,
                                    ),
                                    onPressed: provider.togglePasswordVisibility,
                                  ),
                                ),
                                SizedBox(height: 20),

                                buildFormLabel('Security Check'),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF1F3F4),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          '${provider.randomOne} + ${provider.randomTwo} = ?',
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'OpenSans',),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    InkWell(
                                      onTap: provider.generateCaptcha,
                                      borderRadius: BorderRadius.circular(30),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.blue.shade50,
                                        child: Icon(Icons.refresh, color: Colors.blue),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 16),

                                buildTextFormField(
                                  controller: captchaController,
                                  hint: 'Enter result',
                                  icon: Icons.verified_user,
                                  keyboardType: TextInputType.number,
                                ),
                                SizedBox(height: 30),

                                SizedBox(
                                  width: double.infinity,
                                  height: 52,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (validateLoginInput(provider)) {
                                        provider.loginUser(
                                          phoneController.text,
                                          passwordController.text, 1,
                                              () {
                                            provider.fetchLocation();
                                              Navigator.pushReplacementNamed(context, AppConstants.navigateToDashboard);
                                          },
                                              (errorMessage) {
                                                ToastHelper.showToastMessage(errorMessage);
                                          },
                                        );
                                      } else {
                                        ToastHelper.showToastMessage(provider.errorMsg);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Appcolor.btncolor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(14)),
                                      elevation: 4,
                                      padding: EdgeInsets.symmetric(vertical: 14),
                                    ),
                                    child: Text(
                                      'LOGIN',
                                      style: TextStyle(
                                        color:Colors.white,
                                        fontSize: 17, fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Image.asset("assets/icons/nicone.png", height: 40),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Loading Overlay
                  if (provider.isLoading)
                  LoaderUtils.conditionalLoader(isLoading: provider.isLoading)
                ],
              ),
            ),
          );
        }));
  }

  bool validateLoginInput(AuthenticationProvider provider) {
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String captcha = captchaController.text.trim();

    int? enteredCaptcha = int.tryParse(captcha);
    // Using a single if-else statement
    provider.errorMsg = (phone.isNotEmpty && phone.length == 10 && RegExp(r'^[0-9]{10}$').hasMatch(phone))
        ? (password.isNotEmpty ? (captcha.isNotEmpty && enteredCaptcha == provider.captchResult // Compare as int
                ? ""
                : "Please Enter Correct Captcha")
            : "Please Enter Password")
        : "Please Enter Valid Mobile Number";

    return provider.errorMsg.isEmpty;
  }

  Widget buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Logo
        Image.asset(
          'assets/icons/appjalicon.png',
          width: 55,
          height: 65,
        ),
        SizedBox(width: 12), // Adjusted spacing for a balanced layout

        // Title & Subtitle
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jal Jeevan Mission',
                style: TextStyle(
                  fontSize: 18, // Slightly reduced for better balance
                  fontWeight: FontWeight.w700, fontFamily: 'OpenSans',
                  color: Appcolor.txtColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis, // Prevents text overflow
              ),
              SizedBox(height: 3), // Minor spacing for readability
              Text(
                'Water Quality Management Information System',
                style: TextStyle(
                  fontSize: 12, fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800], // Softer color for better contrast
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2),
              Text(
                '(JJM-WQMIS)',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600, fontFamily: 'OpenSans',
                  color: Colors.grey[700], // Slightly softer color
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget buildFormLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget buildTextFormField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blueGrey),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Color(0xFFF5F7FA),
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }



}
*/
import 'dart:convert';
import 'dart:math';
import 'dart:async'; // Import to use Timer class
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';


import '../../utils/AppConstants.dart';
import '../../utils/custom_snackbar.dart';



class Loginscreen extends StatefulWidget {
  @override
  _Loginscreen createState() => _Loginscreen();
}

class _Loginscreen extends State<Loginscreen> {

  var random;
  int randomNumber = 0;
  int randomNumber1 = 0;
  int addCaptcha = 0;
  int randomNumberSalt = 0;

  //Login
  bool isLoading = false;
  bool isLoadingSubmitBtn = false;
  bool isLoadingNextBtn = false;
  bool mobileNumberLoginVisibility = true;
  bool nextButtonVisibility = true; // Next button will be shown from the beginning
  bool submitBtnLoginVisibility = false;
  bool isOTPSendVisibility = false;
  bool isMobileFieldEnabled = true;

  //Declare this at the top of your StatefulWidget
  final FocusNode otpFocusNode = FocusNode();

  //Registration
  bool isLoadingRegistration= false;
  bool registrationContainerVisibility = false;
  bool mobileNumberRegistrationVisibility = false;
  bool passwordVisible = true;
  bool submitBtnRegisterVisibility = false;

  var isUserAlreadyExist;

  String? globalToken;
/*  GetStorage box = GetStorage();*/

  // Countdown timer end time (10 minutes = 600 seconds)
  int _remainingTime = 60; // Total time in seconds (1 minute)
  String _timerText = "01:00"; // Timer display text
  bool _isResendEnabled = false; // Controls if Resend OTP button is enabled
  late Timer _timer; // Remaining time in seconds (600 seconds = 10 minutes)

  TextEditingController userMobileControllerCitizen = TextEditingController();
  TextEditingController userOTPControllerCitizen = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();

  String generateRandomString(int len) {
    int max = 15;
    // Tracks if the Next button is disabled
    randomNumber = Random().nextInt(max);
    randomNumber1 = Random().nextInt(max);
    addCaptcha = randomNumber + randomNumber1;
    randomNumberSalt = Random().nextInt(max);
    return addCaptcha.toString();
  }

/*  void initializeGlobalToken() {
    globalToken = box.read("Token");
    print("globalToken $globalToken");
  }*/

  //Wi-Fi or mobile data ON: Green dot (good internet).
  //Poor connection detected: Yellow dot (bad internet).
  //No connection (Wi-Fi/Mobile data off): Red dot (no internet).

  //Internet Dot
  // String internetStatus = "none"; // "good", "bad", "none"
  // void _checkInternetConnectionForDot() async {
  //   bool isConnected = await InternetConnectionChecker().hasConnection;
  //   setState(() {
  //     if (isConnected) {
  //       internetStatus = "good";
  //     } else {
  //       internetStatus = "none";
  //     }
  //   });
  // }
  //
  // void _monitorInternetConnectionForDot() {
  //   // Use Connectivity Plus to monitor changes in network type
  //   Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
  //     // Check if the device is connected to the internet
  //     bool isConnected = await InternetConnectionChecker().hasConnection;
  //
  //     setState(() {
  //       if (isConnected) {
  //         if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
  //           // Assume "good" or "bad" based on connection type or speed (optional)
  //           internetStatus = "good"; // For demonstration, set "good" when connected
  //         }
  //       } else {
  //         internetStatus = "none";
  //       }
  //     });
  //   });
  // }
  //
  // Widget _buildDot(Color color) {
  //   return Container(
  //     width: 16,
  //     height: 16,
  //     decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       color: color,
  //     ),
  //   );
  // }
  //
  // Color _getDotColor() {
  //   switch (internetStatus) {
  //     case "good":
  //       return Colors.green; // Good internet
  //     case "bad":
  //       return Colors.yellow; // Bad internet
  //     case "none":
  //       return Colors.red; // No internet
  //     default:
  //       return Colors.grey; // Default
  //   }
  // }

  //Optimized Solution for Instant Feedback:
  // String internetStatus = "none"; // "good", "bad", "none"
  // final Connectivity _connectivity = Connectivity();
  // late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  //
  // /// Initialize connection check and listen to changes
  // void _initializeConnectionCheck() async {
  //   _checkConnectivityInstant();
  //   _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_handleConnectivityChange);
  // }
  //
  // /// Handle real-time connectivity changes
  // void
  // _handleConnectivityChange(ConnectivityResult result) async {
  //   if (result == ConnectivityResult.none) {
  //     setState(() {
  //       internetStatus = "none"; // No internet immediately
  //     });
  //   } else {
  //     setState(() {
  //       internetStatus = "bad"; // Assume bad until confirmed
  //     });
  //
  //     // Confirm internet availability asynchronously
  //     _verifyInternetConnection();
  //   }
  // }
  //
  // /// Instant check of connectivity to update UI
  // void _checkConnectivityInstant() async {
  //   var result = await _connectivity.checkConnectivity();
  //   _handleConnectivityChange(result);
  // }
  //
  // /// Asynchronously verify real internet access without blocking UI updates
  // void _verifyInternetConnection() async {
  //   bool isConnected = await InternetConnectionChecker().hasConnection;
  //   setState(() {
  //     internetStatus = isConnected ? "good" : "none";
  //   });
  // }
  //
  // /// Builds the dot with appropriate color
  // Widget _buildDot(Color color) {
  //   return Container(
  //     width: 16,
  //     height: 16,
  //     decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       color: color,
  //     ),
  //   );
  // }
  //
  // /// Determines the dot color based on the internet status
  // Color _getDotColor() {
  //   switch (internetStatus) {
  //     case "good":
  //       return Colors.green;  // Good internet
  //     case "bad":
  //       return Colors.yellow; // Checking internet
  //     case "none":
  //       return Colors.red;    // No internet
  //     default:
  //       return Colors.grey;   // Default state
  //   }
  // }

  @override
  void initState() {
    //1st way
    //_checkInternetConnectionForDot(); // Perform an immediate internet check
    //_monitorInternetConnectionForDot(); // Start listening for connectivity changes

    //2nd way
    //_initializeConnectionCheck();

    //3rd way


    random = generateRandomString(6);

 /*   setState(() {
      box.write("appversion", "1.0");
    });*/

    //call app version api


    _remainingTime = 60; // 10 minutes in seconds (600)

    super.initState();
  }

  //To avoid memory leaks, dispose of the FocusNode in the dispose() method
  @override
  void dispose() {
    //_connectivitySubscription.cancel();


    otpFocusNode.dispose();
    userMobileControllerCitizen.dispose();
    userOTPControllerCitizen.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent the back button from doing anything
        return Future.value(false);
      },

      //appbar title background
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF096DA8), // Dark blue color
              Color(0xFF589569),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Scaffold(
          //resizeToAvoidBottomInset: true, // Ensures the screen resizes to accommodate the keyboard, it move the bottom bar upward
          resizeToAvoidBottomInset: false,  // If it's set to false, the screen will not move when the keyboard appears.
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [

              //at bottom bar, to add internet dot, below this Column
              Column(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        //Title ViKSiT BHARAT
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 80.0),
                            child: Text(
                              "Central Nodal Officers",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        //Title Swachhata App
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 5.0, left: 5),
                            child: Text(
                              "Site Inspection ",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFF2E3D5),
                              ),
                            ),
                          ),
                        ),

                        //Mobile Number Container
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(1),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 4),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          margin: const EdgeInsets.only(top: 50, left: 5, right: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              // login citizen Mobile Number Input
                              Visibility(
                                visible: mobileNumberLoginVisibility,
                                child: Column(
                                  children: [
                                    Text(
                                      "Mobile Number",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      controller: userMobileControllerCitizen,
                                      enabled: isMobileFieldEnabled, // Control field enabling/disabling, added new
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.grey.shade200,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide.none,
                                        ),
                                        hintText: "Enter your mobile number",
                                        hintStyle: TextStyle(
                                            color: Colors.grey.shade500),
                                        prefixIcon: const Icon(Icons.phone,
                                            color: Colors.blueAccent),
                                      ),
                                      keyboardType: TextInputType.phone,

                                      textInputAction: TextInputAction.done,
                                      maxLength: 10,
                                      // Limits input to 6 characters
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        // Allows only digits
                                        LengthLimitingTextInputFormatter(10),
                                        // Limits input to 10 characters
                                      ],
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter your mobile number";
                                        } else if (value.length != 10) {
                                          return "Mobile number must be 10 digits";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),

                              //Login Next Button
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (userMobileControllerCitizen.text.isEmpty) {
                                    CustomSnackBar.showError(context, 'Please enter your mobile number first!');
                                    return;
                                  } else if (userMobileControllerCitizen.text.length != 10) {
                                    CustomSnackBar.showError(context, 'Mobile number must be 10 digits!');
                                    return;
                                  } else {
                                    setState(() {
                                      // when user click on next button,then loader will start running
                                      isLoadingNextBtn = true;
                                      // Disable mobile number edit field during loading i.e Disable the editfield if loading(isLoadingNextBtn) is true
                                      isMobileFieldEnabled = false; // Disable the mobile field here
                                      //Show otp field if otp is sent but i want to move cursor from mobile number field to otp field and blink cursor
                                      //Ensure OTP Field is Visible Before Requesting Focus
                                      //Set isOTPSendVisibility = true before requesting focus so the OTP field is already rendered.
                                      isOTPSendVisibility = true; // Show OTP field if hidden
                                    });

                                    // Add a slight delay before moving focus
                                    Future.delayed(Duration(milliseconds: 300), () {
                                      FocusScope.of(context).requestFocus(otpFocusNode);
                                    });

                                    //hit getOTP Api
                                  }
                                  // Attempt to send OTP
                                  // Re-enable the button if OTP sending failed
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                                ),
                                child: const Text('Next', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                              ),
                            ),

                              const SizedBox(height: 15),

                              // OTP Section (Visible only if OTP is sent)
                              Visibility(
                                visible: isOTPSendVisibility,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Enter OTP",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      controller: userOTPControllerCitizen,
                                      focusNode: otpFocusNode,  // Attach the FocusNode here
                                      enabled: true,            // Ensure it's enabled
                                      obscureText: passwordVisible,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.grey.shade200,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                          borderSide: BorderSide.none,
                                        ),
                                        hintText: "Enter the OTP",
                                        hintStyle: TextStyle(
                                            color: Colors.grey.shade500),
                                        prefixIcon: const Icon(Icons.lock,
                                            color: Colors.blueAccent),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            passwordVisible
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              passwordVisible =
                                              !passwordVisible;
                                            });
                                          },
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
                                      maxLength: 6,
                                      // Limits input to 6 characters
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        // Only allow numeric input
                                        LengthLimitingTextInputFormatter(6),
                                        // Limit input to 6 digits
                                      ],
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter the OTP";
                                        } else if (value.length != 6) {
                                          return "OTP must be 6 digits";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 16),

                                    // "Haven't received the code yet?"
                                    Center(
                                      child: Column(
                                        children: [
                                          const Text(
                                            "Haven't received the code yet?",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          _isResendEnabled
                                              ? TextButton(
                                            onPressed: () async {
                                              if (userMobileControllerCitizen.text.isEmpty) {
                                                CustomSnackBar.showError(context, 'Please enter your mobile number first!');
                                                return;
                                              } else {
                                                _resetTimer(); // Reset timer when Resend OTP is pressed
                                              }
                                            },
                                            child: const Text('Resend OTP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.blueAccent,),),)
                                              : Text(
                                            'Resend in: $_timerText',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.blueAccent,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 16),

                                    // Resend Button
                                  ],
                                ),
                              ),

                              //Submit Button for Login Screen
                          Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (userMobileControllerCitizen.text.isEmpty) {
                                  CustomSnackBar.showError(context, 'Please enter your mobile number first!');
                                  return;
                                } else if (userOTPControllerCitizen.text.isEmpty) {
                                  CustomSnackBar.showError(context, 'Please enter otp first!!');
                                  return;
                                } else if (userOTPControllerCitizen.text.length != 6) {
                                  CustomSnackBar.showError(context, 'OTP must be 6 digits!');
                                  return;
                                } else {
                                  Navigator.pushReplacementNamed(context, AppConstants.navigateToDashboard);

                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                              ),
                              child: const Text(
                                'Submit', style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),

                              // Registration Mobile Section
                              Visibility(
                                visible: mobileNumberRegistrationVisibility,
                                child: Column(
                                  children: [
                                    Text(
                                      "Mobile Number",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      controller: userMobileControllerCitizen,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.grey.shade200,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                          borderSide: BorderSide.none,
                                        ),
                                        hintText: "",
                                        hintStyle: TextStyle(
                                            color: Colors.grey.shade500),
                                        prefixIcon: const Icon(Icons.phone,
                                            color: Colors.blueAccent),
                                      ),
                                      keyboardType: TextInputType.phone,
                                      textInputAction: TextInputAction.done,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter your mobile number";
                                        } else {
                                          return null;
                                        }
                                      },
                                      enabled: false, // Disables the text field
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),

                              Visibility(
                                visible: registrationContainerVisibility,
                                child: Column(
                                  children: [
                                    //Divider
                                    const Divider(height: 30, thickness: 1),

                                    //Fill Details Text
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black26,
                                              offset: Offset(0, 4),
                                              blurRadius: 6,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            const Center(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 5.0, left: 5),
                                                child: Text(
                                                  "Fill Details",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 20),

                                            // Name Field
                                            TextFormField(
                                              controller: userNameController,
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.grey.shade200,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(12),
                                                  borderSide: BorderSide.none,
                                                ),
                                                hintText: "Enter your name",
                                                hintStyle: TextStyle(
                                                    color:
                                                    Colors.grey.shade500),
                                                prefixIcon: const Icon(
                                                    Icons.person,
                                                    color: Colors.blueAccent),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Name is required'; // Field cannot be empty
                                                }
                                                if (value.length < 3) {
                                                  return 'Name must be at least 3 characters'; // Ensure name is long enough
                                                }
                                                final nameRegex =
                                                RegExp(r'^[a-zA-Z\s]+$');
                                                if (!nameRegex
                                                    .hasMatch(value)) {
                                                  return 'Enter a valid name (letters and spaces only)'; // Ensure valid format
                                                }
                                                return null; // Return null if validation passes
                                              },
                                              keyboardType: TextInputType.name,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              // Validate on interaction
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    50),
                                                // Limit input to 50 characters
                                              ],
                                            ),

                                            const SizedBox(height: 20),

                                            // Email Field
                                            TextFormField(
                                              controller: userEmailController,
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.grey.shade200,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(12),
                                                  borderSide: BorderSide.none,
                                                ),
                                                hintText: "Enter your email",
                                                hintStyle: TextStyle(
                                                    color:
                                                    Colors.grey.shade500),
                                                prefixIcon: const Icon(
                                                    Icons.email,
                                                    color: Colors.blueAccent),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Email is required'; // Check if field is empty
                                                }
                                                // Regular expression for basic email validation
                                                final emailRegex = RegExp(
                                                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                                                if (!emailRegex
                                                    .hasMatch(value)) {
                                                  return 'Enter a valid email address'; // Check email format
                                                }
                                                return null; // Return null if validation passes
                                              },
                                              keyboardType:
                                              TextInputType.emailAddress,
                                              // Sets appropriate keyboard
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction, // Automatically validate on interaction
                                            ),

                                            const SizedBox(height: 20),

                                            //Submit Button for Registration Screen
                                            isLoadingRegistration // Show the loader if isLoading is true
                                                ? Center(
                                              child: Container(
                                                color: Colors.transparent,
                                                // Transparent background
                                                child: const CircularProgressIndicator(
                                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent), // Loader color
                                                ),
                                              ),
                                            )
                                                : Visibility(
                                              visible: submitBtnRegisterVisibility,
                                              child: Center(
                                                child: ElevatedButton(
                                                  onPressed: () async {
                                                    // Validate the name field before proceeding
                                                   /* if (userNameController.text.isEmpty) {
                                                      CustomSnackBar.showError(context, 'Please enter your name!');
                                                      return;
                                                    } else if (userNameController.text.length > 25) {
                                                      CustomSnackBar.showError(context, 'Name should not be more than 25 character');
                                                      return;
                                                    } else {
                                                      final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
                                                      if (!nameRegex.hasMatch(userNameController.text)) {
                                                        CustomSnackBar.showError(context, 'Enter a valid name (letters and spaces only)');
                                                        return;
                                                      }
                                                    }*/

                                                    Navigator.pushReplacementNamed(context, AppConstants.navigateToDashboard);



                                                    // Add your action here after validation
                                                  },
                                                  style: ElevatedButton
                                                      .styleFrom(
                                                    backgroundColor:
                                                    Colors.blueAccent,
                                                    foregroundColor:
                                                    Colors.white,
                                                    padding:
                                                    const EdgeInsets
                                                        .symmetric(
                                                        horizontal:
                                                        40,
                                                        vertical: 12),
                                                    shape:
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          20),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'Submit',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              //App Version and Internet Dot
              Positioned(
                bottom: 0, // Align to the bottom of the screen
                left: 0,
                right: 0,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          //child: _buildDot(_getDotColor()),
                         /* child: InternetStatusIndicator(), // Use the widget here*/
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "App version: 1.0",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _isResendEnabled = false; // Initially disable the Resend OTP button

    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_remainingTime == 0) {
        // Timer finished, enable resend button
        setState(() {
          _isResendEnabled = true; // Show the Resend OTP button
          _timerText = ""; // Hide the timer text
        });
        timer.cancel(); // Stop the timer
      } else {
        // Update the remaining time and the UI
        setState(() {
          _remainingTime--;
          int minutes = _remainingTime ~/ 60; // Get minutes part
          int seconds = _remainingTime % 60; // Get seconds part
          _timerText = "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
        });
      }
    });
  }

  // reset countdown timer
  void _resetTimer() {
    setState(() {
      _remainingTime = 60; // Reset to 1 minute (60 seconds)
      _isResendEnabled = false; // Hide the Resend OTP button
      _timerText = "01:00"; // Reset timer text
    });
    _startTimer(); // Start the timer again
  }

}


















