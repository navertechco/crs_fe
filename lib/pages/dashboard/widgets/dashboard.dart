import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/widgets/index.dart';

import '../index.dart';

/// hello
///
///

class DashboardWidget extends GetView<DashboardController> {
  const DashboardWidget({Key? key}) : super(key: key);

  Future<void> share() async {
    await FlutterShare.share(
        title: 'TRVIIA',
        text: 'Entra y juega a crs',
        linkUrl: 'https://www.crs.net/',
        chooserTitle: 'juega crs');
  }

  @override
  Widget build(BuildContext context) {
    RxInt purposecolor = 0xFF000000.obs;
    int yellow = 0xFFC7C7C7;
    return Center(
      widthFactor: double.infinity,
      child: Stack(
        children: [
          //HOME
          Positioned(
            top: Get.height * 0.08,
            left: Get.width * 0.15,
            child: SquareOptionWidget(
                borderRadius: 30.0,
                padding: 20,
                child: Column(
                  children: [
                    SvgPicture.asset('assets/custom/svg/images/checklist.svg',
                        width: Get.width * 0.15),
                    SizedBox(height: Get.height * 0.02),
                    Text(
                      "     Survey       ",
                      style: TextStyle(
                        fontSize: Get.height * 0.025,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                url: "/Survey"),
          ),
          //SHARE
          Positioned(
            top: Get.height * 0.08,
            left: Get.width * 0.51,
            child: InkWell(
              onHover: (value) {
                purposecolor.value = yellow;
              },
              child: SquareOptionWidget(
                  borderRadius: 30.0,
                  padding: 20,
                  child: Column(
                    children: [
                      SvgPicture.asset(
                          'assets/custom/svg/images/dart_person.svg',
                          color: Color(purposecolor.value),
                          width: Get.width * 0.19),
                      SizedBox(height: Get.height * 0.02),
                      Text(
                        "   Purpouses  ",
                        style: TextStyle(
                          fontSize: Get.height * 0.025,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  url: "/Purpouses"),
            ),
          ),
          //HOME
          Positioned(
            top: Get.height * 0.31,
            left: Get.width * 0.15,
            child: SquareOptionWidget(
                borderRadius: 30.0,
                padding: 20,
                child: Column(
                  children: [
                    SvgPicture.asset('assets/custom/svg/images/around.svg',
                        width: Get.width * 0.15),
                    SizedBox(height: Get.height * 0.02),
                    Text(
                      "Destinations  \n",
                      style: TextStyle(
                        fontSize: Get.height * 0.025,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                url: "/Destinations"),
          ),
          //SHARE
          Positioned(
            top: Get.height * 0.31,
            left: Get.width * 0.51,
            child: SquareOptionWidget(
                borderRadius: 30.0,
                padding: 20,
                child: Column(
                  children: [
                    SvgPicture.asset('assets/custom/svg/images/time.svg',
                        width: Get.width * 0.15),
                    SizedBox(height: Get.height * 0.02),
                    Text(
                      "     Activities  \n",
                      style: TextStyle(
                        fontSize: Get.height * 0.025,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                url: "/Activities"),
          ),

          //RESULT
          Positioned(
            top: Get.height * 0.54,
            left: Get.width * 0.15,
            child: SquareOptionWidget(
                borderRadius: 30.0,
                padding: 20,
                child: Column(
                  children: [
                    SvgPicture.asset('assets/custom/svg/images/opportunity.svg',
                        width: Get.width * 0.15),
                    SizedBox(height: Get.height * 0.02),
                    Text(
                      "Opportunities\n",
                      style: TextStyle(
                        fontSize: Get.height * 0.025,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                url: "/Opportunities"),
          ),
          //BUY
          Positioned(
            top: Get.height * 0.54,
            left: Get.width * 0.51,
            child: SquareOptionWidget(
                borderRadius: 30.0,
                padding: 20,
                child: Column(
                  children: [
                    SvgPicture.asset('assets/custom/svg/images/invoice.svg',
                        width: Get.width * 0.15),
                    SizedBox(height: Get.height * 0.02),
                    Text(
                      "      Quote       \n",
                      style: TextStyle(
                        fontSize: Get.height * 0.025,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                url: "/Quote"),
          ),
        ],
      ),
    );
  }
}
