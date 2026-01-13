import 'package:bright_weddings/Helper/size_config.dart';
import 'package:flutter/material.dart';

import '../../Helper/colors.dart';

class InfoTile extends StatelessWidget {
  const InfoTile(
      {super.key,
      required this.label,
      required this.value,
      required this.icon,
      required this.iconColor});

  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18.w,
      height: 9.h,
      padding: EdgeInsets.all(2.0.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 4.0.w, color: iconColor),
          SizedBox(height: 1.0.h),
          FittedBox(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 1.0.t,
                color: textColor,
              ),
            ),
          ),
          SizedBox(height: 0.5.h),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 1.3.t,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
