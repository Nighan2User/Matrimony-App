import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bright_weddings/View/Login/home.dart';
import 'package:bright_weddings/View/Dashboard/dashboard_mob.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Show loading while checking auth state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Color(0xFFF57C00),
              ),
            ),
          );
        }
        
        // If user is logged in, show dashboard
        if (snapshot.hasData) {
          return DashboardMob();
        }
        
        // If user is not logged in, show login page
        return LoginHome();
      },
    );
  }
}
