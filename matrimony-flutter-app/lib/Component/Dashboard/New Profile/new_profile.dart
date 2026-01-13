import 'package:bright_weddings/Helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Mock API/user_list.dart';
import '../image_card.dart';

class NewProfile extends StatefulWidget {
  final BuildContext bodyContext;
  const NewProfile({super.key, required this.bodyContext});

  @override
  _NewProfileState createState() => _NewProfileState();
}

class _NewProfileState extends State<NewProfile> with TickerProviderStateMixin {
  Map<int, bool> _hovering = {};
  Map<int, AnimationController> _controllers = {};
  Map<int, Animation<Offset>> _animations = {};

  @override
  void dispose() {
    _controllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      height: 15.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: userList.length > 5 ? 5 : userList.length,
        itemBuilder: (BuildContext context, int index) {
          final user = userList[index];

          _controllers[index] ??= AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 300),
          );

          _animations[index] ??= Tween<Offset>(
            begin: const Offset(0, 0.1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: _controllers[index]!,
            curve: Curves.easeInOut,
          ));

          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: MouseRegion(
              onEnter: (_) {
                setState(() {
                  _hovering[index] = true;
                  _controllers[index]?.forward();
                });
              },
              onExit: (_) {
                setState(() {
                  _hovering[index] = false;
                  _controllers[index]?.reverse();
                });
              },
              child: InkWell(
                child: Container(
                  width: 23.w,
                  height: 18.h,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Stack(
                    children: [
                      SlideTransition(
                        position: _animations[index]!,
                        child: AnimatedOpacity(
                          opacity:  1.0,
                          duration: const Duration(milliseconds: 300),
                          child: ImageCard(imageUrl: user['image_url']),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                user['full_name'],
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 1.t,
                                  fontWeight: FontWeight.bold,
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
                                  fontSize: 0.7.t,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
