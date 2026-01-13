import 'package:bright_weddings/Component/Dashboard/image_card.dart';
import 'package:bright_weddings/Component/Dashboard/SideBar/SideBaritems/sidebar_item.dart';
import 'package:bright_weddings/Controller/screen_controller.dart';
import 'package:bright_weddings/Helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Sidebar extends StatelessWidget {
  final Function(int) onSidebarItemSelected; // Add callback function

  Sidebar({super.key, required this.onSidebarItemSelected});

  final ScreenController controller = Get.find<ScreenController>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.45.w),
      height: screenHeight * 0.8,
      width: screenWidth * 0.20,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: Offset(0, 4),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(20),
            width: screenWidth * 0.5,
            height: screenHeight * 0.3,
            child: ImageCard(
              imageUrl:
              'https://rn53themes.net/themes/matrimo/images/profiles/12.jpg',
            ),
          ),
          SizedBox(height: 1.5.h),
          Obx(() => SidebarItem(
            title: "Dashboard",
            isSelected: controller.selectedScreen.value == 0,
            onTap: () {
              controller.selectedScreen.value = 0;
              onSidebarItemSelected(0); // Notify the parent
            },
          )),
          SizedBox(height: 0.5.h),
          Obx(() => SidebarItem(
            title: "Profiles",
            isSelected: controller.selectedScreen.value == 1,
            onTap: () {
              controller.selectedScreen.value = 1;
              onSidebarItemSelected(1); // Notify the parent
            },
          )),
          SizedBox(height: 0.5.h),
          Obx(() => SidebarItem(
            title: "Profile list",
            isSelected: controller.selectedScreen.value == 2,
            onTap: () {
              controller.selectedScreen.value = 2;
              onSidebarItemSelected(2); // Notify the parent
            },
          )),
          SizedBox(height: 0.5.h),
          Obx(() => SidebarItem(
            title: "Settings",
            isSelected: controller.selectedScreen.value == 3,
            onTap: () {
              controller.selectedScreen.value = 3;
              onSidebarItemSelected(3); // Notify the parent
            },
          )),
          SizedBox(height: 0.5.h),
          Obx(() => SidebarItem(
            title: "Log out",
            isSelected: controller.selectedScreen.value == 4,
            onTap: () {
              controller.selectedScreen.value = 4;
              onSidebarItemSelected(4); // Notify the parent
            },
          )),
          SizedBox(height: 0.5.h),
        ],
      ),
    );
  }
}
