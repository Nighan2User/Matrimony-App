import 'package:flutter/material.dart';
import '../../Helper/responsive.dart';
import 'login_mobile.dart';
import 'login_web.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
      tablet: LoginWeb(),
      mobile: LoginMobile(),
      desktop: LoginWeb(),
    );
  }
}
