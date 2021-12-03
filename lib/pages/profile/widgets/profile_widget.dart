import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/constants.dart';
import 'package:naver_crs/common/index.dart';
import 'package:naver_crs/pages/signup/widgets/signupform.dart';
import '../../index.dart';
import '../index.dart';
import 'index.dart';

/// hello
class ProfileWidget extends GetView<ProfileController> {
  ProfileWidget({Key? key}) : super(key: key);
  final GlobalKey _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) { 
 
    return Center(
      child: Stack(
        children: [
          Positioned(
            top: kDefaultPadding * 3,
            left: kDefaultPadding * 7,
            child: CircleAvatar(
              radius: 64.0,
              child: ClipRRect(
                child: GestureDetector(
                  onTap: () async {
                    List<CameraDescription> cameras = [];
                    cameras = await availableCameras();

                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CameraApp(cameras: cameras, ctrl: controller)),
                    );
                  },
                  child: Image.memory(
                      base64Decode(getContext('session')['avatar'])),
                ),
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: kDefaultPadding * 15,
              left: kDefaultPadding * 2,
            ),
            child: SingleChildScrollView(
                child: Column(
              children: [
                SignUpForm(
                    formKey: _formKey, state: SignupState(), profile: true),
                SizedBox(height: kDefaultPadding * 2),
                const GradientButtonWidget(label: "Actualizar"),
              ],
            )),
          ),
        ],
      ),
    );
  }
}

class GradientButtonWidget extends StatelessWidget {
  const GradientButtonWidget({
    Key? key,
    required this.label,
  }) : super(key: key);
  final String? label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          alignment: Alignment.center,
          backgroundColor: MaterialStateProperty.all(
            const Color(0x00000000),
          ),
          shadowColor: MaterialStateProperty.all(
            const Color(0x00000000),
          ),
        ),
        onPressed: () {
          Get.toNamed("/Home");
        },
        child: Stack(
          children: [
            SvgPicture.asset(
              "assets/custom/svg/images/ButtonBackground.svg",
              fit: BoxFit.fill,
              width: kDefaultPadding * 10,
            ),
            Padding(
                padding: EdgeInsets.only(top: 8, left: kDefaultPadding * 2.5),
                child: Text(
                  label!,
                  style:  TextStyle(
                    fontSize: kDefaultPadding,
                    fontWeight: FontWeight.bold,
                  ),
                ))
          ],
        ));
  }
}
