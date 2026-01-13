import 'package:bright_weddings/Helper/size_config.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:popover/popover.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import '../Helper/utils.dart';

class EditProfileController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController castController = TextEditingController();
  final TextEditingController subCastController = TextEditingController();
  final TextEditingController devakController = TextEditingController();
  final TextEditingController rasController = TextEditingController();
  final TextEditingController ganController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController demandController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  var currentFormIndex = 0.obs;
  var selectedBloodGroup = "A+ve".obs;
  var selectedGender = "Male".obs;
  var selectedFile = Rxn<PlatformFile>();
  var selectedFileName = "Upload Photo".obs;
  var selectedDate = Rxn<DateTime>();
  var formattedDate = 'Select Date'.obs;
  var selectedFileUnicode = ''.obs;

  void showPopUp(BuildContext context) {
    showPopover(
        direction: PopoverDirection.right,
        height: 17.0.h,
        width: 20.0.w,
        context: context,
        bodyBuilder: (context) {
          return ListView.builder(
              itemCount: bloodGroups.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    selectedBloodGroup.value = bloodGroups[index];
                    Navigator.pop(context);
                  },
                  title: Text(bloodGroups[index]),
                );
              });
        });
  }

  void showPopUp1(BuildContext context) {
    showPopover(
        direction: PopoverDirection.right,
        height: 7.0.h,
        width: 20.0.w,
        context: context,
        bodyBuilder: (context) {
          return ListView.builder(
              itemCount: gender.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    selectedGender.value = gender[index];
                    Navigator.pop(context);
                  },
                  title: Text(gender[index]),
                );
              });
        });
  }

  Future<void> pickFile(FileType fileType) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: fileType,
        allowMultiple: false,
      );

      if (result != null) {
        selectedFile.value = result.files.first;
        selectedFileName.value = selectedFile.value!.name;
        if (fileType == FileType.image) {
          Uint8List? fileBytes;
          if (selectedFile.value!.bytes != null) {
            fileBytes = selectedFile.value!.bytes;
          } else if (selectedFile.value!.path != null) {
            File file = File(selectedFile.value!.path!);
            fileBytes = await file.readAsBytes();
          }
          if (fileBytes != null) {
            String base64String = base64Encode(fileBytes);
            selectedFileUnicode.value = base64String;
          } else {
            selectedFileUnicode.value = '';
          }
        } else {
          selectedFileUnicode.value = '';
        }
      } else {
        print('File selection canceled.');
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  Future<void> pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    selectedDate.value = pickedDate;
    formattedDate.value = DateFormat('dd-MM-yyyy').format(pickedDate!);
    print('Selected date: ${formattedDate.value}');
  }
}
