import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../Dashboard/dashboard_mob.dart';
import 'login_web_firebase.dart';
import 'login_fallback.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if Firebase is properly initialized
    try {
      return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Show loading while checking authentication
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Color(0xFFF3D48A),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Loading...',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF8B4513),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          
          // If error or no connection, show fallback
          if (snapshot.hasError) {
            print("Firebase Auth Error: ${snapshot.error}");
            return LoginFallback();
          }
          
          // If user is signed in, go to dashboard
          if (snapshot.hasData && snapshot.data != null) {
            return DashboardMob();
          }
          
          // If no user, show login
          return LoginWebFirebase();
        },
      );
    } catch (e) {
      print("Firebase Auth not available: $e");
      // If Firebase is not available, show fallback
      return LoginFallback();
    }
  }
}
