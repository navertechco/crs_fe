import 'package:flutter/material.dart';
import 'package:naver_crs/common/constants.dart';

class TextFieldName extends StatelessWidget {
  const TextFieldName({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding / 100),
      child: Text(
        text,
        style:
            const TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),
      ),
    );
  }
}
