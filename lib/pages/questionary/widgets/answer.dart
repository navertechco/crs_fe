import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/constants.dart';

// ignore: must_be_immutable
class AnswerWidget extends StatefulWidget {
  AnswerWidget({
    Key? key,
    required this.answer,
    required this.position,
    required this.top,
    required this.left,
  }) : super(key: key);
  Obx answer;
  final String? position;
  final double? top;
  final double? left;

  @override
  State<AnswerWidget> createState() => _AnswerWidgetState();
}

class _AnswerWidgetState extends State<AnswerWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.top,
      left: widget.left,
      child: SizedBox(
        width: Get.width * 0.8,
        height: Get.height * 0.08,
        child: Card(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Positioned(
                              child: SvgPicture.asset(
                                "assets/custom/svg/images/BackgroundSquare.svg",
                                fit: BoxFit.cover, // <-- (1)
                                width: kDefaultPadding * 2.9,
                              ),
                            ),
                            Positioned(
                              top: Get.height * 0.01,
                              left: kDefaultPadding,
                              child: Text(
                                widget.position!,
                                style: TextStyle(
                                  fontSize: Get.height * 0.04,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Spacer(),
                    const Spacer(),
                    const Spacer(),
                    const Spacer(),
                    const Spacer(),
                    const Spacer(),
                    widget.answer,
                    const Spacer(),
                    const Spacer(),
                    const Spacer(),
                    const Spacer(),
                    const Spacer(),
                    const Spacer(),
                    const Spacer(),
                    const Spacer(),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
