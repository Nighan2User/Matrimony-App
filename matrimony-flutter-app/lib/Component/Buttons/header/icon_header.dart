import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bright_weddings/Component/AppBar/header.dart';

class IconButtons extends Header{

  IconButtons({super.key});
  @override
  Widget build(context) {
    return Row(
                children: [
                  
                  Expanded(
                    child: Text(
                      "Bright Weddings",
                      style: GoogleFonts.pacifico(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w200,
                        color: Color.fromARGB(255, 252, 78, 55),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              );
  }
}
