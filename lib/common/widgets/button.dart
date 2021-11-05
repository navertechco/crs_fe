import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// Button
class ButtonWidget extends GetView<StatelessWidget> {
  final String url;
  final String text;

 const ButtonWidget(this.url, this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: Get.height * 0.088,
        child: Stack(
          children: [
            Positioned(
              child: Text(text,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontWeight: FontWeight.bold)
                      .copyWith(color: Colors.white)),
              left: Get.width * 0.33,
              top: Get.height * 0.02,
            ),
            Positioned(
              child: IconButton(
                icon: SvgPicture.asset(
                  "assets/custom/svg/images/ButtonBorder.svg",
                ),
                iconSize: Get.height * 0.5,
                onPressed: () {
                  Get.toNamed(url);
                },
              ),
            ),
          ],
        ));
  }
}
