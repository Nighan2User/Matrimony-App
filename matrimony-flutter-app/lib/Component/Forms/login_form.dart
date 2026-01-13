import 'package:bright_weddings/Component/Buttons/submit_button.dart';
import 'package:bright_weddings/Component/TextFields/input_field.dart';
import 'package:bright_weddings/Controller/auth_controller.dart';
import 'package:bright_weddings/Helper/colors.dart';
import 'package:bright_weddings/Helper/path_constants.dart';
import 'package:bright_weddings/Helper/size_config.dart';
import 'package:bright_weddings/View/New%20Client%20Registration/new_client_registration.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 130.w,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
              children: [
            Container(
              padding: EdgeInsets.all(3.h),
              width: 35.w,
              decoration: BoxDecoration(
                  color: Color(0xFFFFFAA0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Now", style: GoogleFonts.playfairDisplay(
                    color: textColor,
                    fontSize: 1.8.t
                  ),),
                  Text("Find\nyour life\npartner", style: GoogleFonts.playfairDisplay(
                    color: textColor,
                    fontSize: 2.8.t,
                    fontWeight: FontWeight.bold
                  ),),
                  Text("Easy and fast.", style: GoogleFonts.playfairDisplay(
                    color: textColor,
                    fontSize: 1.8.t
                  ),),
                ],
              ),
            ),
            Positioned(
              bottom: -120,
                child: Image.asset(loginCouplePNG, width: 240,)
            )
          ]),
          Expanded(
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              vertical: 3.0.h,
              horizontal: 17.0.w
            ),
                children: [
                  Text("START THE JOURNEY", style: GoogleFonts.poppins(
                    fontSize: 1.2.t,
                    color: textColor
                  ),),
                  Text("Sign in to Matrimony", style: GoogleFonts.playfairDisplay(
                    fontSize: 2.4.t,
                    color: Color(0xFF333333)
                  ),),
                  RichText(
                    text: TextSpan(
                      text: "Having trouble logging in? ",
                      style: GoogleFonts.poppins(
                          fontSize: 1.0.t,
                          color: textColor
                      ),
                      children: [
                        TextSpan(
                          text: "Click here",
                          style: GoogleFonts.poppins(
                            fontSize: 1.0.t,
                            color: Color(0xFF0B6DDB),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {

                            },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  Divider(
                    color: borderColor,
                  ),
                  SizedBox(
                    height: 1.3.h,
                  ),
                  Text("Phone Number:", style: GoogleFonts.poppins(
                    fontSize: 0.9.t,
                    color: Colors.black,
                  ),),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  InputField(labelText: "Enter Phone Number", controller: controller.phoneController,
                    keyboardType: TextInputType.phone, suffixIcon: IconButton(onPressed: () async{
                    EasyLoading.show(
                        status: 'Sending OTP...'
                    );
                    Future.delayed(Duration(seconds: 3)).then((_){
                      EasyLoading.dismiss();
                      controller.otpSent(true);
                      showDialog(barrierDismissible: true, context: context, builder: (context){
                        return AlertDialog(
                          title: Text("Success!", textAlign: TextAlign.center,),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 8.w,
                                backgroundColor: gradient2Color,
                                child: Icon(Icons.check_rounded, color: textColor, size: 10.w,),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Text("OTP sent successfully!")
                            ],
                          ),
                        );
                      });
                    });


                  }, icon: Icon(Icons.send, color: textColor,),  splashColor: Colors.transparent,),),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Obx(()=> controller.otpSent.value ? Text("OTP:", style: GoogleFonts.poppins(
                    fontSize: 0.9.t,
                    color: Colors.black,
                  ),) : Container()),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Obx(()=> controller.otpSent.value ? InputField(labelText: "Enter OTP", controller: controller.otpController, keyboardType: TextInputType.phone) : Container()),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Obx(() => Row(
                    children: [
                      Checkbox(
                        side: BorderSide(color: darkBorderColor),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3), side: BorderSide(color: darkBorderColor)),
                        value: controller.isRememberMeChecked.value,
                        onChanged: (value) {
                          controller.toggleRememberMe();
                        },
                        activeColor: darkBorderColor,
                      ),
                      Text(
                        "Remember me",
                        style: GoogleFonts.poppins(
                          fontSize: 0.8.t,
                          color: darkBorderColor,
                        ),
                      ),
                    ],
                  )),
                  SizedBox(
                    height: 4.0.h,
                  ),
                  SubmitButton(title: "Signup", onTap: (){
                    Get.to(()=>NewClientRegistration(), transition: Transition.fadeIn);
                  })
                ],
          ))
        ],
      ),
    );
  }
}
