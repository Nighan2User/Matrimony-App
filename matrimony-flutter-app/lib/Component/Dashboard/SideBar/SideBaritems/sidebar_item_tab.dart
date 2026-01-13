import 'package:bright_weddings/Helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Helper/colors.dart';

class SidebarItemTab extends StatelessWidget {
  final String title;
  final bool isSelected;
  final String? leadingPath;
  final VoidCallback onTap;

  const SidebarItemTab({super.key, required this.title, required this.isSelected, this.leadingPath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Row(
      children: [
        isSelected ? Container(margin: EdgeInsets.only(right: screenWidth*0.01),height: screenHeight*0.04,width: screenWidth*0.005, color: dashboardSelectedColor,) : Container(margin: EdgeInsets.only(right: 0.8.w),height: 1.5.h,width: 5),
        Container(
          alignment: Alignment.center,
          height: screenHeight*0.065,
          width: screenWidth*0.36,
          decoration: BoxDecoration(
              gradient: isSelected ?LinearGradient(colors: [
                dashboardSelectedOneColor,
                dashboardSelectedTwoColor
              ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight
              ) : null
          ),
          child: ListTile(
            leading: leadingPath!=null ? SvgPicture.asset(leadingPath!) : null,
            isThreeLine: false,
            onTap: onTap,
            title: Text(title, style: GoogleFonts.poppins(fontSize: 2.0.t, color: isSelected ? dashboardSelectedColor : Colors.black),),
          ),
        ),
      ],
    );
  }
}
