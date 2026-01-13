import 'package:bright_weddings/Component/Dashboard/circular_bullet.dart';
import 'package:bright_weddings/Helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Component/Dashboard/image_card.dart';
import '../../../Controller/profile_controller.dart';
import '../../../Helper/colors.dart';

class ProfileSettingsPage extends StatelessWidget {
  ProfileSettingsPage({super.key});

  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6.h),
      child: Obx(() => ListView.separated(
            itemCount: controller.filteredList.length,
            itemBuilder: (BuildContext context, int index) {
              final user = controller.filteredList[index];
              return Row(
                children: [
                  Container(
                    width: 20.w, // Adjusted width to make it more visible
                    height: 17.w, // Made height and width proportional
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ImageCard(imageUrl: user['image_url']),
                  ),
                  SizedBox(width: 5.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            user['full_name'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 1.1.t,
                                color: textColor),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CircularBullet(),
                          SizedBox(
                            width: 0.5.w,
                          ),
                          Text(user['address'],
                              style: GoogleFonts.poppins(
                                color: textColor,
                                fontSize: 1.t,
                              )),
                        ],
                      ),
                      SizedBox(
                        width: 2.h,
                      ),
                    ],
                  ),
                                  ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                child: Divider(
                  color: Color(0xFFE7E7E7),
                  thickness: 1,
                ),
              );
            },
          )),
    );
  }
}
