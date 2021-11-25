import 'package:flutter/material.dart';
import 'package:naver_crs/common/constants.dart';

class RoundedFormButton extends StatelessWidget {
  const RoundedFormButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.horizontal = 30,
    this.vertical = 30,
    this.fontSize,
    this.width = 0.3,
    this.height = 0.10,
  }) : super(key: key);

  final double horizontal;
  final double vertical;
  final double width;
  final double height;
  final double? fontSize;
  final String label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var isMobile = isMobileDevice() ? 2 : 1;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * width,
        height: MediaQuery.of(context).size.height * height,
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(50)),
        child: Align(
          alignment: Alignment.topCenter,
          child: Text(
            label,
            style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width /
                    MediaQuery.of(context).size.height *
                    isMobile *
                    16,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
