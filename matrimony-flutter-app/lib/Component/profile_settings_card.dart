import 'package:bright_weddings/Component/switch_list_tile.dart';
import 'package:bright_weddings/Controller/profile_controller.dart';
import 'package:bright_weddings/Helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:bright_weddings/Helper/size_config.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileSettingsCard extends StatelessWidget {
  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2.w),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profiles',
            style: GoogleFonts.poppins(
              color: textColor,
              fontSize: 1.5.t,
            ),
          ),
          SizedBox(height: 1.h),
          Divider(),
          Padding(
            padding: EdgeInsets.all(2.w),
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 4.5.w,
                    backgroundImage: NetworkImage(
                      'https://rn53themes.net/themes/matrimo/images/profiles/12.jpg',
                    ),
                  ),
                  title: Text(
                    'Anna Jaslin',
                    style: GoogleFonts.poppins(
                        fontSize: 1.5.t, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    'Premium user',
                    style: GoogleFonts.poppins(
                        fontSize: 0.9.t, fontWeight: FontWeight.w400),
                  ),
                ),
                Divider(),
                Obx(() => CustomSwitchListTile(
                      title: 'Profile visible',
                      subtitle: 'You can set-up the visibility of profile.',
                      value: controller.isProfileVisible.value,
                      onChanged: (bool value) {
                        controller.isProfileVisible.value = value;
                      },
                    )),
                Divider(),
                Obx(
                  () => CustomSwitchListTile(
                    title: 'Change Status',
                    subtitle: 'You can change the status of profile.',
                    value: controller.isStatusChangeable.value,
                    onChanged: (bool value) {
                      controller.isStatusChangeable.value = value;
                    },
                  ),
                ),
                Divider()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
