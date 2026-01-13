import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Dashboard/dashboard_mob.dart';
import 'login_fallback.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginWebFirebaseImproved extends StatefulWidget {
  const LoginWebFirebaseImproved({Key? key}) : super(key: key);

  @override
  State<LoginWebFirebaseImproved> createState() =>
      _LoginWebFirebaseImprovedState();
}

class _LoginWebFirebaseImprovedState extends State<LoginWebFirebaseImproved> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';
  bool _isRegistering = false;

  Future<void> _authenticateWithFirebase() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill in all fields';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Use FirebaseAuth instance directly
      final auth = FirebaseAuth.instance;

      if (_isRegistering) {
        // Register new user
        await auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
      } else {
        // Sign in existing user
        await auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
      }

      // If successful, navigate to dashboard
      Get.offAll(() => DashboardMob());
    } catch (e) {
      print("Firebase authentication error: $e");
      setState(() {
        String errorMessage = e.toString();

        // Provide user-friendly error messages
        if (errorMessage.contains('user-not-found')) {
          errorMessage =
              'No user found with this email. Please register first.';
        } else if (errorMessage.contains('wrong-password')) {
          errorMessage = 'Incorrect password. Please try again.';
        } else if (errorMessage.contains('email-already-in-use')) {
          errorMessage =
              'This email is already registered. Please sign in instead.';
        } else if (errorMessage.contains('weak-password')) {
          errorMessage =
              'Password is too weak. Please use at least 6 characters.';
        } else if (errorMessage.contains('invalid-email')) {
          errorMessage = 'Please enter a valid email address.';
        } else if (errorMessage.contains('network-request-failed')) {
          errorMessage = 'Network error. Please check your connection.';
        } else if (errorMessage.contains('too-many-requests')) {
          errorMessage = 'Too many attempts. Please try again later.';
        } else {
          errorMessage = 'Authentication failed. Please try demo mode instead.';
        }

        _errorMessage = errorMessage;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF3D48A),
              Color(0xFFE8C468),
            ],
          ),
        ),
        child: Center(
          child: Card(
            margin: EdgeInsets.all(20),
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              constraints: BoxConstraints(maxWidth: 400),
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.favorite,
                    size: 60,
                    color: Color(0xFFF3D48A),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Bright Weddings',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8B4513),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _isRegistering ? 'Create Account' : 'Firebase Login',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 20),

                  // Firebase info
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'Real Firebase Authentication - Create account or sign in with existing credentials',
                      style: TextStyle(
                        color: Colors.green[800],
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(height: 20),

                  // Email Field
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 15),

                  // Password Field
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),

                  // Error Message
                  if (_errorMessage.isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.red[100],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        _errorMessage,
                        style: TextStyle(
                          color: Colors.red[800],
                          fontSize: 12,
                        ),
                      ),
                    ),

                  // Loading or Auth Button
                  if (_isLoading)
                    CircularProgressIndicator(
                      color: Color(0xFFF3D48A),
                    )
                  else
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _authenticateWithFirebase,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF3D48A),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          _isRegistering ? 'Create Account' : 'Sign In',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                  SizedBox(height: 20),

                  // Toggle between login and register
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isRegistering = !_isRegistering;
                        _errorMessage = '';
                      });
                    },
                    child: Text(
                      _isRegistering
                          ? 'Already have an account? Sign In'
                          : 'Need an account? Register',
                      style: TextStyle(
                        color: Color(0xFF8B4513),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Back to demo mode
                  TextButton(
                    onPressed: () {
                      Get.offAll(() => LoginFallback());
                    },
                    child: Text(
                      'Back to Demo Mode',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
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
}
