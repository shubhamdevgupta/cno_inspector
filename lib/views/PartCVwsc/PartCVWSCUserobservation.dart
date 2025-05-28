

import 'package:cno_inspection/views/PArtASchemeInfo/Dashboardschemeinfo.dart';
import 'package:cno_inspection/views/PartBDwsm/DashboardDWSM.dart';
import 'package:flutter/material.dart';
import '../../utils/custom_snackbar.dart';



class Partcvwscuserobservation extends StatefulWidget {
  @override
  _Partcvwscuserobservation createState() => _Partcvwscuserobservation();
}

class _Partcvwscuserobservation extends State<Partcvwscuserobservation> {
  final TextEditingController _controller = TextEditingController();
  double _rating = 0;
  String _ratingText = '';

  @override
  void initState() {
    super.initState();
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
        resizeToAvoidBottomInset: true,

        // Ensures the screen layout adjusts when the keyboard is shown
        appBar: AppBar(
          //appbar title background
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

          //appbar back button
          // leading: IconButton(
          //   icon: const Icon(
          //     Icons.arrow_back,
          //     color: Colors.white,
          //   ),
          //   onPressed: () {
          //     Navigator.of(context).pushReplacement(MaterialPageRoute(
          //         builder: (context) =>
          //             UserDetails())); // This will pop the current screen off the stack (go back)
          //   },
          // ),

          //appbar close icon
          automaticallyImplyLeading: false,
          // Disable the default back arrow
          backgroundColor: Colors.transparent,
          // Make the app bar transparent
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () {
                //Navigator.pop(context); // Close the screen when the cross icon is pressed but drawer will not close

                // This will pop the current screen off the stack (go back)
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Dashboarddwsm()));
              },
            ),
          ],

          //appbar title
          title: const Center(
            child: Text(
              'Feedback & Rating',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),

        body: Container(
      /*    decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF096DA8), // Dark blue color
                Color(0xFF589569), // Green color
              ],
              begin: Alignment.topCenter, // Start at the top center
              end: Alignment.bottomCenter, // End at the bottom center
            ),
          ),*/

          //LinearGradient is not spreading till bottom
          width: double.infinity, // Ensures it spans the entire width
          height: double.infinity, // Ensures it spans the entire height

          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'How was your overall experience?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Rating Bar with shadow
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _rating = index + 1;
                            _ratingText = _getRatingText(_rating);
                          });
                        },
                        child: Icon(
                          index < _rating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 50,
                          shadows: const [
                            Shadow(
                              color: Colors.black38,
                              blurRadius: 5,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    _ratingText.isEmpty ? 'Select a rating' : _ratingText,
                    style: const TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                  const SizedBox(height: 30),

                  // Experience Text
                  const Text(
                    'Tell us your experience',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87),
                  ),
                  const SizedBox(height: 10),

                  // TextField with shadow and rounded corners
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _controller,
                      maxLines: 3,
                      style: const TextStyle(fontSize: 16),
                      decoration: const InputDecoration(
                        labelText: 'Your Comments',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(12.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Submit Button with gradient
                  ElevatedButton(
                    onPressed: isLoading ? null : _submitRating,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: Colors.blue,
                      shadowColor: Colors.black38,
                      elevation: 5,
                    ),
                    child: isLoading
                        ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                        : const Text(
                      'Submit Rating',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                  ),
                ],
              ),

            ),
          ),
        ),
      ),
    );
  }

  // Get text based on rating
  String _getRatingText(double rating) {
    if (rating == 1) return 'Poor';
    if (rating == 2) return 'Fair';
    if (rating == 3) return 'Good';
    if (rating == 4) return 'Very Good';
    if (rating == 5) return 'Excellent';
    return '';
  }

  // Submit Rating
  void _submitRating() {
    if (_rating == 0) {
      CustomSnackBar.showError(
          context, "Please select a rating before submitting!");
      return;
    } else if (_controller.text.isEmpty) {
      CustomSnackBar.showError(
          context, "Please tell us your experience first!");
      return;
    } else {
      //call rating api

      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text("You rated: $_ratingText"),
      // ));
    }
  }

  String? globalToken;

  bool isLoading = false;

}
