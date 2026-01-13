import 'package:bright_weddings/Component/Buttons/hollow_button.dart';
import 'package:bright_weddings/Component/Buttons/submit_button.dart';
import 'package:bright_weddings/Component/TextFields/input_field.dart';
import 'package:bright_weddings/Controller/new_registration_controller.dart';
import 'package:bright_weddings/Component/Forms/info_form_two.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoFormOne extends StatelessWidget {
  final VoidCallback onNext;

  InfoFormOne({super.key, required this.onNext});

  final NewRegistrationController controller =
      Get.find<NewRegistrationController>();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          width: screenWidth * 0.9, // 90% of screen width
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderSection(screenWidth),
              const SizedBox(height: 20),
              _buildInputField("Name:", "Enter Full Name", controller.nameController),
              _buildDateAndPhotoUpload(),
              _buildInputField("Caste:", "Enter Cast", controller.castController),
              _buildInputField("Subcaste:", "Enter Subcast", controller.subCastController),
              _dropDown(),
              const SizedBox(height: 20),
              _buildSubmitButton(),
              // const SizedBox(height: 20),
              // SubmitButton(title: "Save & Next", onTap: (){}),
            ],
          ),
        ),
      ),
    );
  }


  /// Header Section (Image + Text)
  Widget _buildHeaderSection(double screenWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Left Section (Text + Image)
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text(
              //   "Now",
              //   style: GoogleFonts.playfairDisplay(
              //       color: textColor, fontSize: 18),
              // ),
              Text(
                "Find your life partner",
                style: GoogleFonts.lobster(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFF57C00)),
              ),
              Text(
                "Easy and fast.",
                style: GoogleFonts.lobster(fontSize: 13, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 98, 94, 91)),
              ),
              const SizedBox(height: 10),

              /// Responsive Image
              // Image.asset(
              //   loginCouplePNG,
              //   width: screenWidth * 0.4, // 40% of screen width
              //   fit: BoxFit.cover,
              // ),
            ],
          ),
        ),
      ],
    );
  }

  /// Input Field Builder
  Widget _buildInputField(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: const Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 5),
        InputField(labelText: hint, controller: controller, keyboardType: TextInputType.text),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _dropDown() {
  List<String> options = ["Self", "Brother", "Sister", "Friend", "Relative"];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Profile For", style: _labelStyle()), // Apply label style
      const SizedBox(height: 5),
      Obx(() => Container(
            height: 50, // Ensure height matches other input fields
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey), // Border like other input fields
            ),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10), // Padding similar to input fields
                border: InputBorder.none, // Remove default border
              ),
              hint: Text("Select an option", style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey)), // Default text
              value: controller.selectedProfileFor.value.isEmpty
                  ? null
                  : controller.selectedProfileFor.value,
              items: options.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option, style: GoogleFonts.poppins(fontSize: 16)),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  controller.updateProfileFor(newValue);
                }
              },
              dropdownColor: Colors.white, // Keep dropdown background consistent
              icon: Icon(Icons.arrow_drop_down, color: Colors.black), // Dropdown icon styling
            ),
          )),
      const SizedBox(height: 15),
    ],
  );
}





  /// Date Picker & Photo Upload Section
  Widget _buildDateAndPhotoUpload() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Birthdate Picker
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Birthdate:", style: _labelStyle()),
              const SizedBox(height: 5),
              Obx(() => HollowButton(
                title: controller.formattedDate.value,
                onTap: () => controller.pickDate(Get.context!),
                height: 45,
                width: double.infinity,
              )),
            ],
          ),
        ),
        const SizedBox(width: 15),

        /// Photo Upload Button
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Upload photo:", style: _labelStyle()),
              const SizedBox(height: 5),
              Obx(() => HollowButton(
                title: controller.selectedFileName.value,
                onTap: () => controller.pickFile(FileType.image),
                height: 45,
                width: double.infinity,
              )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
  return SizedBox(
    width: double.infinity,
    child: SubmitButton(
      title: "Save & Next",
      
      onTap: () {
        Get.to(() => InfoFormTwo(
          onBack: () {
            Get.back();
          },
        ),
        
        ); // Navigate to InfoFormTwo screen
      },
    ),
  );
}

  /// Label Text Style
  TextStyle _labelStyle() {
    return GoogleFonts.poppins(
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    );
  }
}
