import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/constants.dart';

class ContentLayoutWidget extends StatefulWidget {
  const ContentLayoutWidget({Key? key, this.child, this.text})
      : super(key: key);
  final dynamic child;
  final String? text;

  @override
  State<ContentLayoutWidget> createState() => _ContentLayoutWidgetState();
}

class _ContentLayoutWidgetState extends State<ContentLayoutWidget> {
  double left = kSize.width;

  double top = kSize.height;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: kDefaultPadding * 35),
          child: SvgPicture.asset(
            "assets/custom/svg/images/Header.svg",
            fit: BoxFit.fitWidth,
            height: Get.height,
            width: Get.width,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: kDefaultPadding, left: kDefaultPadding),
          child: Row(
            children: [
              TextButton(
                child: SvgPicture.asset(
                  "assets/custom/svg/images/LeftArrow.svg",
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              Text(widget.text!,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontWeight: FontWeight.bold)
                      .copyWith(color: Colors.white)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              bottom: kDefaultPadding * 35, left: kDefaultPadding * 15),
          child: SvgPicture.asset(
            "assets/custom/svg/images/HeaderLogo.svg",
            height: Get.height,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: kDefaultPadding * 0, top: 70.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: widget.child,
            ),
          ),
        ),
      ]),
    );
  }
}
