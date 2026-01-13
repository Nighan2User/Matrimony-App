import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bright_weddings/Component/Buttons/hollow_button.dart';
import 'package:bright_weddings/Component/Buttons/submit_button.dart';
import 'package:bright_weddings/Component/TextFields/input_field.dart';
import 'package:bright_weddings/Controller/new_registration_controller.dart';
import 'package:bright_weddings/Helper/colors.dart';
import 'package:bright_weddings/View/Dashboard/dashboard_mob.dart';
import 'package:bright_weddings/Helper/size_config.dart';

class InfoFormTwo extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback? onNext;

  InfoFormTwo({super.key, required this.onBack, this.onNext});

  final NewRegistrationController controller =
      Get.find<NewRegistrationController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 3.0.h, horizontal: 5.0.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "JUST A FEW MORE DETAILS",
                style: GoogleFonts.lobster(fontSize: 13,
                fontWeight: FontWeight.bold, color: Color.fromARGB(255, 98, 94, 91)),
              ),
              SizedBox(height: 2.0.h),
              Divider(color: borderColor),
              SizedBox(height: 1.3.h),

              /// **Ras & Gan**
              Row(
                children: [
                  Expanded(
                    child: _buildInputField("Ras:", "Enter Ras", controller.rasController),
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: _buildInputField("Gan:", "Enter Gan", controller.ganController),
                  ),
                ],
              ),

              SizedBox(height: 1.5.h),

              /// **Address**
              _buildInputField("Address:", "Enter Address", controller.addressController),

              SizedBox(height: 1.5.h),

              /// **Phone Number**
              _buildInputField("Phone Number:", "Enter Phone Number", controller.phoneController, keyboardType: TextInputType.phone),

              SizedBox(height: 1.5.h),

              /// **Blood Group & Education**
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Blood Group:",
                          style: GoogleFonts.poppins(fontSize: 0.9.t, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        SizedBox(height: 0.5.h),
                        Obx(() => HollowButton(
                          title: controller.selectedBloodGroup.value,
                          onTap: () => controller.showPopUp(context),
                          height: 3.0.h,
                          width: double.infinity,
                        )),
                      ],
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: _buildInputField("Education:", "Enter Education", controller.educationController),
                  ),
                ],
              ),

              SizedBox(height: 1.5.h),

              /// **Demands (Optional)**
              _buildInputField("Demands:", "Enter Demands (Optional)", controller.demandController),

              SizedBox(height: 5.0.h),

              /// **Buttons**
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: SubmitButton(title: "Go Back", onTap: onBack),
                  ),
                  SizedBox(width: 2.w),
                  Flexible(
                    child: SubmitButton(
                      title: "Save & Next",
                      onTap: () {
                        // TODO: Add form validation before navigating
                        Get.to(() => DashboardMob());
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String hint, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 0.9.t, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        SizedBox(height: 0.5.h),
        InputField(
          labelText: hint,
          controller: controller,
          keyboardType: keyboardType,
        ),
      ],
    );
  }
}
