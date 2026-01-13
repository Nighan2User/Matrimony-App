import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bright_weddings/Helper/size_config.dart';
import 'package:bright_weddings/Helper/colors.dart';

class RatingDots extends StatelessWidget {
  final Color color;
  final String text;

  RatingDots({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 3.w,
        ),
        SizedBox(width: 1.w),
        Text(
          text,
          style: GoogleFonts.poppins(
            color: textColor,
            fontSize: 1.0.t
          ),
        ),
      ],
    );
  }
}
