import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../index.dart';

class ContentLayoutWidget extends StatelessWidget {
  ContentLayoutWidget({Key? key, this.child, this.text, this.background})
      : super(key: key);
  final dynamic child;
  final String? text;
  String? background;
  @override
  Widget build(BuildContext context) {
    var icons = getContext("icons");
    var multiplier = MediaQuery.of(context).orientation == Orientation.landscape
        ? 0.1
        : 0.09;
    String icon = icons[text] ?? "Default";
    return Stack(children: [
      Image.asset(
        background ?? "assets/custom/img/layout.png",
        fit: BoxFit.fill,
        height: double.infinity,
        width: double.infinity,
      ),
      Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * multiplier),
        child: Positioned(
          child: child,
        ),
      ),
      Expanded(
        // top: 0,
        // right: 0,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * multiplier),
                Padding(
                  padding: EdgeInsets.only(
                      top: 0, left: MediaQuery.of(context).size.width * 0.08),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          print("AQUI");
                          Get.back();
                        },
                        child: Text(text! + "                     ",
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontWeight: FontWeight.bold)
                                .copyWith(color: Colors.white)),
                      ),
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
