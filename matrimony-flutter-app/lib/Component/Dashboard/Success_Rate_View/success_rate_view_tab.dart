import 'package:bright_weddings/Component/Dashboard/rating_dots.dart';
import 'package:bright_weddings/Helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Helper/colors.dart';

class SuccessRateViewTab extends StatelessWidget {
  SuccessRateViewTab({super.key});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(1.5.h),
      width: screenWidth*0.7,
      height: screenHeight*0.45,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Success Rate",
                style: GoogleFonts.playfairDisplay(
                  color: textColor,
                  fontSize: 2.0.t,
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
          SizedBox(height: 2.0.h),  // Adjusted the height to avoid overflow
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(2.h),
                height: screenHeight*0.3,
                width: screenWidth*0.3,
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
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xFF351FE2),
                        Color(0xFFD1088E),
                      ]),
                      shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      "90%",
                      style: TextStyle(
                        fontSize: 3.5.t,  // Adjusted the font size to fit
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 2.h,  // Adjusted the height to avoid overflow
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RatingDots(
                          color: ratingDot1,
                          text: "12 Likes",
                        ),
                        RatingDots(
                          color: ratingDot2,
                          text: "12 Likes",
                        ),
                      ],
                    ),
                    SizedBox(height: 1.5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RatingDots(
                          color: ratingDot3,
                          text: "12 Likes",
                        ),
                        RatingDots(
                          color: ratingDot4,
                          text: "12 Likes",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
