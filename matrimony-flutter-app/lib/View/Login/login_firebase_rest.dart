import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Dashboard/dashboard_mob.dart';
import 'login_fallback.dart';
import '../../Controller/firebase_auth_controller.dart';
import '../../Controller/firestore_data_controller.dart';

class LoginFirebaseRest extends StatefulWidget {
  const LoginFirebaseRest({Key? key}) : super(key: key);

  @override
  State<LoginFirebaseRest> createState() => _LoginFirebaseRestState();
}

class _LoginFirebaseRestState extends State<LoginFirebaseRest> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';
  bool _isRegistering = false;
  
  // Get the Firebase Auth Controller
  final FirebaseAuthController authController = Get.put(FirebaseAuthController());
  final FirestoreDataController firestoreController = Get.put(FirestoreDataController());

  // Firebase Web API Key from your firebase_options.dart
  final String _apiKey = "AIzaSyCfcn_q14Wc-AnYPshuJWHtAEzP_Jxf3Bo";

  Future<void> _authenticateWithFirebaseRest() async {
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
        // Register new user
        url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_apiKey';
      } else {
        // Sign in existing user
        url = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_apiKey';
      }

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': _emailController.text.trim(),
          'password': _passwordController.text,
          'returnSecureToken': true,
        }),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        // Success
        final idToken = responseData['idToken'];
        final email = responseData['email'];
        final localId = responseData['localId'];
        
        print("Firebase Auth Success:");
        print("ID Token: $idToken");
        print("Email: $email");
        print("User ID: $localId");

        setState(() {
          _errorMessage = _isRegistering 
              ? "Account created successfully! Loading your data..."
              : "Login successful! Loading matrimony data...";
        });

        // Store user info in the auth controller
        authController.login(email, idToken, localId);
        
        // Fetch real Firestore data using the ID token
        print("Fetching user data from Firestore...");
        await firestoreController.fetchUsers(idToken);
        
        // Check if this user exists in Firestore users collection
        final currentUser = await firestoreController.fetchUserById(localId, idToken);
        
        if (currentUser != null) {
          print("User found in Firestore: ${currentUser['name']} (${currentUser['email']})");
          setState(() {
            _errorMessage = "Welcome back ${currentUser['name']}! Found ${firestoreController.users.length} profiles.";
          });
        } else {
          print("User not found in Firestore users collection");
          setState(() {
            _errorMessage = "Authentication successful! Found ${firestoreController.users.length} matrimony profiles.";
          });
        }

        // Wait a moment to show success message
        await Future.delayed(Duration(seconds: 3));
        
        // Navigate to dashboard with real Firebase data
        Get.offAll(() => DashboardMob());
        
      } else {
        // Error occurred
        String errorMessage = 'Authentication failed';
        
        if (responseData['error'] != null) {
          final errorCode = responseData['error']['message'];
          
          switch (errorCode) {
            case 'EMAIL_EXISTS':
              errorMessage = 'This email is already registered. Please sign in instead.';
              break;
            case 'EMAIL_NOT_FOUND':
              errorMessage = 'No user found with this email. Please register first.';
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
      print("Network error: $e");
      setState(() {
        _errorMessage = 'Network error. Please check your connection and try again.';
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
                    child: Column(
                      children: [
                        Text(
                          '🔥 Real Firebase Authentication + Firestore Data',
                          style: TextStyle(
                            color: Colors.green[800],
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5),
                        Obx(() => Text(
                          firestoreController.users.length > 0 
                              ? 'Connected: ${firestoreController.users.length} matrimony profiles loaded'
                              : 'Ready to connect to your Firebase database',
                          style: TextStyle(
                            color: Colors.green[600],
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        )),
                      ],
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
                      labelText: 'Password (min 6 characters)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  
                  // Error/Success Message
                  if (_errorMessage.isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: _errorMessage.contains('successful') || _errorMessage.contains('Welcome')
                            ? Colors.green[100]
                            : Colors.red[100],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        _errorMessage,
                        style: TextStyle(
                          color: _errorMessage.contains('successful') || _errorMessage.contains('Welcome')
                              ? Colors.green[800]
                              : Colors.red[800],
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
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
                        onPressed: _authenticateWithFirebaseRest,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF3D48A),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          _isRegistering ? 'Create Account' : 'Sign In with Firebase',
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
