import 'package:flutter/material.dart';

class AppStyles {
  // Colors - Modern matrimony palette
  static const Color primaryColor = Color(0xFFD4436A);
  static const Color secondaryColor = Color(0xFF10B981);
  static const Color accentColor = Color(0xFFF59E0B);
  static const Color errorColor = Color(0xFFEF4444);
  
  // Gradient Colors for Buttons - Soft, elegant gradients
  static const Gradient buttonGradientLogin = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFD4436A), Color(0xFFB91C5A)],
  );
  
  static const Gradient buttonGradientRegister = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF10B981), Color(0xFF059669)],
  );

  static const Gradient buttonGradientDashboard = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
  );
  
  // Text Styles
  static const TextStyle headerTextStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: Color(0xFF1E293B),
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 16.0,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );
}
