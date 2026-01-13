import 'package:bright_weddings/Component/Dashboard/Notifications/notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onNext;
  final VoidCallback? onBack;
  final VoidCallback? showNotificationScreen;

  //final bool? showDashboard;
  //final bool? showLogin;
  //final bool? showRegistration;

  Header({
    Key? key,
    this.onNext,
    this.onBack,
    this.showNotificationScreen,
    //this.showDashboard,
    //this.showLogin,
    //this.showRegistration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        height: 80.0,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Opacity(
              opacity: 1.0, // Fully opaque image
              child: Image.asset(
                'assets/images/vector_wedding.png',
                height: 50, // Set the height for the image
              ),
            ),
            SizedBox(width: 8),
            Text(
              'Bright Weddings',
              style: GoogleFonts.pacifico(
                fontSize: 22,
                fontWeight: FontWeight.w200,
                color: Color.fromARGB(255, 252, 71, 47),
              ),
            ),

            Spacer(
              flex: 2,
            ),
            IconButton(
              onPressed: () {
                // Add functionality for notification here
                Get.to(() =>
                    NotificationScreen()); // Example if you pass a callback
              },
              icon: Icon(Icons.notifications),
              color: Color.fromARGB(255, 134, 133, 133),
            ),

            // Logout Button
            IconButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  Get.offAllNamed('/');
                  Get.snackbar(
                    'Logged Out',
                    'You have been successfully logged out',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                } catch (e) {
                  Get.snackbar(
                    'Error',
                    'Failed to logout: $e',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              icon: Icon(Icons.logout),
              color: Color.fromARGB(255, 134, 133, 133),
              tooltip: 'Logout',
            ),
          ],
        ),
      ),
    );
  }

  // This is the missing implementation
  @override
  Size get preferredSize =>
      Size.fromHeight(80.0); // Set the height of the header
}
