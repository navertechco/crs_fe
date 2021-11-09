import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../constants.dart';

class ContentLayoutWidget extends StatelessWidget {
  const ContentLayoutWidget({Key? key, this.child, this.text})
      : super(key: key);
  final dynamic child;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: EdgeInsets.only(top: Get.height * 0.2),
        child: Positioned(
          child: child,
        ),
      ),
      Expanded(
        // top: 0,
        // right: 0,
        child: Stack(
          children: [
            SvgPicture.asset(
              "assets/custom/svg/images/gold_black_rectangle.svg",
              fit: BoxFit.cover,
              height: Get.height * 0.2,
              width: double.infinity,
            ),
            Column(
              children: [
                SizedBox(height: Get.height * 0.04),
                Padding(
                  padding: const EdgeInsets.only(
                      top: kDefaultPadding, left: kDefaultPadding),
                  child: Row(
                    children: [
                      TextButton(
                        child: SvgPicture.asset(
                          "assets/custom/svg/images/LeftArrow.svg",
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      Text(text!,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontWeight: FontWeight.bold)
                              .copyWith(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ]);
  }
}
