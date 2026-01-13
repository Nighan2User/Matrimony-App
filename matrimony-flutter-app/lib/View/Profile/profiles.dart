import 'package:bright_weddings/Component/AppBar/header.dart';
import 'package:bright_weddings/Component/Dashboard/profile_list/profile_list.dart';
import 'package:bright_weddings/Controller/profile_controller.dart';
import 'package:bright_weddings/Helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Component/Buttons/hollow_button.dart';

class Profiles extends StatelessWidget {
  Profiles({super.key});

  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: Padding(
        padding: EdgeInsets.all(5.w),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 55.w,
                    child: TextFormField(
                      controller: controller.searchController,
                      onChanged: (value){
                        controller.filterSearch(value);
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          focusColor: Colors.transparent,
                          focusedBorder: InputBorder.none,
                          hintText: 'Search Here',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none
                          ),
                          prefixIcon: Icon(Icons.search)
                      ),
                    )
                ),
                SizedBox(width: 3.w,),
                Builder(builder: (buttonContext) {
                  return Obx(() => HollowButton(
                      title: controller.selectedFilter.value,
                      onTap: () {
                        controller.filterPopUp(buttonContext);
                      },
                      height: 3.3.h,
                      width: 25.0.w));
                }),
                SizedBox(width: 3.w,),
                Builder(builder: (buttonContext) {
                  return Obx(() => HollowButton(
                      title: controller.selectedEducationFilter.value,
                      onTap: () {
                        controller.educationFilterPopUp(buttonContext);
                      },
                      height: 3.3.h,
                      width: 25.0.w));
                }),

              ],
            ),
            SizedBox(
              height: 3.h,
            ),
            Expanded(
              child: Center(
                child: Container(
                    width: 130.w,
                    child: ProfileList()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
