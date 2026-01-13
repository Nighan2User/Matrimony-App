import 'package:bright_weddings/Helper/size_config.dart';
import 'package:flutter/material.dart';

class CircularBullet extends StatelessWidget {
  const CircularBullet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.h,
      width: 1.w,
      decoration: BoxDecoration(
        color: Color(0xFF68686A),
        shape: BoxShape.circle,
      ),
    );
  }
}
