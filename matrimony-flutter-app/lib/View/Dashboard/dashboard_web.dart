import 'package:bright_weddings/Component/AppBar/header.dart';
import 'package:bright_weddings/Component/Dashboard/SideBar/sidebar.dart';
import 'package:bright_weddings/Component/footer.dart';
import 'package:bright_weddings/Component/profile_settings_card.dart';
import 'package:bright_weddings/Controller/screen_controller.dart';
import 'package:bright_weddings/Helper/colors.dart';
import 'package:bright_weddings/Helper/size_config.dart';
import 'package:bright_weddings/View/Profile/ProfileSettings/profile_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Component/Dashboard/New Profile/new_profile.dart';
import '../../Component/Dashboard/ProfileCompletionStatus/profile_completion_status.dart';
import '../../Component/Dashboard/profile_list/profile_list.dart';
import '../../Component/Dashboard/ProfileStatus/profile_status.dart';
import '../../Component/Dashboard/Recent_Success/recent_success.dart';
import '../../Component/Dashboard/SuccessGraph/success_graph.dart';
import '../../Component/Dashboard/Success_Rate_View/success_rate_view.dart';
import '../../Mock API/user_list.dart';
import '../Profile/profiles.dart';

class DashboardWeb extends StatelessWidget {
  DashboardWeb({super.key});

  final ScreenController controller = Get.find<ScreenController>();
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _newProfileKey = GlobalKey();
  final GlobalKey _successRateKey = GlobalKey();
  final GlobalKey _profileListKey = GlobalKey();
  final GlobalKey _profileSettingsKey = GlobalKey();
  final GlobalKey _profileStatusKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: Header(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(14.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Sidebar(
                          onSidebarItemSelected: (index) {
                            _scrollToSection(index);
                          },
                        ),
                        SizedBox(
                          width: 5.0.w,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                key: _newProfileKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'New Profile',
                                      style: GoogleFonts.playfairDisplay(
                                          color: textColor,
                                          fontSize: 1.5.t,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 2.0.h),
                                    NewProfile(
                                      bodyContext: context,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 3.0.h),
                              Row(
                                children: [
                                  Text(
                                    'Success Rate',
                                    style: GoogleFonts.playfairDisplay(
                                        color: textColor,
                                        fontSize: 1.5.t,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 66.w,
                                  ),
                                  Text(
                                    'Recent Success',
                                    style: GoogleFonts.playfairDisplay(
                                        color: textColor,
                                        fontSize: 1.5.t,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(height: 3.0.h),
                              Container(
                                key: _successRateKey,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SuccessRateView(),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          SuccessGraph()
                                        ],
                                      ),
                                      SizedBox(
                                        width: 5.0.w,
                                      ),
                                      RecentSuccess(userList: userList)
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 3.0.h),
                              Container(
                                key: _profileListKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Get.to(() => Profiles());
                                      },
                                      child: Text(
                                        'Profile List',
                                        style: GoogleFonts.playfairDisplay(
                                            color: textColor,
                                            fontSize: 1.5.t,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(height: 3.0.h),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                              clipBehavior: Clip.hardEdge,
                                              padding: EdgeInsets.all(8.w),
                                              height: 50.h,
                                              width: 133.0.w,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.25),
                                                    offset: Offset(0, 4),
                                                    blurRadius: 4.0,
                                                  ),
                                                ],
                                              ),
                                              child: ProfileList()),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 3.0.h),
                              Container(
                                key: _profileStatusKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Profile Status',
                                      style: GoogleFonts.playfairDisplay(
                                          color: textColor,
                                          fontSize: 1.5.t,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 3.0.h),
                                    Row(
                                      children: [
                                        ProfileStatus(),
                                        SizedBox(
                                          width: 5.0.w,
                                        ),
                                        ProfileCompletionStatus()
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 3.0.h),
                              Container(
                                key: _profileSettingsKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Get.to(() => ProfileSettingsPage());
                                      },
                                      child: Text(
                                        'Profile Settings',
                                        style: GoogleFonts.playfairDisplay(
                                            color: textColor,
                                            fontSize: 1.5.t,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(height: 2.0.h),
                                    ProfileSettingsCard()
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0.h),
                  Footer()
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Image(
                image: AssetImage(
                  'assets/images/leaves.png',
                ),
                height: 17.h,
                width: 28.w,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _scrollToSection(int index) {
    Map<int, GlobalKey> sectionKeys = {
      0: _newProfileKey,
      1: _successRateKey,
      2: _profileListKey,
      3: _profileSettingsKey,
      3: _profileStatusKey,
    };

    GlobalKey? key = sectionKeys[index];
    if (key != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
}
