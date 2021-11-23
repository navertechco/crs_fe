import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/constants.dart';

class ResultsLayoutWidget extends StatefulWidget {
  const ResultsLayoutWidget({Key? key, this.child, this.text})
      : super(key: key);
  final dynamic child;
  final String? text;

  @override
  State<ResultsLayoutWidget> createState() => _ResultsLayoutWidgetState();
}

class _ResultsLayoutWidgetState extends State<ResultsLayoutWidget> {
  double left = kSize.width;

  double top = kSize.height;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(children: [
        Padding(
          padding: EdgeInsets.only(top: 0.0),
          child: SvgPicture.asset(
            "assets/custom/svg/images/GradientPurpleBackground.svg",
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: kDefaultPadding, left: kDefaultPadding),
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
          padding: EdgeInsets.only(
              bottom: kDefaultPadding * 36.5, left: kDefaultPadding * 17),
          child: SvgPicture.asset(
            "assets/custom/svg/images/HeaderLogo.svg",
            height: MediaQuery.of(context).size.height,
          ),
        ),
        Positioned(
          top: kDefaultPadding * 4.5,
          left: kDefaultPadding * 1.4,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.9,
            child: widget.child,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              border: Border.all(
                color: Colors.white,
                width: 0,
              ),
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        )
      ]),
    );
  }
}
