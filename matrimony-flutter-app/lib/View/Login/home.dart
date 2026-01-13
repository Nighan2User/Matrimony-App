import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:bright_weddings/View/Login/login_original_firebase.dart';
import 'package:bright_weddings/Helper/colors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:animate_do/animate_do.dart';

class LoginHome extends StatefulWidget {
  const LoginHome({super.key});

  @override
  State<LoginHome> createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  String? selectedRole;
  bool hide = false;

  // Guard so we don't push multiple times if the animation completes repeatedly.
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 30.0)
        .animate(_scaleController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed && !_isNavigating) {
          _isNavigating = true;

          // Determine target page based on selected role
          final targetPage = (selectedRole == "Login")
              ? LoginOriginalFirebase(startWithRegister: false)
              : LoginOriginalFirebase(startWithRegister: true);

          Navigator.push(
            context,
            PageTransition(type: PageTransitionType.fade, child: targetPage),
          ).then((_) {
            // When coming back, reset animation and show buttons again
            if (mounted) {
              setState(() {
                hide = false;
                selectedRole = null;
              });
              _scaleController.reverse(); // Animate back to original
            }
            _isNavigating = false;
          });
        }
      });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/brightWedding.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              colors: [
                Colors.black.withOpacity(.9),
                Colors.black.withOpacity(.4),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FadeInUp(
                  duration: Duration(milliseconds: 1000),
                  child: Text(
                    "Connecting Hearts, Joining Lives",
                    style: TextStyle(
                      color: const Color.fromARGB(223, 241, 214, 214),
                      height: 1.2,
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(height: 13),
                InkWell(
                  onTap: () {
                    setState(() {
                      hide = true;
                      selectedRole = "Login";
                    });
                    _scaleController.forward();
                  },
                  child: AnimatedBuilder(
                    animation: _scaleController,
                    builder: (context, child) => Transform.scale(
                      scale: _scaleAnimation.value,
                      child: FadeInUp(
                        duration: Duration(milliseconds: 1500),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [dashboardSelectedColor, Color(0xFFB91C5A)],
                            ),
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: dashboardSelectedColor.withOpacity(0.3),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: hide == false
                                ? Text(
                                    "Login",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  )
                                : Container(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    setState(() {
                      hide = true;
                      selectedRole = "Register";
                    });
                    _scaleController.forward();
                  },
                  child: AnimatedBuilder(
                    animation: _scaleController,
                    builder: (context, child) => Transform.scale(
                      scale: _scaleAnimation.value,
                      child: FadeInUp(
                        duration: Duration(milliseconds: 1500),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: hide == false
                                ? Text(
                                    "Register",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: dashboardSelectedColor,
                                    ),
                                  )
                                : Container(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
