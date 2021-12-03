// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart'; 

class ContentLayoutWidget extends StatelessWidget {
  ContentLayoutWidget(
      {Key? key, this.child, this.text, this.background, this.height = 1})
      : super(key: key);
  final dynamic child;
  final String? text;
  final double height;
  String? background;
  @override
  Widget build(BuildContext context) {
 
    return Stack(children: [
      Expanded(
        flex: 1,
        child: Image.asset(
          background ?? "assets/custom/img/layout.png",
          fit: BoxFit.fill,
          height: MediaQuery.of(context).size.height * height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Padding(
                  padding: EdgeInsets.only(
                      top: 0, left: MediaQuery.of(context).size.width * 0.08),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () { 
                          Get.back();
                        },
                        child: Text(text! + "                     ",
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontWeight: FontWeight.bold)
                                .copyWith(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.02)
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
