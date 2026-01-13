import 'package:bright_weddings/Component/Dashboard/image_card.dart';
import 'package:bright_weddings/Helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../View/Profile/EditProfile/edit_profile.dart';

class ProfileStatusTab extends StatelessWidget {
  const ProfileStatusTab({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(2.h),
      width: screenWidth * 0.7,
      height: screenHeight * 0.45,
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
                  width: screenWidth * 0.66,
                  height: screenHeight * 0.09,
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      'Edit Profile',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 2.0.t),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
