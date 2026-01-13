import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import '../Dashboard/dashboard_mob.dart';
import '../../Controller/firebase_auth_controller.dart';
import '../../Helper/colors.dart';

class LoginOriginalFirebase extends StatefulWidget {
  final bool startWithRegister;

  const LoginOriginalFirebase({Key? key, this.startWithRegister = false})
      : super(key: key);

  @override
  State<LoginOriginalFirebase> createState() => _LoginOriginalFirebaseState();
}

class _LoginOriginalFirebaseState extends State<LoginOriginalFirebase> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';
  late bool _isRegistering;
  bool _obscurePassword = true;

  // Get the Firebase Auth Controller
  final FirebaseAuthController authController =
      Get.put(FirebaseAuthController());

  // Firebase Web API Key
  final String _apiKey = "AIzaSyCfcn_q14Wc-AnYPshuJWHtAEzP_Jxf3Bo";

  @override
  void initState() {
    super.initState();
    _isRegistering = widget.startWithRegister;
  }

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
      String url;
      if (_isRegistering) {
        url =
            'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_apiKey';
      } else {
        url =
            'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_apiKey';
      }

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': _emailController.text.trim(),
          'password': _passwordController.text,
          'returnSecureToken': true,
        }),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final idToken = responseData['idToken'];
        final email = responseData['email'];
        final localId = responseData['localId'];

        setState(() {
          _errorMessage = _isRegistering
              ? "Welcome to Bright Weddings! Account created successfully."
              : "Welcome back! Login successful.";
        });

        await Future.delayed(Duration(seconds: 2));

        authController.login(email, idToken, localId);
        Get.offAll(() => DashboardMob());
      } else {
        String errorMessage = 'Authentication failed';

        if (responseData['error'] != null) {
          final errorCode = responseData['error']['message'];

          switch (errorCode) {
            case 'EMAIL_EXISTS':
              errorMessage =
                  'This email is already registered. Please sign in instead.';
              break;
            case 'EMAIL_NOT_FOUND':
              errorMessage =
                  'No user found with this email. Please register first.';
              break;
            case 'INVALID_PASSWORD':
              errorMessage = 'Incorrect password. Please try again.';
              break;
            case 'USER_DISABLED':
              errorMessage = 'This account has been disabled.';
              break;
            case 'TOO_MANY_ATTEMPTS_TRY_LATER':
              errorMessage = 'Too many attempts. Please try again later.';
              break;
            case 'INVALID_EMAIL':
              errorMessage = 'Please enter a valid email address.';
              break;
            case 'WEAK_PASSWORD':
              errorMessage = 'Password should be at least 6 characters.';
              break;
            default:
              errorMessage = 'Authentication failed: $errorCode';
          }
        }

        setState(() {
          _errorMessage = errorMessage;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage =
            'Network error. Please check your connection and try again.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: headerTitleColor),
          onPressed: () => Get.back(),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              backgroundColor,
              gradient1Color,
              gradient2Color,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top Section with Logo and Title
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 60),

                    // Logo/Icon
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: dashboardSelectedColor.withOpacity(0.2),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.favorite,
                        size: 60,
                        color: dashboardSelectedColor,
                      ),
                    ),

                    SizedBox(height: 30),

                    // App Title
                    Text(
                      'Bright Weddings',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: headerTitleColor,
                        letterSpacing: 1.2,
                        shadows: [
                          Shadow(
                            color: Colors.white.withOpacity(0.5),
                            offset: Offset(1, 1),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      'Find your perfect match',
                      style: TextStyle(
                        fontSize: 16,
                        color: textColor.withOpacity(0.8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // Login Form Section
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Form Header
                    Text(
                      _isRegistering ? 'Create Account' : 'Welcome Back',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: headerTitleColor,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 8),

                    Text(
                      _isRegistering
                          ? 'Join thousands of happy couples'
                          : 'Sign in to continue your journey',
                      style: TextStyle(
                        fontSize: 14,
                        color: otherTextColor,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 30),

                    // Email Field
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: borderColor),
                      ),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          prefixIcon: Icon(Icons.email_outlined,
                              color: dashboardSelectedColor),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          labelStyle: TextStyle(color: otherTextColor),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),

                    SizedBox(height: 20),

                    // Password Field
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: borderColor),
                      ),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock_outline,
                              color: dashboardSelectedColor),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: otherTextColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          labelStyle: TextStyle(color: otherTextColor),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    // Error/Success Message
                    if (_errorMessage.isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(12),
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: _errorMessage.contains('successful') ||
                                  _errorMessage.contains('Welcome')
                              ? Colors.green[50]
                              : Colors.red[50],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: _errorMessage.contains('successful') ||
                                    _errorMessage.contains('Welcome')
                                ? Colors.green[200]!
                                : Colors.red[200]!,
                          ),
                        ),
                        child: Text(
                          _errorMessage,
                          style: TextStyle(
                            color: _errorMessage.contains('successful') ||
                                    _errorMessage.contains('Welcome')
                                ? Colors.green[800]
                                : Colors.red[800],
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                    // Login/Register Button
                    Container(
                      height: 55,
                      child: ElevatedButton(
                        onPressed:
                            _isLoading ? null : _authenticateWithFirebase,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: dashboardSelectedColor,
                          foregroundColor: Colors.white,
                          elevation: 5,
                          shadowColor: dashboardSelectedColor.withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: _isLoading
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                _isRegistering ? 'Create Account' : 'Sign In',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                      ),
                    ),

                    SizedBox(height: 20),

                    // Toggle between login and register
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _isRegistering
                              ? 'Already have an account? '
                              : "Don't have an account? ",
                          style: TextStyle(color: otherTextColor),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isRegistering = !_isRegistering;
                              _errorMessage = '';
                            });
                          },
                          child: Text(
                            _isRegistering ? 'Sign In' : 'Sign Up',
                            style: TextStyle(
                              color: dashboardSelectedColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Forgot Password (for login only)
                    if (!_isRegistering) ...[
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: () async {
                          try {
                            await FirebaseAuth.instance.sendPasswordResetEmail(
                              email: _emailController.text,
                            );
                          } catch (e) {
                            setState(() {
                              _errorMessage = 'Error: ${e.toString()}';
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error: ${e.toString()}")),
                            );
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text("Password reset email sent")),
                          );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: otherTextColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              SizedBox(height: 30),

              // Footer
              Text(
                '© 2025 Bright Weddings. All rights reserved.',
                style: TextStyle(
                  color: textColor.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),

              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
