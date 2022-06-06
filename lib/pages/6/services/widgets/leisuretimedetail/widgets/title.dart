import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
    required this.experience,
  }) : super(key: key);

  final experience;

  @override
  Widget build(BuildContext context) {
    return Text(experience.toString().split("-")[0],
        style: KTextSytle(
                context: context,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 204, 164, 61))
            .getStyle());
  }
}
