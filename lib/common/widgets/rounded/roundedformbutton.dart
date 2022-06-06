import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:naver_crs/common/index.dart';


class RoundedFormButton extends StatelessWidget {
  final double left;
  final double top;
  final double width;
  final double height;
  final double fontSize;
  final String label;
  final color;
  final Color textColor;
  final void Function()? onTap;
  final fontWeight;

  const RoundedFormButton({
    Key? key,
    required this.label,
    this.left = 0,
    this.top = 0,
    this.width = 0.2,
    this.height = 0.05,
    this.fontSize = 8,
    this.color = Colors.black54,
    this.textColor = Colors.black54,
    this.fontWeight = FontWeight.normal,
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
        padding: EdgeInsets.only(
          left: left,
          top: top,
        ),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(50)),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            label,
            strutStyle: StrutStyle(
              fontSize: MediaQuery.of(context).size.width /
                  MediaQuery.of(context).size.height *
                  isMobile *
                  fontSize,
            ),
            style: KTextSytle(
                    context: context,
                    fontSize: MediaQuery.of(context).size.width /
                        MediaQuery.of(context).size.height *
                        isMobile *
                        fontSize,
                    fontWeight: fontWeight,
                    color: textColor)
                .getStyle(),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
