import 'package:bright_weddings/Component/Dashboard/image_card.dart';
import 'package:bright_weddings/Helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../View/Profile/EditProfile/edit_profile.dart';

class ProfileStatus extends StatelessWidget {
  const ProfileStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.h),
      height: 30.0.h,
      width: 85.0.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: Offset(0, 4),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Stack(
        children: [
          ImageCard(
              imageUrl:
                  'https://rn53themes.net/themes/matrimo/images/profiles/12.jpg'),
          Positioned(
              bottom: 0,
              child: InkWell(
                onTap: () {
                  Get.to(() => EditProfile());
                },
                child: Container(
                  height: 5.h,
                  width: 77.w,
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      'Edit Profile',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 1.2.t),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
