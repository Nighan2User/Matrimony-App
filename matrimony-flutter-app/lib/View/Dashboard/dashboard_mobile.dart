import 'package:bright_weddings/Component/AppBar/header.dart';
import 'package:bright_weddings/Component/Dashboard/Recent_Success/recent_success.dart';
import 'package:bright_weddings/Component/Dashboard/SideBar/sidebar_tab.dart';
import 'package:bright_weddings/Component/Dashboard/Success_Rate_View/success_rate_view.dart';
import 'package:bright_weddings/Component/Dashboard/profile_list/profile_list_tab.dart';
import 'package:bright_weddings/Component/footer.dart';
import 'package:bright_weddings/Controller/screen_controller.dart';
import 'package:bright_weddings/Helper/colors.dart';
import 'package:bright_weddings/Helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Component/Dashboard/New Profile/new_profile.dart';
import '../../Component/Dashboard/ProfileCompletionStatus/profile_completion_status.dart';
import '../../Component/Dashboard/ProfileStatus/profile_status.dart';
import '../../Component/Dashboard/SuccessGraph/success_graph.dart';
import '../../Mock API/user_list.dart';

class DashboardMobile extends StatelessWidget {
  DashboardMobile({super.key});

  final ScreenController controller = Get.find<ScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: Header(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.0.w, vertical: 2.0.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SidebarTab(),
              SizedBox(height: 4.0.h),

              // New Profile Section
              _buildSectionTitle('New Profile'),
              SizedBox(height: 2.0.h),
              NewProfile(bodyContext: context),
              SizedBox(height: 3.0.h),

              // Recent Success Section
              _buildSectionTitle('Recent Success'),
              SizedBox(height: 2.0.h),
              RecentSuccess(userList: userList),
              SizedBox(height: 3.0.h),

              // Profile List Section
              _buildSectionTitle('Profile List'),
              SizedBox(height: 2.0.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width),
                  child: ProfileListTab(),
                ),
              ),
              SizedBox(height: 3.0.h),

              // Profile Status Section
              _buildSectionTitle('Profile Status'),
              SizedBox(height: 2.0.h),
              Column(
                children: [
                  ProfileStatus(),
                  SizedBox(height: 1.0.h),
                  ProfileCompletionStatus(),
                ],
              ),
              SizedBox(height: 5.0.h),

              Footer(),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for section titles
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.playfairDisplay(
        color: textColor,
        fontSize: 2.2.t,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Helper method for the success rate section
  Widget _buildSuccessRateView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Column(
            children: [
              SuccessRateView(),
              SizedBox(height: 1.5.h),
              SuccessGraph(),
            ],
          ),
        ],
      ),
    );
  }
}
