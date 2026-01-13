import 'package:flutter/material.dart';
// Make sure this path is correct for your project structure
import 'package:bright_weddings/Controller/auth_service.dart';
import 'package:bright_weddings/core/app_constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // A GlobalKey to uniquely identify and manage the Form state.
  final _formKey = GlobalKey<FormState>();

  // Controllers to manage the text in the TextFields.
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  // State variable to hold the verification ID from Firebase.
  String verificationId = "";

  // --- Logic Methods ---

  // Method to request OTP from the authentication service.
  void requestOTP() {
    // First, check if the form fields are valid.
    if (_formKey.currentState!.validate()) {
      // If validation passes, then call the AuthService.
      AuthService().signInWithPhone(phoneController.text, (String verId) {
        setState(() {
          verificationId = verId;
        });
        // Show a confirmation message to the user.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('OTP has been sent!')),
        );
      });
    }
  }

  // Method to verify the entered OTP.
  void verifyOTP() async {
    // First, check if the form fields are valid.
    if (_formKey.currentState!.validate()) {
      // If validation passes, then attempt to verify the OTP.
      try {
        await AuthService().verifyOTP(verificationId, otpController.text);
        print("Login Successful!");
        // TODO: Navigate to the home screen upon successful login.
        // For example: Navigator.pushReplacementNamed(context, '/home');
      } catch (e) {
        print("Error verifying OTP: $e");
        // Show an error message to the user.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: Invalid OTP')),
        );
      }
    }
  }

  // --- UI Build Method ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: AppColors.primaryColor,
      ),
      // Use a Form widget to enable validation for its children.
      body: Form(
        key: _formKey, // Assign the key to the form.
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Use TextFormField instead of TextField for validation.
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Enter Phone Number",
                  border: OutlineInputBorder(),
                ),
                // Validator for the phone number field.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  } else if (value.length < 10) {
                    return 'Please enter a valid 10-digit number';
                  }
                  return null; // Return null if the input is valid.
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: AppSizes.medium),
                ),
                onPressed: requestOTP,
                child: Text("Request OTP"),
              ),
              SizedBox(height: AppSizes.screenPadding),
              // Use TextFormField for the OTP field as well.
              TextFormField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Enter OTP",
                  border: OutlineInputBorder(),
                ),
                // Validator for the OTP field.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the OTP';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppSizes.screenPadding),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: AppSizes.medium),
                ),
                onPressed: verifyOTP,
                child: Text("Verify OTP"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppSizes {
  static const double medium = 16.0;
  static const double screenPadding = 16.0;
}
