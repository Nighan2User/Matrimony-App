import 'package:bright_weddings/Component/Dashboard/circular_bullet.dart';
import 'package:bright_weddings/Helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Controller/profile_controller.dart';
import '../../../Helper/colors.dart';
import '../../../View/Profile/ProfileDetails/profile_details.dart';
import '../image_card.dart';

class ProfileList extends StatelessWidget {
  ProfileList({super.key});

  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.separated(
          itemCount: controller.filteredList.length,
          itemBuilder: (BuildContext context, int index) {
            final user = controller.filteredList[index];
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Image
                  Container(
                    width: 22.w, // Slightly increased width
                    height: 22.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ImageCard(imageUrl: user['image_url']),
                  ),
                  SizedBox(width: 5.w),
                  // User Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name
                        Text(
                          user['full_name'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 1.5.t, // Increased font size
                            color: textColor,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        // Address, Age, and Education
                        Wrap(
                          spacing: 1.5.w,
                          runSpacing: 0.5.h,
                          children: [
                            _buildDetailRow("Address", user['address']),
                            _buildDetailRow("Age", user['age']),
                            _buildDetailRow("Education", user['education']),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        // Demands
                        Row(
                          children: [
                            CircularBullet(),
                            SizedBox(width: 0.5.w),
                            Expanded(
                              child: Text(
                                user['demands'],
                                style: GoogleFonts.poppins(
                                  color: textColor,
                                  fontSize: 1.2.t,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        // Buttons
                        Row(
                          children: [
                            _buildActionButton(
                              label: 'View Full Profile',
                              onPressed: () => Get.to(() => ProfileDetails()),
                              color: Colors.white,
                              textColor: Colors.black,
                              borderColor: Colors.black,
                            ),
                            SizedBox(width: 3.w),
                            _buildActionButton(
                              label: 'Get Matches',
                              onPressed: () {
                                controller.getMatches(user);
                                _showMatchedUsersDialog(context);
                              },
                              color: greenColor,
                              textColor: Colors.white,
                              borderColor: Colors.transparent,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Divider(
                color: Color(0xFFE7E7E7),
                thickness: 1.2,
              ),
            );
          },
        ));
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: [
        CircularBullet(),
        SizedBox(width: 0.5.w),
        Text(
          value,
          style: GoogleFonts.poppins(
            color: textColor,
            fontSize: 1.2.t,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required VoidCallback onPressed,
    required Color color,
    required Color textColor,
    required Color borderColor,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 3.h, // Increased height
        width: 30.w, // Adjusted width
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.poppins(
              color: textColor,
              fontSize: 1.2.t,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  void _showMatchedUsersDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: Text(
          "Matched Users",
          style: TextStyle(fontSize: 1.6.t, fontWeight: FontWeight.bold),
        ),
        content: Container(
          width: 70.w,
          color: Colors.transparent,
          child: Obx(() => controller.matchedUsers.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.matchedUsers.length,
                  itemBuilder: (context, index) {
                    final matchedUser = controller.matchedUsers[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(matchedUser['image_url']),
                      ),
                      title: Text(matchedUser['full_name']),
                      subtitle: Text(
                          '${matchedUser['age']} years old, ${matchedUser['education']}'),
                    );
                  },
                )
              : Text(
                  "No matches found.",
                  style: TextStyle(fontSize: 1.4.t, color: textColor),
                )),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              "Close",
              style: TextStyle(fontSize: 1.4.t, color: greenColor),
            ),
          ),
        ],
      ),
    );
  }
}
