import 'package:bright_weddings/View/Dashboard/dashboard_mobile.dart';
import 'package:bright_weddings/View/Dashboard/dashboard_tab.dart';
import 'package:flutter/material.dart';
import '../../Helper/responsive.dart';
import 'dashboard_web.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
      tablet: DashboardTab(),
      mobile: DashboardMobile(),
      desktop: DashboardWeb(),
    );
  }
}
