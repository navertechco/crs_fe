import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';

class RoundedFormButton extends StatelessWidget {
  final double left;
  final double top;
  final double width;
  final double height;
  final double fontSize;
  final String label;
  final color;
  final Color textColor;
  final void Function()? onPressed;
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
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * isMobile * width,
      height: MediaQuery.of(context).size.height * isMobile * height,
      padding: EdgeInsets.only(
        left: isMobile * left,
        top: isMobile * top,
      ),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(50)),
      child: Align(
        alignment: Alignment.center,
        child: TextButton(
          onPressed: () {
            onPressed!();
          },
          child: Text(
            label,
            strutStyle: StrutStyle(
              fontSize: (MediaQuery.of(context).size.width /
                      MediaQuery.of(context).size.height) *
                  isMobile *
                  fontSize,
            ),
            style: KTextSytle(
                    context: context,
                    fontSize: (MediaQuery.of(context).size.width /
                            MediaQuery.of(context).size.height) *
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
