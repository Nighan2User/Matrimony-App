import 'package:bright_weddings/Component/Dashboard/rating_dots.dart';
import 'package:bright_weddings/Helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Helper/colors.dart';

class ProfileCompletionStatus extends StatelessWidget {
  const ProfileCompletionStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1.0.h),
      width: 43.w,
      height: 30.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 4),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Profile Completion",
                  style: GoogleFonts.playfairDisplay(
                    color: textColor,
                    fontSize: 1.5.t,
                  ),
                ),
                Spacer(),
                Container(
                  width: 5.w,
                  height: 5.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 1, color: Colors.grey),
                  ),
                  child: Icon(Icons.more_vert, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(2.h),
              height: 13.h,
              width: 13.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(width: 1, color: Colors.black),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    offset: Offset(0, 4),
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xFF351FE2),
                      Color(0xFFD1088E),
                    ]),
                    shape: BoxShape.circle),
                child: Text(
                  "90%",
                  style: TextStyle(
                    fontSize: 3.t,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 2.5.h,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RatingDots(
                  color: ratingDot1,
                  text: "12 Likes",
                ),
                SizedBox(width: 3.w),
                RatingDots(
                  color: ratingDot2,
                  text: "12 Likes",
                ),
              ],
            ),
            SizedBox(height: 1.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RatingDots(
                  color: ratingDot3,
                  text: "12 Likes",
                ),
                SizedBox(width: 3.w),
                RatingDots(
                  color: ratingDot4,
                  text: "12 Likes",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
