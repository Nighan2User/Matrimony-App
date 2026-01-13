import 'package:bright_weddings/Helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Mock API/user_list.dart';
import '../image_card.dart';

class NewProfileTab extends StatelessWidget {
  final BuildContext bodyContext;
  const NewProfileTab({super.key, required this.bodyContext});

  @override
  Widget build(bodyContext) {
    return Container(
      width: 150.w,
      height: 25.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: userList.length > 5 ? 5 : userList.length,
        itemBuilder: (BuildContext context, int index) {
          final user = userList[index];
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(
              child: Container(
                width: 23.w,
                height: 18.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: Stack(children: [
                  ImageCard(imageUrl: user['image_url']),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            user['full_name'],
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 2.t,
                              fontWeight: FontWeight.normal,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            user['address'] + '\t\t' + user['age'],
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 1.0.t,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
