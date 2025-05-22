import 'package:cno_inspection/provider/authentication_provider.dart';
import 'package:cno_inspection/utils/AppConstants.dart';
import 'package:cno_inspection/utils/LoaderUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../utils/custom_snackbar.dart';

class Loginscreen extends StatefulWidget {
  @override
  _Loginscreen createState() => _Loginscreen();
}

class _Loginscreen extends State<Loginscreen> {
  final TextEditingController loginIdController = TextEditingController();
  final TextEditingController otpValidateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthenticationProvider(),
      child: Consumer<AuthenticationProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: Container(
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
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                body: Stack(
                  children: [
                   provider.isLoading? LoaderUtils.conditionalLoader(isLoading: provider.isLoading)
                   : Column(
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
                                margin: const EdgeInsets.only(
                                    top: 50, left: 5, right: 5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // login citizen Mobile Number Input
                                    Column(
                                      children: [
                                        Align(
                                          child: Text(
                                            "Please Enter your login Id",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey.shade800,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        TextFormField(
                                          controller: loginIdController,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.grey.shade200,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide.none,
                                            ),
                                            hintText: "Enter your login id",
                                            hintStyle: TextStyle(
                                                color: Colors.grey.shade500),
                                          ),
                                          keyboardType: TextInputType.phone,
                                          textInputAction: TextInputAction.done,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),

                                    //Login Next Button
                                    Center(
                                      child: ElevatedButton(
                                        onPressed: provider.isOtpButtonEnabled
                                            ? () {
                                                if (loginIdController
                                                    .text.isEmpty) {
                                                  CustomSnackBar.showError(
                                                      context,
                                                      'Please enter your login Id!');
                                                  return;
                                                } else {
                                                  provider.sendOtp(
                                                      loginIdController.text,
                                                      () {},
                                                      (error) {
                                                        CustomSnackBar.showError(
                                                            context,error);
                                                      });
                                                }
                                              }
                                            : null,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blueAccent,
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                                          ),// disable button
                                        child: provider.isOtpButtonEnabled
                                            ? const Text("Next", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
                                            : Text(
                                                "Resend in ${provider.formattedOtpTimer}s", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                      ),
                                    ),

                                    provider.sendOtpResponse != null
                                        ? Center(
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Otp Have been sent to this number ${provider.sendOtpResponse!.MobileNumber}",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                              ],
                                            ),
                                          )
                                        : const SizedBox(height: 15),

                                    // OTP Section (Visible only if OTP is sent)
                                    provider.sendOtpResponse != null
                                        ? Visibility(
                                            visible: provider
                                                .sendOtpResponse!.Status!,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Please Enter Your OTP",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.grey.shade800,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                TextFormField(
                                                  controller:
                                                      otpValidateController,
                                                  obscureText:
                                                      provider.obscureOtp,
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        Colors.grey.shade200,
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      borderSide:
                                                          BorderSide.none,
                                                    ),
                                                    hintText: "Enter the OTP",
                                                    hintStyle: TextStyle(
                                                        color: Colors
                                                            .grey.shade500),
                                                    prefixIcon: const Icon(
                                                        Icons.lock,
                                                        color:
                                                            Colors.blueAccent),
                                                    suffixIcon: IconButton(
                                                      icon: Icon(
                                                        provider.obscureOtp
                                                            ? Icons.visibility
                                                            : Icons
                                                                .visibility_off,
                                                        color: Colors.grey,
                                                      ),
                                                      onPressed: () => provider
                                                          .toggleOtpVisibility(),
                                                    ),
                                                  ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  maxLength: 6,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                    LengthLimitingTextInputFormatter(
                                                        6),
                                                  ],
                                                ),
                                                const SizedBox(height: 16),

                                                Center(
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      if (otpValidateController
                                                          .text.isEmpty) {
                                                        CustomSnackBar.showError(
                                                            context,
                                                            'Please enter valid otp!');
                                                        return;
                                                      } else {
                                                        provider.verifyOtp(
                                                            loginIdController
                                                                .text,
                                                            otpValidateController
                                                                .text,
                                                            () {
                                                              print('navigatingggggggg');
                                                              Navigator.pushReplacementNamed(context, AppConstants.navigateToDashboard);
                                                            },
                                                            (error) {
                                                              CustomSnackBar.showError(
                                                                  context,error);
                                                            });
                                                      }
                                                      // Attempt to send OTP
                                                      // Re-enable the button if OTP sending failed
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.blueAccent,
                                                      foregroundColor:
                                                          Colors.white,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 40,
                                                          vertical: 12),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      'Verify Otp',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),

                                                // Resend Button
                                              ],
                                            ),
                                          )
                                        : SizedBox()
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

/*  void _startTimer() {
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
          _timerText =
              "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
        });
      }
    });
  }*/

// reset countdown timer
/*  void _resetTimer() {
    setState(() {
      _remainingTime = 60; // Reset to 1 minute (60 seconds)
      _isResendEnabled = false; // Hide the Resend OTP button
      _timerText = "01:00"; // Reset timer text
    });
    _startTimer(); // Start the timer again
  }*/
}
