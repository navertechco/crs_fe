import 'package:flutter/material.dart';
import 'package:naver_crs/common/constants.dart';

class RoundedFormButton extends StatelessWidget {
  final double horizontal;
  final double vertical;
  final double width;
  final double height;
  final double? fontSize;
  final String label;
  final void Function()? onTap;

  const RoundedFormButton({
    Key? key,
    required this.label,
    this.horizontal = 10,
    this.vertical = 15,
    this.width = 0.3,
    this.height = 0.10,
    this.fontSize = 0.1,
    required this.onTap,
  }) : super(key: key);

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
            strutStyle: StrutStyle(
              fontSize: MediaQuery.of(context).size.width /
                  MediaQuery.of(context).size.height *
                  isMobile *
                  16,
            ),
            style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width /
                    MediaQuery.of(context).size.height *
                    isMobile *
                    16 *
                    0.8,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
