import 'package:bright_weddings/View/Login/login_mobile.dart';
import 'package:bright_weddings/View/Login/login_web_firebase.dart';
import 'package:flutter/material.dart';
import '../../Helper/responsive.dart';

class ResponsiveLogin extends StatelessWidget {
  const ResponsiveLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: LoginMobile(),
      tablet: LoginWebFirebase(),
      desktop: LoginWebFirebase(),
    );
  }
}
