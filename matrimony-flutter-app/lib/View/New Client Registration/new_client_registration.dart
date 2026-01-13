import 'package:bright_weddings/View/New%20Client%20Registration/new_client_registration_mobile.dart';
import 'package:bright_weddings/View/New%20Client%20Registration/new_client_registration_web.dart';
import 'package:flutter/material.dart';
import '../../Helper/responsive.dart';

class NewClientRegistration extends StatelessWidget {
  const NewClientRegistration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
      tablet: NewClientRegistrationWeb(),
      mobile: NewClientRegistrationMobile(),
      desktop: NewClientRegistrationWeb(),
    );
  }
}
