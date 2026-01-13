import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class LoginWebFirebase extends StatefulWidget {
  const LoginWebFirebase({super.key});

  @override
  _LoginWebFirebaseState createState() => _LoginWebFirebaseState();
}

class _LoginWebFirebaseState extends State<LoginWebFirebase> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  bool _isRegistering = false;

  // Firebase Email Login
  void loginUser() async {
    if (emailController.text.trim().isEmpty || passwordController.text.trim().isEmpty) {
      _showError("Please enter both email and password");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (userCredential.user != null) {
        _showSuccess("Login Successful! Welcome back!");
        // Navigate to dashboard
        Get.offAllNamed('/home');
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getFirebaseErrorMessage(e.code);
      _showError(errorMessage);
    } catch (e) {
      _showError("An unexpected error occurred. Please try again.");
      print("Login error: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Firebase Email Registration
  void registerUser() async {
    if (emailController.text.trim().isEmpty || passwordController.text.trim().isEmpty) {
      _showError("Please enter both email and password");
      return;
    }

    if (passwordController.text.trim().length < 6) {
      _showError("Password must be at least 6 characters long");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (userCredential.user != null) {
        _showSuccess("Registration Successful! Welcome to Bright Weddings!");
        // Navigate to dashboard
        Get.offAllNamed('/home');
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getFirebaseErrorMessage(e.code);
      _showError(errorMessage);
    } catch (e) {
      _showError("An unexpected error occurred. Please try again.");
      print("Registration error: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _getFirebaseErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return "No user found with this email address";
      case 'wrong-password':
        return "Incorrect password";
      case 'invalid-email':
        return "Invalid email address format";
      case 'user-disabled':
        return "This user account has been disabled";
      case 'too-many-requests':
        return "Too many login attempts. Please try again later";
      case 'email-already-in-use':
        return "An account already exists with this email";
      case 'weak-password':
        return "Password is too weak. Please choose a stronger password";
      case 'network-request-failed':
        return "Network error. Please check your internet connection";
      default:
        return "Authentication failed. Please try again";
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 4),
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFA726),
              Color(0xFFFF7043),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            // Left side - Branding
            Expanded(
              child: Container(
                padding: EdgeInsets.all(40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bright Weddings",
                      style: GoogleFonts.pacifico(
                        fontSize: 60,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Find your perfect match with our trusted matrimony services.",
                      style: GoogleFonts.roboto(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 40),
                    Icon(
                      Icons.favorite,
                      size: 200,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ],
                ),
              ),
            ),
            // Right side - Login/Register Form
            Expanded(
              child: Container(
                margin: EdgeInsets.all(40),
                padding: EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isRegistering ? "Create Account" : "Welcome Back!",
                      style: GoogleFonts.lobster(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF57C00),
                      ),
                    ),
                    SizedBox(height: 40),

                    // Email Field
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        prefixIcon: Icon(Icons.email, color: Color(0xFFF57C00)),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                    ),
                    SizedBox(height: 20),

                    // Password Field
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        prefixIcon: Icon(Icons.lock, color: Color(0xFFF57C00)),
                        filled: true,
                        fillColor: Colors.grey[50],
                        helperText: _isRegistering ? "Minimum 6 characters" : null,
                      ),
                    ),
                    SizedBox(height: 30),

                    // Login/Register Button
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : (_isRegistering ? registerUser : loginUser),
                        child: _isLoading 
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              _isRegistering ? "Create Account" : "Login",
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isLoading ? Colors.grey : Color(0xFFFFA726),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    // Toggle between Login and Register
                    TextButton(
                      onPressed: _isLoading ? null : () {
                        setState(() {
                          _isRegistering = !_isRegistering;
                          emailController.clear();
                          passwordController.clear();
                        });
                      },
                      child: Text(
                        _isRegistering 
                          ? "Already have an account? Login here"
                          : "Don't have an account? Register here",
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: Color(0xFFF57C00),
                        ),
                      ),
                    ),

                    // Firebase status indicator
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.security, color: Colors.green, size: 16),
                          SizedBox(width: 8),
                          Text(
                            "Firebase Authentication Enabled",
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: Colors.green.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
