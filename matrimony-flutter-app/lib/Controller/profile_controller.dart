import 'package:bright_weddings/Helper/size_config.dart';
import 'package:bright_weddings/Mock%20API/user_list.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:popover/popover.dart';

class ProfileController extends GetxController {
  var selectedFile = Rxn<PlatformFile>();
  var selectedFileName = "Update from Device".obs;
  var selectedFileUnicode = ''.obs;
  var isProfileVisible = true.obs;
  var isStatusChangeable = true.obs;
  var filteredList = <Map<String, dynamic>>[].obs;
  var matchedUsers = <Map<String, dynamic>>[].obs;
  var selectedFilter = "Cast".obs;
  var selectedEducationFilter = "Education".obs;
  var filerOptions = <String>[
    "Cast",
    "Sub-cast",
    "Devak",
  ];
  var educationFilterOptions = <String>[
    "B.Tech",
    "B.A",
    "B.Sc",
    "B.E",
    "Farmer",
  ];

  final TextEditingController searchController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    filteredList.value = userList;
  }

  // Existing method for picking files
  Future<void> pickFile(FileType fileType, bool allowMultiple) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: fileType,
        allowMultiple: allowMultiple,
      );

      if (result != null) {
        selectedFile.value = result.files.first;
        selectedFileName.value = selectedFile.value!.name;
      } else {
        print('File selection canceled.');
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  void filterSearch(String query) {
    if (query.isEmpty) {
      filteredList.value = userList;
    } else {
      filteredList.value = userList.where((user) {
        final name = user['full_name']?.toLowerCase() ?? '';
        final email = user['email']?.toLowerCase() ?? '';
        return name.contains(query.toLowerCase()) ||
            email.contains(query.toLowerCase());
      }).toList();
    }
  }

  void getMatches(Map<String, dynamic> currentUser) {
    matchedUsers.value = userList.where((user) {
      return user['age'] == currentUser['age'] ||
          user['education'] == currentUser['education'] ||
          user['cast'] == currentUser['cast'];
    }).toList();
  }

  void filterPopUp(BuildContext context) {
    showPopover(
        direction: PopoverDirection.right,
        height: 10.0.h,
        width: 20.0.w,
        context: context,
        bodyBuilder: (context) {
          return ListView.builder(
              itemCount: filerOptions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    selectedFilter.value = filerOptions[index];
                    Navigator.pop(context);
                  },
                  title: Text(filerOptions[index]),
                );
              });
        });
  }
  void educationFilterPopUp(BuildContext context) {
    showPopover(
        direction: PopoverDirection.right,
        height: 15.0.h,
        width: 20.0.w,
        context: context,
        bodyBuilder: (context) {
          return ListView.builder(
              itemCount: educationFilterOptions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    selectedEducationFilter.value = educationFilterOptions[index];
                    Navigator.pop(context);
                  },
                  title: Text(educationFilterOptions[index]),
                );
              });
        });
  }
}
