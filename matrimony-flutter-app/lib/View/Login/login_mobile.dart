import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginMobile extends StatefulWidget {
  @override
  _LoginMobileState createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId = "";
  bool otpSent = false;

  // Email Login
  void loginUser() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Successful!")),
      );

      Navigator.pushReplacementNamed(context, "/home");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Failed: ${e.toString()}")),
      );
    }
  }

  // Phone Number Login (OTP)
  void sendOTP() async {
  String phoneNumber = phoneController.text.trim();

  // Validate user input
  if (phoneNumber.isEmpty || phoneNumber.length < 10) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Enter a valid phone number")),
    );
    return;
  }

  if (!phoneNumber.startsWith("+")) {
    phoneNumber = "+91$phoneNumber";  
  }

  print("Sending OTP to: $phoneNumber");

  await _auth.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    verificationCompleted: (PhoneAuthCredential credential) async {
      await _auth.signInWithCredential(credential);
      Navigator.pushReplacementNamed(context, "/home");
    },
    verificationFailed: (FirebaseAuthException e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP Verification Failed: ${e.message}")),
      );
    },
    codeSent: (String verificationId, int? resendToken) {
      setState(() {
        this.verificationId = verificationId;
        otpSent = true;
      });
    },
    codeAutoRetrievalTimeout: (String verificationId) {},
  );
}




  void verifyOTP() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpController.text.trim(),
      );

      await _auth.signInWithCredential(credential);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Successful!")),
      );
      Navigator.pushReplacementNamed(context, "/home");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid OTP")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: GoogleFonts.pacifico(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color(0xFFF57C00),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to Bright Weddings!",
              style: GoogleFonts.lobster(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFF57C00)),
            ),
            SizedBox(height: 20),

            // Email Field
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                prefixIcon: Icon(Icons.email, color: Color(0xFFF57C00)),
              ),
            ),
            SizedBox(height: 20),

            // Password Field
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                prefixIcon: Icon(Icons.lock, color: Color(0xFFF57C00)),
              ),
            ),
            SizedBox(height: 20),

            // Email Login Button
            ElevatedButton(
              onPressed: loginUser,
              child: Text("Login with Email"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFA726),
              ),
            ),

            SizedBox(height: 30),

            // Phone Number Field
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Phone Number",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                prefixIcon: Icon(Icons.phone, color: Color(0xFFF57C00)),
              ),
            ),
            SizedBox(height: 20),

            // OTP Input Field (Visible only after OTP is sent)
            if (otpSent)
              Column(
                children: [
                  TextField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Enter OTP",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                      prefixIcon: Icon(Icons.lock_open, color: Color(0xFFF57C00)),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Verify OTP Button
                  ElevatedButton(
                    onPressed: verifyOTP,
                    child: Text("Verify OTP"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                ],
              ),

            // Send OTP Button 
            if (!otpSent)
              ElevatedButton(
                onPressed: sendOTP,
                child: Text("Send OTP"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFA726),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
