import 'package:bright_weddings/Component/ProfileDetailsComponent/contact_info_file.dart';
import 'package:bright_weddings/Component/ProfileDetailsComponent/info_tile.dart';
import 'package:bright_weddings/Component/ProfileDetailsComponent/personal_info.dart';
import 'package:bright_weddings/Helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:bright_weddings/Helper/size_config.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileDetailsComponent extends StatelessWidget {
  final Map<String, dynamic> user;

  ProfileDetailsComponent({required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 3.0.h,),
        Text(
          user['full_name'] ?? 'No Name Provided',
          style: GoogleFonts.playfairDisplay(
            fontSize: 2.5.t,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 1.0.h),
        Row(
          children: [
            InkWell(
              onTap: () {
              },
              child: Container(
                height: 2.h,
                width: 23.w,
                color: Color(0xFF5DC647),
                child: Center(
                  child: Text(
                    'Profile History',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 1.0.t,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 3.w,),
            InkWell(
              onTap: () {
              },
              child: Container(
                height: 2.h,
                width: 23.w,
                color: Color(0xFF5DC647),
                child: Center(
                  child: Text(
                    'Edit Profile',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 1.0.t,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 2.0.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InfoTile(
              label: 'City',
              value: user['city'] ?? 'N/A', // Fetch city dynamically
              icon: Icons.location_city,
              iconColor: Colors.purple,
            ),
            SizedBox(width: 1.w),
            InfoTile(
              label: 'Age',
              value: user['age']?.toString() ?? 'N/A', // Fetch age dynamically
              icon: Icons.calendar_month,
              iconColor: Colors.pinkAccent,
            ),
            SizedBox(width: 1.w),
            InfoTile(
              label: 'Height',
              value: user['height'] ?? 'N/A', // Fetch height dynamically
              icon: Icons.height,
              iconColor: Colors.orange,
            ),
            SizedBox(width: 1.w),
            InfoTile(
              label: 'Job',
              value: user['job'] ?? 'N/A', // Fetch job dynamically
              icon: Icons.work,
              iconColor: Colors.green,
            ),
          ],
        ),
        SizedBox(height: 4.0.h),
        Text(
          'ABOUT',
          style: GoogleFonts.poppins(
            fontSize: 1.5.t,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 1.0.h),
        Text(
          user['demands'] ?? 'No about info provided.', // Fetch about section dynamically
          style: TextStyle(
            fontSize: 1.2.t,
          ),
        ),
        SizedBox(height: 2.0.h),
        Text(
          'CONTACT INFO',
          style: GoogleFonts.poppins(
            fontSize: 1.5.t,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 1.h),
        ContactInfoFile(
          icon: Icons.phone_android,
          type: 'Phone',
          info: user['phone_number'] ?? 'N/A', // Fetch phone dynamically
          iconColor: Colors.green,
        ),
        ContactInfoFile(
          icon: Icons.email_sharp,
          type: 'Email',
          info: user['email'] ?? 'N/A',
          iconColor: Colors.red,
        ),
        ContactInfoFile(
          icon: Icons.home,
          type: 'Address',
          info: user['address'] ?? 'N/A',
          iconColor: Colors.blue,
        ),
        SizedBox(height: 2.0.h),
        Text(
          'PERSONAL INFORMATION',
          style: GoogleFonts.poppins(
            fontSize: 1.5.t,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 1.h),
        PersonalInfo(label: 'Name', value: user['full_name'] ?? 'N/A'),
        PersonalInfo(label: 'Family', value: user['family'] ?? 'N/A'),
        PersonalInfo(label: 'Father\'s name', value: user['fathers_name'] ?? 'N/A'),
        PersonalInfo(label: 'Age', value: user['age']?.toString() ?? 'N/A'),
      ],
    );
  }
}
