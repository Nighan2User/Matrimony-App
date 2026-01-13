import 'package:bright_weddings/Component/Dashboard/image_card.dart';
import 'package:bright_weddings/Helper/colors.dart';
import 'package:bright_weddings/Helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentSuccessTab extends StatelessWidget {
  final List<Map<String, dynamic>> userList;

  RecentSuccessTab({required this.userList});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(20),
      width: screenWidth*0.7,
      height: screenHeight*0.45,
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
      child: ListView.separated(
        itemCount: userList.length > 6 ? 6 : userList.length,
        itemBuilder: (BuildContext context, int index) {
          final user = userList[index];
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  width: screenWidth*0.2,
                  height: screenHeight*0.2, // Made height and width proportional
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ImageCard(imageUrl: user['image_url']), // Corrected the usage
                ),
                SizedBox(width: 5.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['full_name'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 2.0.t,
                          color: textColor
                      ),
                    ),
                    SizedBox(height: 1.0.h,),
                    Text(
                        user['address'],
                        style: GoogleFonts.poppins(
                          color: textColor,
                          fontSize: 1.7.t,
                        )
                    ),
                  ],
                ),
              ],
            ),
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
      ),
    );
  }
}
