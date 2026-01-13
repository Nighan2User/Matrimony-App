import 'package:bright_weddings/Helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Helper/colors.dart';

class CustomSwitchListTile extends StatelessWidget {
  const CustomSwitchListTile({
    Key? key,
    this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String? title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: title == null ? Container() : Text(
        title!,
        style: GoogleFonts.poppins(
          color: textColor,
          fontSize: 1.5.t,
        ),
      ),
      subtitle: subtitle == null ? Container() : Text(
        subtitle!,
        style: GoogleFonts.poppins(
          fontSize: 0.9.t,
        ),
      ),
      value: value,
      onChanged: onChanged,activeColor: Colors.blue,
    );
  }
}
