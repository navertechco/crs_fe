// ignore_for_file: file_names

import 'package:flutter_svg/svg.dart';
import 'package:naver_crs/common/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../index.dart';

class SurveyWidget extends GetView<SurveyController> {
  const SurveyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      widthFactor: double.infinity,
      child: Column(
        children: [
          Spacer(flex: 3),
          Text(
            "    Welcome !!!   ",
            style: TextStyle(
              fontSize: Get.height * 0.070,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'You have accessed de survey system, select \nthe option you want to use below.',
            style: TextStyle(
              fontSize: Get.height * 0.020,
              color: Color(0xFF8E8E8E),
            ),
          ),
          Spacer(flex: 1),
          SquareOptionWidget(
              borderRadius: 30.0,
              padding: 15,
              child: Stack(
                children: [
                  SvgPicture.asset('assets/custom/svg/images/grey_user.svg',
                      color: Color(0x818F8C8C), width: Get.width * 0.2),
                  SizedBox(height: Get.height * 0.01),
                  Text(
                    "    Customer\n      Survey       ",
                    style: TextStyle(
                      fontSize: Get.height * 0.050,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              url: "/Survey"),
          Spacer(flex: 1),
          SquareOptionWidget(
              borderRadius: 30.0,
              padding: 15,
              child: Stack(
                children: [
                  SvgPicture.asset('assets/custom/svg/images/tie.svg',
                      color: Color(0xD5494242), width: Get.width * 0.4),
                  SizedBox(height: Get.height * 0.01),
                  Text(
                    "    Employee\n      Survey       ",
                    style: TextStyle(
                      fontSize: Get.height * 0.050,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              url: "/Survey"),
          Spacer(flex: 1),
          SquareOptionWidget(
              borderRadius: 30.0,
              padding: 15,
              child: Stack(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                          'assets/custom/svg/images/grey_database.svg',
                          width: Get.width * 0.25),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.01),
                  Text(
                    "    Survey\n      Database   ",
                    style: TextStyle(
                      fontSize: Get.height * 0.050,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              url: "/Survey"),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}
