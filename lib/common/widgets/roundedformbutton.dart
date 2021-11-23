import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoundedFormButton extends StatelessWidget {
  const RoundedFormButton({Key? key, required this.label, required this.onTap, this.horizontal=30, this.vertical=30, this.width=0.3})
      : super(key: key);

  final double horizontal;
  final double vertical;
  final double width;
  final String label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width * width,
        padding:  EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(36)),
        child: Text(
          label,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
