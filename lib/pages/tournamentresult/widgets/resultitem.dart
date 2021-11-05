
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class ResultItemWidget extends StatelessWidget {
  const ResultItemWidget({
    Key? key,
    required this.title,
    required this.detail,
  }) : super(key: key);

  final Widget title;
  final Widget detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        width: Get.width * 0.6,
        height: Get.height * 0.08,
        child: Card(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Spacer(),
                    title,
                    const Spacer(),
                    detail,
                    const Spacer(),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
