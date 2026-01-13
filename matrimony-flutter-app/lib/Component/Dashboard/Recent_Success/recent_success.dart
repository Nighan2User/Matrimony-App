import 'package:bright_weddings/Component/Dashboard/image_card.dart';
import 'package:bright_weddings/Helper/colors.dart';
import 'package:bright_weddings/Helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentSuccess extends StatelessWidget {
  final List<Map<String, dynamic>> userList;

  RecentSuccess({required this.userList});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10), 
      padding: EdgeInsets.all(12), 
      height: 40.0.h, 
      width: 55.0.w, 
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .5), 
            offset: Offset(0, 6), 
            blurRadius: 10, 
            spreadRadius: 2, 
          ),
        ],
      ),
      child: ListView.separated(
        itemCount: userList.length > 6 ? 6 : userList.length,
        itemBuilder: (BuildContext context, int index) {
          final user = userList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0), // More vertical spacing
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Image
                Container(
                  width: 18.w, // Increased image size
                  height: 18.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ImageCard(imageUrl: user['image_url']),
                  ),
                ),
                SizedBox(width: 6.w), 
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user['full_name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 1.6.t, // Increased font size for better readability
                          color: textColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 0.5.h), // Added space between name and address
                      Text(
                        user['age'],
                        style: GoogleFonts.poppins(
                          color: textColor,
                          fontSize: 1.3.t, // Increased font size for address
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 0.5.h), // Added space between name and address
                      Text(
                        user['address'],
                        style: GoogleFonts.poppins(
                          color: textColor,
                          fontSize: 1.3.t, // Increased font size for address
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Divider(
              color: Color(0xFFE7E7E7),
              thickness: 1.2, // Slightly thicker divider for better visibility
            ),
          );
        },
      ),
    );
  }
}
