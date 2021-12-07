// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart'; 

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
        child: Image.asset(background ?? "assets/custom/img/layout.png",
            fit: BoxFit.fill, height: double.infinity),
      ),
      child,
    ]);
  }
}
