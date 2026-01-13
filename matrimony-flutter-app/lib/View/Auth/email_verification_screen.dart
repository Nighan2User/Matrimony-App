import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bright_weddings/Controller/firebase_auth_controller.dart';
import 'package:bright_weddings/Helper/colors.dart';
import 'dart:async';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final FirebaseAuthController authController = Get.find<FirebaseAuthController>();
  Timer? _timer;
  bool _isResendingEmail = false;
  int _resendCooldown = 0;

  @override
  void initState() {
    super.initState();
    // Send initial verification email
    _sendVerificationEmail();
    
    // Check verification status every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _checkEmailVerification();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _sendVerificationEmail() async {
    if (_isResendingEmail) return;
    
    setState(() {
      _isResendingEmail = true;
      _resendCooldown = 60; // 60 second cooldown
    });

    try {
      await authController.sendEmailVerification();
      
      // Start cooldown timer
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_resendCooldown > 0) {
          setState(() {
            _resendCooldown--;
          });
        } else {
          timer.cancel();
          setState(() {
            _isResendingEmail = false;
          });
        }
      });
      
      Get.snackbar(
        'Email Sent',
        'Verification email sent to ${authController.userEmail.value}',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      setState(() {
        _isResendingEmail = false;
        _resendCooldown = 0;
      });
      
      Get.snackbar(
        'Error',
        'Failed to send verification email: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _checkEmailVerification() async {
    await authController.reloadUser();
    
    if (authController.isEmailVerified.value) {
      _timer?.cancel();
      Get.offAllNamed('/home'); // Navigate to main app
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Email verification icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: dashboardSelectedColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.mark_email_unread_outlined,
                  size: 60,
                  color: dashboardSelectedColor,
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Title
              Text(
                'Verify Your Email',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: dashboardSelectedColor,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 16),
              
              // Description
              Obx(() => Text(
                'We\'ve sent a verification link to:\n${authController.userEmail.value}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              )),
              
              const SizedBox(height: 24),
              
              // Instructions
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.blue, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Please check your email and click the verification link.',
                            style: TextStyle(color: Colors.blue[700]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This page will automatically redirect once verified.',
                      style: TextStyle(
                        color: Colors.blue[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Resend email button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isResendingEmail ? null : _sendVerificationEmail,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: dashboardSelectedColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: _isResendingEmail
                      ? Text(
                          'Resend in ${_resendCooldown}s',
                          style: const TextStyle(color: Colors.white),
                        )
                      : const Text(
                          'Resend Verification Email',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Manual check button
              TextButton(
                onPressed: _checkEmailVerification,
                child: Text(
                  'I\'ve verified my email',
                  style: TextStyle(
                    color: dashboardSelectedColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Logout option
              TextButton(
                onPressed: () {
                  authController.logout();
                  Get.offAllNamed('/');
                },
                child: const Text(
                  'Use different email? Logout',
                  style: TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}