import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../Dashboard/dashboard_mob.dart';
import 'login_fallback.dart';

class LoginWebFirebaseTest extends StatefulWidget {
  const LoginWebFirebaseTest({Key? key}) : super(key: key);

  @override
  State<LoginWebFirebaseTest> createState() => _LoginWebFirebaseTestState();
}

class _LoginWebFirebaseTestState extends State<LoginWebFirebaseTest> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';
  bool _isRegistering = false;

  Future<void> _testFirebaseConnection() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Test Firebase connection with better error handling
      print("Testing Firebase connection...");
      final auth = FirebaseAuth.instance;
      print("Firebase Auth instance: $auth");
      
      // Test auth state changes listener (this often triggers the minification error)
      try {
        await auth.authStateChanges().first.timeout(Duration(seconds: 5));
        print("Auth state changes working");
      } catch (streamError) {
        print("Auth state stream error: $streamError");
        throw Exception("Firebase Auth stream error: ${streamError.toString()}");
      }
      
      // Try to get current user (this will test connection)
      final user = auth.currentUser;
      print("Current user: $user");
      
      setState(() {
        _errorMessage = "Firebase connection successful! Auth domain: ${auth.app.options.authDomain}";
        _isLoading = false;
      });
    } catch (e) {
      print("Firebase test error: $e");
      String errorMessage = e.toString();
      
      // Provide more helpful error messages for common issues
      if (errorMessage.contains('minified')) {
        errorMessage = "Firebase Web SDK minification error. This is a known Flutter web issue. Try using --no-tree-shake-icons flag when building.";
      } else if (errorMessage.contains('CORS')) {
        errorMessage = "CORS error - check if domain is properly authorized in Firebase Console";
      } else if (errorMessage.contains('unauthorized')) {
        errorMessage = "Domain not authorized in Firebase Console";
      }
      
      setState(() {
        _errorMessage = "Firebase Error: $errorMessage";
        _isLoading = false;
      });
    }
  }

  Future<void> _authenticate() async {
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
      final auth = FirebaseAuth.instance;
      
      if (_isRegistering) {
        // Register new user
        await auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
        setState(() {
          _errorMessage = "Account created successfully! You are now logged in.";
          _isLoading = false;
        });
      } else {
        // Sign in existing user
        await auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
        setState(() {
          _errorMessage = "Login successful!";
          _isLoading = false;
        });
      }
      
      // Wait a moment to show success message, then navigate
      await Future.delayed(Duration(seconds: 1));
      Get.offAll(() => DashboardMob());
      
    } catch (e) {
      print("Firebase authentication error: $e");
      setState(() {
        String errorMessage = e.toString();
        
        // Provide user-friendly error messages
        if (errorMessage.contains('user-not-found')) {
          errorMessage = 'No user found with this email. Please register first.';
        } else if (errorMessage.contains('wrong-password')) {
          errorMessage = 'Incorrect password. Please try again.';
        } else if (errorMessage.contains('email-already-in-use')) {
          errorMessage = 'This email is already registered. Please sign in instead.';
        } else if (errorMessage.contains('weak-password')) {
          errorMessage = 'Password is too weak. Please use at least 6 characters.';
        } else if (errorMessage.contains('invalid-email')) {
          errorMessage = 'Please enter a valid email address.';
        } else if (errorMessage.contains('network-request-failed')) {
          errorMessage = 'Network error. Please check your connection.';
        } else if (errorMessage.contains('too-many-requests')) {
          errorMessage = 'Too many attempts. Please try again later.';
        } else if (errorMessage.contains('minified')) {
          errorMessage = 'Firebase Web SDK compatibility issue. Domains are authorized but there may be a version conflict.';
        } else {
          errorMessage = 'Authentication failed: ${e.toString()}';
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
                    _isRegistering ? 'Create Account' : 'Firebase Test Login',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 30),
                  
                  // Test Firebase Connection Button
                  ElevatedButton(
                    onPressed: _isLoading ? null : _testFirebaseConnection,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text('Test Firebase Connection'),
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
                        color: _errorMessage.contains('successful') 
                            ? Colors.green[100] 
                            : Colors.red[100],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        _errorMessage,
                        style: TextStyle(
                          color: _errorMessage.contains('successful') 
                              ? Colors.green[800] 
                              : Colors.red[800],
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
                    ElevatedButton(
                      onPressed: _authenticate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF3D48A),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
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
                  
                  // Back to fallback
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
