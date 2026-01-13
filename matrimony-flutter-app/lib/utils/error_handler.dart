import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ErrorHandler {
  static void handleError(dynamic error, {String? context}) {
    String message = _getErrorMessage(error);
    String title = _getErrorTitle(error);
    
    // Log error for debugging
    print('Error in $context: $error');
    
    // Show user-friendly message
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
    );
  }

  static String _getErrorTitle(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
        case 'wrong-password':
        case 'invalid-credential':
          return 'Login Failed';
        case 'email-already-in-use':
          return 'Registration Failed';
        case 'weak-password':
          return 'Weak Password';
        case 'invalid-email':
          return 'Invalid Email';
        case 'too-many-requests':
          return 'Too Many Attempts';
        case 'network-request-failed':
          return 'Network Error';
        default:
          return 'Authentication Error';
      }
    } else if (error is FirebaseException) {
      switch (error.code) {
        case 'permission-denied':
          return 'Access Denied';
        case 'unavailable':
          return 'Service Unavailable';
        case 'deadline-exceeded':
          return 'Request Timeout';
        default:
          return 'Database Error';
      }
    }
    return 'Error';
  }

  static String _getErrorMessage(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          return 'No account found with this email address.';
        case 'wrong-password':
          return 'Incorrect password. Please try again.';
        case 'invalid-credential':
          return 'Invalid email or password. Please check your credentials.';
        case 'email-already-in-use':
          return 'An account already exists with this email address.';
        case 'weak-password':
          return 'Password should be at least 6 characters long.';
        case 'invalid-email':
          return 'Please enter a valid email address.';
        case 'too-many-requests':
          return 'Too many failed attempts. Please try again later.';
        case 'network-request-failed':
          return 'Please check your internet connection and try again.';
        case 'user-disabled':
          return 'This account has been disabled. Please contact support.';
        case 'operation-not-allowed':
          return 'This sign-in method is not enabled. Please contact support.';
        default:
          return error.message ?? 'An authentication error occurred.';
      }
    } else if (error is FirebaseException) {
      switch (error.code) {
        case 'permission-denied':
          return 'You don\'t have permission to access this data. Please verify your email.';
        case 'unavailable':
          return 'Service is temporarily unavailable. Please try again later.';
        case 'deadline-exceeded':
          return 'Request timed out. Please check your connection.';
        case 'already-exists':
          return 'This data already exists.';
        case 'not-found':
          return 'Requested data not found.';
        default:
          return error.message ?? 'A database error occurred.';
      }
    } else if (error.toString().contains('SocketException')) {
      return 'No internet connection. Please check your network.';
    } else if (error.toString().contains('TimeoutException')) {
      return 'Request timed out. Please try again.';
    }
    
    return 'An unexpected error occurred. Please try again.';
  }

  // Success messages
  static void showSuccess(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
    );
  }

  // Info messages
  static void showInfo(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
    );
  }

  // Warning messages
  static void showWarning(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
    );
  }
}