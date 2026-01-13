import 'package:bright_weddings/Component/AppBar/header.dart';
import 'package:bright_weddings/Component/Dashboard/Recent_Success/recent_success_tab.dart';
import 'package:bright_weddings/Component/Dashboard/SideBar/sidebar_tab.dart';
import 'package:bright_weddings/Component/Dashboard/Success_Rate_View/success_rate_view_tab.dart';
import 'package:bright_weddings/Component/Dashboard/profile_list/profile_list_tab.dart';
import 'package:bright_weddings/Component/footer.dart';
import 'package:bright_weddings/Controller/screen_controller.dart';
import 'package:bright_weddings/Helper/colors.dart';
import 'package:bright_weddings/Helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Component/Dashboard/New Profile/new_profile_tab.dart';
import '../../Component/Dashboard/ProfileCompletionStatus/profile_completion_status_tab.dart';
import '../../Component/Dashboard/ProfileStatus/profile_status_tab.dart';
import '../../Component/Dashboard/SuccessGraph/success_graph_tab.dart';
import '../../Mock API/user_list.dart';


class DashboardTab extends StatelessWidget {
  DashboardTab({super.key});

  final ScreenController controller = Get.find<ScreenController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: Header(),
      body: Builder(builder: (bodyContext) {
        return Padding(
          padding: EdgeInsets.all(2.0.h),
          child: Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.all(5.0.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SidebarTab(),
                          SizedBox(height: 5.0.h),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'New Profile',
                                style: GoogleFonts.playfairDisplay(
                                    color: textColor,
                                    fontSize: 2.5.t,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 3.0.h),
                              NewProfileTab(
                                bodyContext: bodyContext,
                              ),
                              SizedBox(height: 3.0.h),
                              Row(
                                children: [
                                  Text(
                                    'Success Rate',
                                    style: GoogleFonts.playfairDisplay(
                                        color: textColor,
                                        fontSize: 2.5.t,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(height: 3.0.h),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SuccessRateViewTab(),
                                        SizedBox(
                                          height: 1.5.h,
                                        ),
                                        SuccessGraphTab()
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 3.0.h),
                              Text(
                                'Recent Success',
                                style: GoogleFonts.playfairDisplay(
                                    color: textColor,
                                    fontSize: 2.5.t,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 3.0.h),
                              RecentSuccessTab(userList: userList),
                              SizedBox(height: 3.0.h),
                              Text(
                                'Profile List',
                                style: GoogleFonts.playfairDisplay(
                                    color: textColor,
                                    fontSize: 2.5.t,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 3.0.h),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 3.0.h),
                                    ProfileListTab(),
                                    SizedBox(height: 3.0.h),
                                  ],
                                ),
                              ),
                              SizedBox(height: 3.0.h),
                              Text(
                                'Profile Status',
                                style: GoogleFonts.playfairDisplay(
                                    color: textColor,
                                    fontSize: 2.5.t,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 3.0.h),
                              Column(
                                children: [
                                  ProfileStatusTab(),
                                  SizedBox(
                                    height: 1.0.h,
                                  ),
                                  ProfileCompletionStatusTab()
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0.h),
                  Footer()
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
