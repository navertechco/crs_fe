import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SquareOptionWidget extends StatelessWidget {
  const SquareOptionWidget(
      {Key? key,
      required this.child,
      this.url,
      this.ontap,
      required this.padding,
      required this.borderRadius})
      : super(key: key);
  final Widget child;
  final String? url;
  final dynamic ontap;
  final double? padding;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        url != null ? Get.toNamed(url.toString()) : ontap();
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(width: 2.0, color: Colors.black),
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
        child: Padding(
          padding: EdgeInsets.all(padding!),
          child: child,
        ),
      ),
    );
  }
}
