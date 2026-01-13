import 'package:bright_weddings/Helper/size_config.dart';
import 'package:flutter/material.dart';

class ContactInfoFile extends StatelessWidget {
  const ContactInfoFile({super.key, required this.icon, required this.type, required this.info, required this.iconColor});

  final IconData icon;
  final String type;
  final String info;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 4.0.w, color: iconColor),
        SizedBox(width: 2.0.w),
        Text(
          '$type: $info',
          style: TextStyle(fontSize: 1.2.t),
        ),
      ],
    );
  }
}
