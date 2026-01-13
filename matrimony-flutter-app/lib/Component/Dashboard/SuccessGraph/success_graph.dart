import 'package:bright_weddings/Helper/size_config.dart';
import 'package:flutter/material.dart';

class SuccessGraph extends StatelessWidget {
  const SuccessGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 21.h,
      width: 80.w,
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
    );
  }
}
