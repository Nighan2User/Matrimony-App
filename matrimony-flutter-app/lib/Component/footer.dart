import 'package:bright_weddings/Helper/colors.dart';
import 'package:bright_weddings/Helper/path_constants.dart';
import 'package:bright_weddings/Helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = (screenWidth * 0.02).clamp(16.0, 18.0);
    final padding = (screenWidth * 0.05).clamp(20.0, 40.0);

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 40.h.clamp(200, 400),
          width: screenWidth,
          decoration: BoxDecoration(
            color: footerColor,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "GET IN TOUCH",
                    style: GoogleFonts.poppins(
                      fontSize: 1.3.t,
                      color: footerTextColor,
                    ),
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Text(
                    "Address: Imperial Plaza, Kothrud Pune",
                    style: GoogleFonts.poppins(
                      fontSize: 0.9.t,
                      color: footerTextColor,
                    ),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Text(
                    "Phone: +91 1234567890",
                    style: GoogleFonts.poppins(
                      fontSize: 0.9.t,
                      color: footerTextColor,
                    ),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Text(
                    "Email: it.team.instaict@gmail.com",
                    style: GoogleFonts.poppins(
                      fontSize: 0.9.t,
                      color: footerTextColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 4.0.w,
              ),
              Container(
                height: 12.0.h,
                width: 1,
                color: footerTextColor,
              ),
              SizedBox(
                width: 4.0.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "HELP & SUPPORT",
                    style: GoogleFonts.poppins(
                      fontSize: 1.3.t,
                      color: footerTextColor,
                    ),
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "About company",
                              style: GoogleFonts.poppins(
                                fontSize: 0.9.t,
                                color: footerTextColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "Feedback",
                              style: GoogleFonts.poppins(
                                fontSize: 0.9.t,
                                color: footerTextColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "Testimonials",
                              style: GoogleFonts.poppins(
                                fontSize: 0.9.t,
                                color: footerTextColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 8.7.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "Contact us",
                              style: GoogleFonts.poppins(
                                fontSize: 0.9.t,
                                color: footerTextColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "FAQs",
                              style: GoogleFonts.poppins(
                                fontSize: 0.9.t,
                                color: footerTextColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 4.0.w,
              ),
              Container(
                height: 12.0.h,
                width: 1,
                color: footerTextColor,
              ),
              SizedBox(
                width: 4.0.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "SOCIAL MEDIA",
                    style: GoogleFonts.poppins(
                      fontSize: 1.3.t,
                      color: footerTextColor,
                    ),
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: CircleAvatar(
                          backgroundColor: whatsappColor,
                          radius: 1.2.h,
                          child: Center(
                            child: SvgPicture.asset(
                              whatsapp,
                              fit: BoxFit.scaleDown,
                              width: 0.6.w,
                              height: 1.6.h,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 1.2.w,
                      ),
                      InkWell(
                        onTap: () {},
                        child: CircleAvatar(
                          backgroundColor: twitterColor,
                          radius: 1.2.h,
                          child: Center(
                            child: SvgPicture.asset(
                              twitter,
                              fit: BoxFit.scaleDown,
                              width: 0.6.w,
                              height: 1.6.h,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 1.2.w,
                      ),
                      InkWell(
                        onTap: () {},
                        child: CircleAvatar(
                          backgroundColor: facebookColor,
                          radius: 1.2.h,
                          child: Center(
                            child: SvgPicture.asset(
                              facebook,
                              fit: BoxFit.scaleDown,
                              width: 0.6.w,
                              height: 1.6.h,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 1.2.w,
                      ),
                      InkWell(
                        onTap: () {},
                        child: CircleAvatar(
                          backgroundColor: youtubeColor,
                          radius: 1.2.h,
                          child: Center(
                            child: SvgPicture.asset(
                              youtube,
                              fit: BoxFit.scaleDown,
                              width: 0.6.w,
                              height: 1.6.h,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.0.h,
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: -2.5.h,
          child: Container(
            height: 5.0.h.clamp(50.0, 80.0),
            padding: EdgeInsets.symmetric(horizontal: padding),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: footerTitleColor,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              "Free Support: +91 1234567890    |    Email: it.team.instaict@gmail.com",
              style: GoogleFonts.poppins(
                fontSize: fontSize,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
